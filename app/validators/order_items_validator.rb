class OrderItemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      raise 'Order must be one item from each menu!' unless each_menu?(value)
    rescue Exception => e
      record.errors[attribute] << (options[:message] || e.message)
    end
  end

  private
  def each_menu?(value)
    menu_ids = DayMenu.actual(DateTime.now).items.map { |item| item.menu.id }
    item_menu_ids = value.map { |item| item.menu.id }
    menu_ids.uniq == item_menu_ids.uniq
  end
end
