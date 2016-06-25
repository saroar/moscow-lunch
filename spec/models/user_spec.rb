# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :integer
#  last_sign_in_ip        :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  organization_id        :integer
#  uid                    :string
#  provider               :string
#  auth_token             :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'callback' do
    it { is_expected.to callback(:become_admin!).before(:create) }
    it { is_expected.to callback(:generate_authentication_token!).before(:create) }
  end

  context 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should belong_to(:organization) }
  end

  context 'validation' do
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(100) }

    # it { should validate_presence_of :organization }
    it { should validate_presence_of :email }
  end


  context '#become_admin!' do
    before do
      @user = FactoryGirl.build(:user)
    end

    context 'when current user is first' do
      it { expect { @user.send(:become_admin!) }.to change { @user.has_role? :admin }.from(false).to(true) }
    end

    context 'when current user isnot first' do
      before do
        FactoryGirl.create(:user)
      end
      it { expect { @user.send(:become_admin!) }.to_not change { @user.has_role? :admin } }
    end
  end

  context '#generate_authentication_token!' do
    before do
      @user = FactoryGirl.build(:user)
    end

    it 'generates a uniue token' do
      allow(Devise).to receive(:friendly_token).and_return('auniquetoken123')
      @user.send(:generate_authentication_token!)
      expect(@user.auth_token).to eql 'auniquetoken123'
    end

    it 'generate anther token when one already has been taken' do
      existing_user = FactoryGirl.create(:user, auth_token: 'auniquetoken123')
      @user.send(:generate_authentication_token!)
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
