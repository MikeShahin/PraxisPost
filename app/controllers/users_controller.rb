class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        if !logged_in?
            redirect_to signin_path, :notice => "Please sign in to view a users page"
        end 

        @posts = @user.posts.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    end

    def index
        if !logged_in?
            redirect_to signin_path
        else 
            @users = User.all
            @user = current_user
        end
    end

    def edit
        if !verify_user
            redirect_to root_path
        end
    end

    def update
        if @user.update(user_params)
            redirect_to user_path(@user), :notice => "info successfully updated!"
        else
            render 'new'
        end
    end
    
    private

    def set_user
        @user = User.find_by(id: params[:id])
    end
    
    def verify_user
        session[:user_id] == @user.id
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :uid)
    end
end
