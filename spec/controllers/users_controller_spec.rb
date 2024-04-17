require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create(name: "John Doe", email: "john@example.com", password: "password")
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      user = User.create(name: "John Doe", email: "john@example.com", password: "password")
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post :create, params: { user: { name: "John Doe", email: "john@example.com", password: "password", password_confirmation: "password" } }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: { user: { name: "John Doe", email: "john@example.com", password: "password", password_confirmation: "password" } }
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        expect {
          post :create, params: { user: { name: "", email: "john@example.com", password: "password", password_confirmation: "password" } }
        }.to_not change(User, :count)
      end

      it "returns a success response" do
        post :create, params: { user: { name: "", email: "john@example.com", password: "password", password_confirmation: "password" } }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested user" do
        user = User.create(name: "John Doe", email: "john@example.com", password: "password")
        patch :update, params: { id: user.id, user: { name: "Updated Name" } }
        user.reload
        expect(user.name).to eq("Updated Name")
      end

      it "redirects to the user" do
        user = User.create(name: "John Doe", email: "john@example.com", password: "password")
        patch :update, params: { id: user.id, user: { name: "Updated Name" } }
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid parameters" do
      it "returns a success response" do
        user = User.create(name: "John Doe", email: "john@example.com", password: "password")
        patch :update, params: { id: user.id, user: { name: "" } }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create(name: "John Doe", email: "john@example.com", password: "password")
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create(name: "John Doe", email: "john@example.com", password: "password")
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end
end