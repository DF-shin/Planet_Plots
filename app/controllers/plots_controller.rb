class PlotsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_plot, only: %i[show new create]

  def index
    @plots = Plot.all
    @request = Request.new
  end

  def show
    @plot = Plot.find(params[:id])
  end

  def new
    @plot = Plot.new
  end

  def create
    @plot = Plot.new(plot_params)
    @plot.user = current_user
    if @plot.save
      redirect_to plot_path(@plot), notice: 'Plot was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_plot
    @plot = Plot.find_by(id: params[:id])
    redirect_to(root_url, alert: "Plot not found.") unless @plot
  end

  def plot_params
    params.require(:plot).permit(:name, :description, :planet_id)
  end
end
