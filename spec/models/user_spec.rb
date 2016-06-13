require 'rails_helper'

RSpec.describe User, type: :model do
  context "#generate_authentication_token!" do
    before do
      @user = FactoryGirl.build(:user)
    end

    it "generates a uniue token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generate anther token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
