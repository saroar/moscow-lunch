module OrdersHelper
  def had_order?
    (current_user.has_role? :admin) && (@date.to_date == Date.today) && @orders.where(user: current_user).empty?
  end
end
