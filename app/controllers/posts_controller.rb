class PostsController < ApplicationController
    before_action :current_user
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    helper_method :picture?
    
    def index
        homepage_options
    end

    def new
        if !logged_in?
            redirect_to root_path
        elsif nested? # use to pass through @nested instance variable to view page
            @post = Post.new
            @community = Community.find_by(id: params[:community_id]).category.capitalize
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
            redirect_to signin_path, :notice => "Please login to view comments"
        end  
        @comments = @post.comments.all
        @comment = @post.comments.new
        # display pics on show page if url ends with picture extension:
        @url = @post.url.split(".").last
    end

    def edit
        # if the user is not the same one who made the post, or an admin, they cannot edit the post
        if !user_allowed?
            redirect_to root_path, :notice => "You may only edit your own posts!"
        else
            set_post
        end
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post), :notice => "Post successfully updated!"
        else
            render 'new'
        end
    end

    def destroy
        @post.destroy
        redirect_to root_path
    end

    private
    
    def picture?
        extensions = ["jpg", "png", "gif"]
        extensions.include?(@url)
    end

    def nested?
        @nested = params[:community_id]
    end

    def user_allowed?
        session[:user_id] == @post.user_id || admin
    end

    def set_post
        @post = Post.find_by(id: params[:id])
        if @post.nil?
            redirect_to root_path, :notice => "That post does not exist anymore!"
        end
    end

    def homepage_options
        case params[:order]
        when "Newest Posts"
            @posts = Post.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
            @welcome = "All of the newest posts:"
        when "Oldest Posts"
            @posts = Post.paginate(page: params[:page], per_page: 20).order(created_at: :asc)
            @welcome = "All of the posts sorted by oldest:"
        when "Self Posts"
            @posts = Post.paginate(page: params[:page], per_page: 20).self_posts
            @welcome = "All self posts:"
        when "Link Posts" 
            @posts = Post.paginate(page: params[:page], per_page: 20).linked_posts
            @welcome = "All link posts:"
        else
            @posts = Post.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
            @welcome = "All of the newest posts:"
        end
        
        if params[:query] != nil
            @posts = Post.paginate(page: params[:page], per_page: 20).search(params[:query]).order(created_at: :desc)
            render 'index'
        end
        # if community nested show page, filter posts by only that community
        if nested?
            @posts = Post.paginate(page: params[:page], per_page: 20).where(community_id: params[:community_id])
            @description = "#{Community.find_by(id: params[:community_id]).category.capitalize}: #{Community.find_by(id: params[:community_id]).info}"
        end
    end
    
    def post_params
        params.require(:post).permit(:title, :url, :description, :user_id, :community_id)
    end
end
