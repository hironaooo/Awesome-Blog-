class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create] #new, create以外のurlに行く前にrequire_loginアクションにつなぐ
    before_action :require_admin, only: :destroy #updateは入れる必要ない
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_url
        else
            render 'new'
        end
    end

    def show
        # @user = User.find_by(id: params[:id]) find_byを使う時はidをつけないとダメ
        @user = User.find(params[:id])
        @post = @user.posts.build
        @posts = @user.posts.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    end

    def edit
        @user = User.find(params[:id])
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 10) #10ページってこと
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
                flash[:success] = "Successfully updated profile."
            redirect_to @user #user_path(@user) #user必要？
        else
            render 'edit'
        end
    end

    def feed
        @post = current_user.posts.build
        @posts = current_user.posts.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path #ivanはurlにしていた
    end

    private
    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def require_login
        unless logged_in?
            flash[:info] = "Please login to gain access."
            redirect_to login_url
        end
    end

    def require_admin
        unless current_user.admin? #booleanだから
            flash[:danger] = "Only administrators can delete."
            redirect_to root_url
        end
    end
end

