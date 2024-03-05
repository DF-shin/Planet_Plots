class PlotsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_plot, only: %i[show new create]

  def index
    @plots = Plot.all
  end

  def show
    @plot = Plot.new
  end

  def create
    @plot = Plot.new(plot_params)
    @plot.user = current_user
    @plot.save
    redirect_to plot_path(@plot)
  end

  def new
    @plot = Plot.new
  end

  private

  def set_plot
    @plot = Plot.find(params[:plot_id])
  end

  def review_params
    params.require(:plot).permit(:name, :description)
  end
end
