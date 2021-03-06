class CommunitiesController < ApplicationController
    before_action :current_user
    def new
        @community = Community.new
    end

    def index
        @communities = Community.all.order(:category)
    end

    def show
        @community = Community.find_by(id: params[:id])
        @posts = Post.where(community_id: @community)
    end

    def create
        @community = Community.new(community_params)
        if @community.valid?
            @community.save
            redirect_to community_posts_path(@community)
        else
            render :new
        end
    end

    private

    def community_params
        params.require(:community).permit(:category, :info)
    end
end
