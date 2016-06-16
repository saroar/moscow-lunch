# require 'rails_helper'
#
# describe Api::SessionsController do
#   describe 'POST #create' do
#     before(:each) do
#       @user = FactoryGirl.create :user, password: '12345678',
#                                         password_confirmation: '12345678'
#     end
#
#     context 'when the credentials are correct' do
#       before(:each) do
#         credentials = { email: @user.email, password: '12345678' }
#         post :create, session: credentials
#       end
#
#       it 'returns the user record correcponding to the given credentials' do
#         @user.reload
#         json_response = JSON.parse(response.body, symbolize_names: true)
#         expect(json_response[:user_auth][:auth_token]).to eql @user.auth_token
#       end
#
#       it { should respond_with 200 }
#     end
#
#     context 'when the credentials are incorrect' do
#       before(:each) do
#         credentials = { email: @user.email, password: 'invalidpassword' }
#         post :create, session: credentials
#       end
#
#       it 'return a json with an error' do
#         expect(json_response[:errors]).to eql 'Invalid email or password'
#       end
#
#       it { should respond_with 422 }
#     end
#   end
#
#   describe 'DELETE #destroy' do
#     before(:each) do
#       @user = FactoryGirl.create :user
#       sign_in @user
#       delete :destroy, id: @user.auth_token
#     end
#
#     it { should respond_with 204 }
#   end
# end
