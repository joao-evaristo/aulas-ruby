require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#reset_password" do
    let(:user) { create(:user, password: "12345678Test") }

    it "changes the user's password" do
      new_password = "12345678Test"
      user.reset_password(new_password)
      expect(user.authenticate(new_password)).to eq(user)
    end

    it "resets the auth_token" do
      auth_token_before_reset = user.auth_token
      user.reset_password("12345678Test")
      expect(user.auth_token).to be_nil
    end

    it "saves the user" do
      expect { user.reset_password("12345678Test") }.to change { user.reload.updated_at }
    end

    it "raises an error if the new password is not provided" do
      expect { user.reset_password(nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
