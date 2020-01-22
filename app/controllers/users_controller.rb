class UsersController < ApplicationController
    def index
        @user = User.all
        render json: @user
    end

    def create
        @user = User.create user_params
        render json: { 
            user: @user,
            message: "Sign-up Successful for "
         }
    end

    def destroy
    end

    private

    def user_params
        params.require(:user).permit([:username, :password])
    end
end
