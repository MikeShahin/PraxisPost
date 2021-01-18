class SessionsController < ApplicationController
    # skip_before_action :verify_user, only: [:new, :create]
    require 'pry'
    def new
        
    end

    def create
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash.now[:error] = "Logged"
            redirect_to user_path(@user)            
        else
            flash.now[:error] = "Wrong username/password"
            render 'new'
        end
    end

    def facebook
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
        end
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def destroy
        session.delete("user_id")
        flash.now[:error] = "Logged out!"
        redirect_to root_path
    end
end

private

  def auth
    request.env['omniauth.auth']
  end