organizations = Organization.create([
  { name: 'Tandoor' },
  { name: 'Kokoko' },
  { name: 'Oliva' }
])
categories = Menu.create([
  { name: 'First_Course' },
  { name: 'Main_Course' },
  { name: 'Drinks' }
])

first_course_items = Item.create([
  { name: 'Tomato Soup',       price: 100, menu: categories[0] },
  { name: 'Borsh',     price: 80,  menu: categories[0] },
  { name: 'Chicken broth',   price: 110, menu: categories[0] }
])
main_course_items = Item.create([
  { name: 'friendly_token Chicken',     price: 130, menu: categories[1] },
  { name: 'Salmon',        price: 100, menu: categories[1] },
  { name: 'Steak',              price: 110, menu: categories[1] }
])
drinks_items = Item.create([
  { name: 'Black tea', price: 30,  menu: categories[2] },
  { name: 'Coca-Cola', price: 80,  menu: categories[2] },
  { name: 'Beer', price: 140, menu: categories[2] }
])

(0..6).each do |day_id|
  DayMenu.create(
    day_id: day_id,
    items:  first_course_items.sample(3) + main_course_items.sample(3) + drinks_items.sample(3),
    created_at: DateTime.now - 8.days
  )
end
