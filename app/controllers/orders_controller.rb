class OrdersController < ApplicationController
  responders :flash
  respond_to :html

  before_action :authenticate_user!
  before_action :only_one_order!, only: [:new, :create]

  def index
    params[:date] = params[:date].present? ? params[:date].to_datetime.in_time_zone('Moscow').end_of_day : DateTime.now
    @date = params[:date]
    @orders = Order.filter(params.slice(:date, :organization))
    @orders = @orders.where(user: current_user) unless current_user.has_role? :admin

    @day_menu = DayMenu.actual(params[:date])

    respond_with @orders
  end

  def new
    @order = Order.new
    @date = DateTime.now
    @items = DayMenu.actual(@date).items

    respond_with @order
  end

  def create
    @order = current_user.orders.build(order_params)
    @date = DateTime.now
    @items = DayMenu.actual(@date).items

    @order.save
    respond_with @order, location: orders_path
  end

  private

  def order_params
    params.require(:order).permit(item_ids: [])
  end

  def only_one_order!
    unless current_user.today_orders.empty?
      flash[:alert] = 'Sorry only one order par day!'
      redirect_to orders_path
    end
  end
end
