class RegistrationsController < ApplicationController
    allow_unauthenticated_access

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        start_new_session_for @user
        redirect_to root_path, notice: "Welcome! Your account has been created successfully."
      else
        flash.now[:alert] = if @user.errors[:email_address].include?("is already registered")
                             "This email address is already registered. Please sign in or use a different email."
        else
                             "Please correct the errors below."
        end
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
end
