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
    @requests = Request.all
  end

  private

  def request_params
    params.require(:request).permit(:status)
  end
end
