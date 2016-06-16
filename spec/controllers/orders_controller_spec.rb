require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before (:each) do
    @admin = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)

    @today_date = DateTime.now
    @another_date = DateTime.now - 1.day
  end

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:only_one_order!) }

  describe 'GET #index' do
    before do
      @day_menu = FactoryGirl.create(:day_menu)
      @day_menu_2 = FactoryGirl.create(:day_menu, day_id: @another_date.wday, created_at: @another_date)

      @order_1 = FactoryGirl.build(:order, user: @admin, created_at: @today_date).save(validate: false)
      @order_2 = FactoryGirl.build(:order, user: @user, created_at: @today_date).save(validate: false)

      @order_3 = FactoryGirl.build(:order, user: @admin, created_at: @another_date).save(validate: false)
      @order_4 = FactoryGirl.build(:order, user: @user, created_at: @another_date).save(validate: false)
    end

    context 'when user is logged in' do
      context 'as admin' do
        before do
          sign_in @admin
        end

        context 'without params' do
          it 'renders the index template' do
            get :index, format: :html
            expect(response).to render_template('index')
          end

          it 'should assert date for today' do
            expect assigns(:date) == DateTime.now
          end

          it 'should assert day menu for today' do
            expect assigns(:day_menu) == @day_menu
          end

          it 'should assert orders for today date' do
            expect assigns(:orders) == Order.where(created_at: @today_date.beginning_of_day..@today_date.end_of_day)
          end
        end

        context 'with date params' do
          it 'renders the index template' do
            get :index, date: @another_date.strftime('%d-%m-%Y'), format: :html
            expect(response).to render_template('index')
          end

          it 'should assert date for date in params' do
            expect assigns(:date) == @another_date.end_of_day
          end

          it 'should assert day menu for date in params' do
            expect assigns(:day_menu) == @day_menu_2
          end

          it 'should assert orders for date in params' do
            expect assigns(:orders) == Order.where(created_at: @another_date.beginning_of_day..@another_date.end_of_day)
          end
        end
      end

      context 'as user' do
        before do
          sign_in @user
        end

        context 'without params' do
          it 'renders the index template' do
            get :index, format: :html
            expect(response).to render_template('index')
          end

          it 'should assert date for today' do
            expect assigns(:date) == DateTime.now
          end

          it 'should assert day menu for today' do
            expect assigns(:day_menu) == @day_menu
          end

          it 'should assert orders for today date' do
            expect assigns(:orders) == Order.where(created_at: @today_date.beginning_of_day..@today_date.end_of_day).where(user: @user)
          end
        end

        context 'with date params' do
          it 'renders the index template' do
            get :index, date: @another_date.strftime('%d-%m-%Y'), format: :html
            expect(response).to render_template('index')
          end

          it 'should assert date for date in params' do
            expect assigns(:date) == @another_date.end_of_day
          end

          it 'should assert day menu for date in params' do
            expect assigns(:day_menu) == @day_menu_2
          end

          it 'should assert orders for date in params' do
            expect assigns(:orders) == Order.where(created_at: @another_date.beginning_of_day..@another_date.end_of_day).where(user: @user)
          end
        end
      end
    end

    context 'when user is logged out' do
      it 'redirect to the new_user_session' do
        get :index, format: :html
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    before do
      @day_menu = FactoryGirl.create(:day_menu)
      @day_menu_2 = FactoryGirl.create(:day_menu, day_id: @another_date.wday, created_at: @another_date)

      @valid_attributes = {
        item_ids: [@day_menu.items[0].id, @day_menu.items[3].id, @day_menu.items[6].id]
      }
      @invalid_attributes = {
        item_ids: [@day_menu_2.items[0].id, @day_menu_2.items[3].id, @day_menu_2.items[6].id]
      }
    end

    context 'when logged in' do
      before do
        sign_in @user
      end

      describe 'with valid params' do
        it 'creates a new order' do
          expect do
            post :create, order: @valid_attributes, format: :html
          end.to change(Order, :count).by(1)
        end

        it 'assigns a newly created order as @order' do
          post :create, order: @valid_attributes, format: :html
          expect(assigns(:order)).to be_a(Order)
          expect(assigns(:order)).to be_persisted
        end

        it 'redirects to the created order and set flash' do
          post :create, order: @valid_attributes, format: :html
          expect(response).to redirect_to(orders_path)
          should set_flash[:notice].to('Order was successfully created.')
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved order as @order' do
          expect do
            post :create, order: @invalid_attributes, format: :html
          end.to change(Order, :count).by(0)
        end

        it 're-renders the new template' do
          post :create, order: @invalid_attributes, format: :html
          expect(response).to render_template('new')
        end
      end

      describe 'when user already make order today' do
        before do
          @order = FactoryGirl.create(:order, user: @user, items: [@day_menu.items[0], @day_menu.items[3], @day_menu.items[6]])
        end

        it 'assigns a newly created but unsaved order as @order' do
          expect do
            post :create, order: @valid_attributes, format: :html
          end.to change(Order, :count).by(0)
        end

        it 'redirects to index' do
          post :create, order: @valid_attributes, format: :html
          expect(response).to redirect_to(orders_path)
        end

        it 'set flash' do
          post :create, order: @valid_attributes, format: :html
          should set_flash[:alert].to('Sorry only one order par day!')
        end
      end
    end

    context 'when logged out' do
      it 'redirect to the new_user_session' do
        post :create, order: @valid_attributes, format: :html
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #new' do
    context 'when logged in' do
      before do
        @day_menu = FactoryGirl.create(:day_menu)
        sign_in @user
      end

      it 'renders the new template' do
        get :new, format: :html
        expect(response).to render_template('new')
      end

      it 'should assert date for today' do
        expect assigns(:date) == DateTime.now
      end

      it 'should assert day menu for today' do
        expect assigns(:day_menu) == @day_menu
      end

      it 'should assert order' do
        expect assigns(:order) == Order.new
      end

      describe 'when user already make order today' do
        before do
          @order = FactoryGirl.create(:order, user: @user, items: [@day_menu.items[0], @day_menu.items[3], @day_menu.items[6]])
        end

        it 'redirects to index' do
          get :new, format: :html
          expect(response).to redirect_to(orders_path)
        end

        it 'set flash' do
          get :new, format: :html
          should set_flash[:alert].to('Sorry only one order par day!')
        end
      end
    end

    context 'when logged out' do
      it 'redirect to the new_user_session' do
        get :new, format: :html
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
