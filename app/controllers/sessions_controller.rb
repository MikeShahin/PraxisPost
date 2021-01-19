class SessionsController < ApplicationController
    # skip_before_action :verify_user, only: [:new, :create]
    require 'pry'
    def new
        
    end

    def create
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            start_session            
        else
            flash.now[:error] = "Wrong username/password"
            render 'new'
        end
    end

    def facebook
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
          u.password = SecureRandom.hex
        end

        if @user.save
            start_session
        else
            start_session
        end
    end

    def destroy
        session.delete("user_id")
        flash.now[:error] = "Logged out!"
        redirect_to root_path
    end
end

private

    def start_session
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def auth
        request.env['omniauth.auth']
    end