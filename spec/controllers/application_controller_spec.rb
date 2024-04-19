require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: "Success"
    end
  end

  describe "#authorize" do
    context "when user is logged in" do
      before do
        allow(controller).to receive(:logged_in?).and_return(true)
      end

      it "does not redirect" do
        get :index
        expect(response).to be_successful
      end
    end

    context "when user is not logged in" do
      before do
        allow(controller).to receive(:logged_in?).and_return(false)
      end

      it "redirects to root_url" do
        get :index
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
