class UsersController < ApplicationController
    before_action :authenticate_user, only: [:show]
    
    def create
      user = User.create(user_params)
      if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
        user = User.find_by(id: session[:user_id])
        render json: user
      end
    
  
    private
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

    def authenticate_user
        unless session[:user_id]
          render json: { error: "Not authenticated" }, status: :unauthorized
        end
      end
  end
  