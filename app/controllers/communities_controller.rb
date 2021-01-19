class CommunitiesController < ApplicationController
    def new
        @category = Community.new
    end

    def show
        category = Community.find_by(id: params[:id])
        @posts = Post.where(community_id: category)
    end

    def create
        @category = Community.new(community_params)
        if @category.valid?
            @category.save
        else
            render :new
        end
    end

    private

    def community_params
        params.require(:community).permit(:category)
    end
end
