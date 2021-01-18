class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # before_action :verify_user
    # helper_method :current_user
    add_flash_types :info, :error, :warning

    def current_user
        @user = User.find_by(id: session[:user_id])
    end

    def admin
        @user.admin
    end

    def logged_in?
        session[:user_id] != nil
    end
    # private

    
    # def verify_user
    #     redirect_to '/' unless !!current_user
    # end
end
