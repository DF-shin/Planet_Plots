class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new
    @request.status = 'pending'
    if @request.save
      redirect_to request_path(@request)
    else
      redirect_to request_error_path
    end
  end

  def show
    @request = Request.find(params[:id])
    @plot = @request.plot
    @days = (Date.today - @request.created_at.to_date).to_i
  end

  def update
    raise
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

  end
end
