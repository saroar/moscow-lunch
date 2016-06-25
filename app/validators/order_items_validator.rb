class OrderItemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    raise 'Order must be one item from each menu!' unless each_menu?(value)
    raise 'Items must be from today\'s menu!' unless contains_in_today_menu?(value)
    raise 'Order can contain only one item for each menu!' unless only_one_per_menu?(value)
  rescue Exception => e
    record.errors[attribute] << (options[:message] || e.message)
  end

  private
  def contains_in_today_menu?(value)
    menu_item_ids  = DayMenu.actual(DateTime.now).items.map { |item| item.id }
    order_item_ids = value.map { |item| item.id }
    order_item_ids == (menu_item_ids & order_item_ids)
  end

  def each_menu?(value)
    menu_ids = DayMenu.actual(DateTime.now).items.map { |item| item.menu.id }
    item_menu_ids = value.map { |item| item.menu.id }
    menu_ids.uniq == item_menu_ids.uniq
  end

  def only_one_per_menu?(value)
    menu_ids = value.map { |item| item.menu.id }
    menu_ids == menu_ids.uniq
  end
end
