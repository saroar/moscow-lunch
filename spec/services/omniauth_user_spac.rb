require 'rails_helper'

RSpec.describe OmniauthUser do
  subject(:omniauth_user) { OmniauthUser.new(@auth, @originsation) }

  context '.from_omniauth' do
    before do
      FactoryGirl.create_list(:user, 5)
      @organization = FactoryGirl.create(:organization)
      @auth_info = double('info',
                          name: Faker::Name.name,
                          email: Faker::Internet.email)
      @auth = double('auth',
                     provider: 'google_oauth2',
                     uid: '107682192994779282944',
                     info: @auth_info)
    end

    context 'when use does not exist' do
      context 'create a new user' do
        it do
          expect do
            omniauth_user.find_or_create(@auth, @organization)
          end.to change(User, :count).by(1)
        end

        context 'with given data' do
          before do
            @new_user = omniauth_user.find_or_create(@auth, @organization)
          end

          it { expect(@new_user.provider).to eq(@auth.provider) }
          it { expect(@new_user.uid).to      eq(@auth.uid) }
          it { expect(@new_user.name).to     eq(@auth.info.name) }
          it { expect(@new_user.email).to    eq(@auth.info.email) }
        end
      end
    end

    context 'when your already exist' do
      context 'with given provider and uid' do
        before do
          @new_user = FactoryGirl.create(:user, provider: @auth.provider, uid: @auth.uid, organization: @organization)
        end

        it do
          expect do
            omniauth_user.find_or_create(@auth, @organization)
          end.to change(User, :count).by(0)
        end
        it { expect(omniauth_user.find_or_create(@auth, @organization)).to eql(@new_user) }
      end

      context 'with given email' do
        before do
          @new_user = FactoryGirl.create(:user, email: @auth.info.email, organization: @organization)
        end
        it do
          expect do
            omniauth_user.find_or_create(@auth, @organization)
          end.to change(User, :count).by(0)
        end
        it { expect(omniauth_user.find_or_create(@auth, @organization)).to eq(@new_user) }
      end
    end
  end
end
