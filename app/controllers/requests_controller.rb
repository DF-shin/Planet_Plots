class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.save
    redirect_to requests_path
  end

  def index
    @user = current_user
    if @user
      @requests = @user.requests
    else
      redirect_to root_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:status)
  end
end
