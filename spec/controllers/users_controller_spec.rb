require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        user_params = attributes_for(:user)
        expect {
          post :create, params: { user: user_params }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        user_params = attributes_for(:user)
        post :create, params: { user: user_params }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        user_params = attributes_for(:user, email: nil)
        expect {
          post :create, params: { user: user_params }
        }.not_to change(User, :count)
      end

      it "renders the new template" do
        user_params = attributes_for(:user, email: nil)
        post :create, params: { user: user_params }
        expect(response).to render_template(:new)
      end
    end
  end
end
