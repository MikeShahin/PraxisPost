class CommentsController < ApplicationController
    def new
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(parent_id: params[:parent_id])
      end

    def create
      @comment = Comment.new(comment_params)
      @comment.user_id = session[:user_id]
      if @comment.valid?
        @comment.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
    end

    def show
    end

    private

    def comment_params
      params.require(:comment).permit(:reply, :user_id, :post_id)
    end

end
