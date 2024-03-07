class PlotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_plot, only: %i[show edit update]

  def index
    @plots = Plot.where.not(user_id: current_user)
    @request = Request.new
  end

  def show
    @plot = Plot.find(params[:id])
    @request = Request.new
  end

  def new
    @plot = Plot.new
    @planets = Planet.all.map(&:name) # Collect all planet names for the Select2 field
  end

  def create
    @plot = current_user.plots.build(plot_params.except(:planet_id))
    planet_identifier = params[:plot][:planet_id]

    if planet_identifier.present?
      if planet_identifier.to_i > 0
        # It's an existing planet ID
        @plot.planet_id = planet_identifier
      else
        # It's a new planet name
        new_planet = Planet.find_or_create_by(name: planet_identifier)
        @plot.planet = new_planet
      end
    end

    if @plot.save
      redirect_to @plot, notice: 'Plot was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end


  def search_planets
    if params[:term].present?
      @planets = Planet.where("name ILIKE ?", "%#{params[:term]}%")
    else
      @planets = Planet.all
    end

    render json: @planets.map { |planet| { id: planet.id, text: planet.name } }
  end

  def update
    planet_identifier = params[:plot][:planet_id]

    if planet_identifier.present?
      if planet_identifier.to_i > 0
        @plot.planet_id = planet_identifier
      else
        # It's a new planet name
        new_planet = Planet.find_or_create_by(name: planet_identifier)
        @plot.planet = new_planet
      end
    end

    if @plot.update(plot_params)
      redirect_to @plot, notice: 'Plot was successfully updated.'
    else
      @planets = Planet.all.map { |p| [p.name, p.id] } # Reload planets for form
      render :edit, status: :unprocessable_entity
    end
  end

  def my_plots
    @plots = current_user.plots # Assuming you have an association set up
  end


  private

  def set_plot
    @plot = Plot.find_by(id: params[:id])
    redirect_to(root_url, alert: "Plot not found.") unless @plot
  end

  def plot_params
    params.require(:plot).permit(:name, :description, :price, :planet_id, :new_planet_name, :photo)
  end
end
