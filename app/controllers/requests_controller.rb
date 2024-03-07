class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new

    @request.status = "pending"
    @request.plot_id = request_params[:plot_id]
    @request.user = current_user

    respond_to do |format|
      if @request.save
        format.html { redirect_to requests_path(@request) }
        format.json
      else
        format.html { redirect_to requests_path, status: :unprocessable_entity }
        format.json
      end
    end
  end

  def show
    @request = Request.find(params[:id])
    @plot = @request.plot
    @days = (Date.today - @request.created_at.to_date).to_i
  end

  def update
    @request = Request.find(params[:id])
    @request.status = params[:status]
    @request.save
    redirect_to requests_path
  end

  def index
    @user = current_user
    if @user
      @requests = @user.requests
      @requests_as_owner = @user.requests_as_owner
    else
      redirect_to root_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:plot_id)
  end
end
