class OrderItemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      raise 'Items only Today\'s menu!' unless today_menu?(value)
      raise 'Order must be one item from each menu!' unless each_menu?(value)
      raise 'Order only one item from each menu!' unless only_one_menu?(value)
    rescue Exception => e
      record.errors[attribute] << (options[:message] || e.message)
    end
  end

  private

  def today_menu?(value)
    menu_item_ids = DayMenu.actual(DateTime.now).items.map { |item| item.id }
    order_item_ids = value.map { |item| item.id }
    order_item_ids == (menu_item_ids && order_item_ids)
  end

  def each_menu?(value)
    menu_ids = DayMenu.actual(DateTime.now).items.map { |item| item.menu.id }
    item_menu_ids = value.map { |item| item.menu.id }
    menu_ids.uniq == item_menu_ids.uniq
  end

  def only_one_menu?(value)
    menu_ids = value.map { |item| item.menu.id }
    menu_ids == menu_ids.uniq
  end
end
