class PostsController < ApplicationController
    def create
        post = current_user.posts.build(post_params)
        if post.save
            redirect_to current_user
        else 
            @post = current_user.posts.build
            @posts = current_user.posts.order('created_at DESC').paginate(page: params[:page], per_page: 5)
            render 'users/feed' 
        end
    end

    private
    def post_params
        params.require(:post).permit(:content, :picture)
    end
end
