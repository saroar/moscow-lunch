require 'rails_helper'

describe Api::OrdersController do
  before(:each) { request.headers['Accept'] = "application/vnd.moscow-lunch, #{Mime::JSON}" }
  before(:each) { request.headers['Content-type'] = Mime::JSON.to_s }

  describe 'GET #index' do
    before(:each) do
      @user_1 = FactoryGirl.create :user
      @user_2 = FactoryGirl.create :user, organization: @user_1.organization
      @user_3 = FactoryGirl.create :user
      @user_4 = FactoryGirl.create :user

      @today_date = DateTime.now
      @another_date = DateTime.now - 1.day

      day_menu = FactoryGirl.create :day_menu
      items = [day_menu.items[0], day_menu.items[3], day_menu.items[6]]

      another_day_menu = FactoryGirl.create :day_menu, created_at: @another_date
      another_day_items = [another_day_menu.items[0], another_day_menu.items[3], another_day_menu.items[6]]

      @order_1 = FactoryGirl.create :order, user: @user_1, items: items
      @order_2 = FactoryGirl.build(:order, user: @user_1, items: another_day_items, created_at: @another_date).save(validate: false)

      @order_3 = FactoryGirl.create :order, user: @user_2, items: items
      @order_4 = FactoryGirl.create :order, user: @user_3, items: items
      @order_5 = FactoryGirl.create :order, user: @user_3, items: items

      api_authorization_header @user_1.auth_token
    end

    describe 'when your authorized successfully' do
      before { get :index }
      context 'without params' do
        it 'it return order record for today' do
          orders_response = json_response[:orders]
          expect(orders_response).to have(4).items
        end
        it { should respond_with 200 }
      end

      context 'wtih data praram' do
        before { get :index, date: @another_date.strftime('%d-%m-%Y') }
        it 'return orders records for date from params' do
          orders_response = json_response[:orders]
          expect(orders_response).to have(1).items
        end
        it { should respond_with 200 }
      end

      context 'with organization param' do
        before { get :index, organization: @user_1.organization.name }

        it 'return orders records for organization from params' do
          orders_response = json_response[:orders]
          expect(orders_response).to have(2).items
        end
        it { should respond_with 200 }
      end

      context 'with date and organization params' do
        before { get :index, date: @today_date.strftime('%d-%m-%Y'), organization: @user_1.organization.name }

        it 'returns orders records for organization and date from params' do
          orders_response = json_response[:orders]
          expect(orders_response).to have(2).items
        end
        it { should respond_with 200 }
      end
    end
  end
end
