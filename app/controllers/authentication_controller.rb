require "jwt"

class AuthenticationController < ApplicationController
    def login
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by username: username

        if !@user
            render status: :unauthorized
        else
            if !@user.authenticate password
                render status: :unauthorized
            else
                secret = Rails.application.secrets.secret_key_base
                token = JWT.encode({
                    user_id: @user.id,
                    username: @user.username
                }, secret)

                render json: {
                    token: token,
                    username: @user.username
                }
            end
        end
    end
end
