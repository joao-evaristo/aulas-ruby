require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    context "with valid credentials" do
      let(:user) { create(:user, email: "user@example.com", password: "12345678Test") }

      it "signs in the user and redirects to the user's profile" do
        post :create, params: { session: { email: user.email, password: "12345678Test" } }
        expect(controller.current_user).to eq(user)
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "with invalid credentials" do
      it "renders the new template" do
        post :create, params: { session: { email: "invalid@example.com", password: "invalid" } }
        expect(response).to render_template(:new)
      end
    end
  end
end
