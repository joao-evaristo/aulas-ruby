class AdminController < ApplicationController
    before_action :authorize_admin
  
    def admin_only
        @users = User.all
    end
  
    private
  
    def authorize_admin
      unless current_user && current_user.role? && current_user.role == "admin"
        flash[:alert] = "Acesso negado. Você não tem permissão para visualizar esta página."
        redirect_to root_path
      end
    end
  end
  