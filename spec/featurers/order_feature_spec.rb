require 'rails_helper'

RSpec.feature 'Order', type: :feature do
  before (:each) do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)

    @today_menu = FactoryGirl.create(:day_menu)
  end

  feature 'Add new' do
    subject { page }

    feature 'with logged in user' do
      before (:each) do
        login_as(@user, scope: :user)
        visit '/orders/new'
      end

      subject { page }

      it { should have_button 'Create Order' }

      it 'should have each menu' do
        Menu.all do |menu|
          should have_content menu.name
        end
      end

      it 'should have each item' do
        Item.all.each do |item|
          should have_content item.name
        end
      end

      scenario 'with valid data' do
        all('select').each do |select|
          select.find(:xpath, 'option[2]').select_option
        end

        click_button 'Create Order'

        expect(current_path).to eql('/orders')

        should have_content 'Order was successfully created.'

        Order.last.items.each do |item|
          should have_content item.name
        end

        should_not have_link 'Place your order'
      end

      scenario 'with invalid data' do
        click_button 'Create Order'

        expect(current_path).to eql('/orders')

        should have_content 'can\'t be blank'
      end
    end

    feature 'with log out user' do
      before (:each) do
        visit 'orders/new'
      end

      it { should_not have_link 'WeekDays menu' }

      it { expect(current_path).to eql('/users/sign_in') }
      it { should have_content 'You need to sign in or sign up before continuing.' }
    end

    feature 'First Course Menu' do
      before (:each) do
        login_as(@user, scope: :user)
        visit '/orders/new'
      end

      it 'should have first menu' do
        Menu.first.items do |ft|
          should have_content ft.name
        end
      end

      scenario 'when user select two items from the First Course menu' do
        all('select').each do |select|
          o1 = select.find(:xpath, 'option[1]').select_option
          o2 = select.find(:xpath, 'option[2]').select_option
          o1 = nil

          expect(o1).to eql(nil)
          expect(o2).to eql('selected')
        end



        # # expect(find('select').find(:xpath, 'option[2]').select_option).to eql("selected")
        # # find('#order_item_ids').find("option[value='2']").click
        #
        # Menu.first.items.all.each do |fmi|
        #   binding.pry
        #
        # end
        # option1 = Menu.first.items[1]
        # option2 = Menu.first.items[2]
        # binding.pry
        #
        # #select(option1.id, from: option.ids)
        # #
        # # choose(option1.id)
        # # choose(option2.id)
        # #
        # #
        # # expect(choose(option2.id)).to qql("checked")
      end
    end
  end
end
