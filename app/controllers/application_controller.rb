class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    add_flash_types :notice, :error

    def current_user
        @user = User.find_by(id: session[:user_id])
    end

    def admin
        @user.admin
    end

    def logged_in?
        session[:user_id] != nil
    end

end
