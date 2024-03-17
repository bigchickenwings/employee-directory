class EmployeesController < ApplicationController
  before_action :start_fetcher

  def index
    @employees = @employee_fetcher.page(page_params).all
    @current_page = page_params.to_i
    @total_pages = @employee_fetcher.total_pages
  end

  def show
    @employee = @employee_fetcher.find(params[:id])
  end

  private

  def start_fetcher
    @employee_fetcher = Reqres::EmployeeFetcher.new
  end

  def page_params
    params[:page] ? params.require(:page) : 1
  end
end
