class Api::OrdersController < ApplicationController
  respond_to :json

  def index
    params[:date] = params[:date].present? ? params[:date].to_datetime.in_time_zone('Moscow').end_of_day : DateTime.now
    orders = Order.filter(params.slice(:date, :organization))

    respond_with orders
  end
end
