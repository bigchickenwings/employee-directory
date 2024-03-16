class EmployeesController < ApplicationController
  before_action :start_fetcher

  def index
    @employees = @employee_fetcher.page(page_params).all
  end

  def show
    @employee = @employee_fetcher.find(params[:id])
  end

  private

  def start_fetcher
    @employee_fetcher = Reqres::EmployeeFetcher.new
  end

  def page_params
    params.require(:page) if params[:page]
  end
end
