class PostsController < ApplicationController
    before_action :current_user
    before_action :set_post, only: [:show, :update, :destroy]
    require 'pry'
    def index
        # if params[:query] != ""
        #     @posts = Post.search(params[:query])
        #     render 'index'
        if params[:order] == "Newest Posts" || params[:order] == nil
            @posts = Post.all.order(created_at: :desc)
        elsif params[:order] == "Oldest Posts"
            @posts = Post.all.order(created_at: :asc)
        end
        if params[:query] != nil
            @posts = Post.search(params[:query]).order(created_at: :desc)
            render 'index'
        end
    end

    def new
        if !current_user
            redirect_to root_path
        else
            @post = Post.new
        end
    end

    def create
        @post = Post.new(post_params)
        if @post.valid?
            @post.save
            redirect_to post_path(@post)
        else
            render :new
        end
    end

    def show
        if !logged_in?
            #flash
            redirect_to signin_path
        end  
        @user = User.find_by(id: session[:user_id])
        @comments = @post.comments.all
        @comment = @post.comments.new
    end

    def edit
        if session[:user_id] != Post.find_by(id: params[:id]).user_id && !admin
            redirect_to root_path
        else
            set_post
        end
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end

    def destroy
        @post.destroy
        redirect_to root_path
    end

    private

    def set_post
        @post = Post.find_by(id: params[:id])
        if @post.nil?
            flash[:error] = "Post does not exist"
            redirect_to root_path
        end
    end
    
    def post_params
        params.require(:post).permit(:title, :url, :description, :user_id)
    end
end
