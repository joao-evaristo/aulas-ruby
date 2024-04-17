class PasswordResetsController < ApplicationController
    def edit
      @user = User.find_by(auth_token: params[:auth_token])
      if @user
        # renderizar formulário para inserir nova senha
      else
        flash[:alert] = "Invalid token. Please try again."
        redirect_to root_url
      end
    end
  
    def update
      @user = User.find_by(auth_token: params[:auth_token])
      if @user && @user.reset_password(params[:password])
        flash[:notice] = "Password reset successfully."
        redirect_to root_url
      else
        flash[:alert] = "Invalid token or password. Please try again."
        render :edit
      end
    end
  end
  