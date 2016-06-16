require 'rails_helper'

describe Api::UsersController do
  before(:each) { request.headers['Accept'] = 'application/vnd.moscow-lunch' }

  describe 'GET #show' do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it 'return reporter on a hash' do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:user][:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end
end
