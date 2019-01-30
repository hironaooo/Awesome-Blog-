class SessionsController < ApplicationController
    
    def new

    end

    def create
              #User.find() ...only accept id     #ivan@gmail.com
              #User.find_by(params[:id])
              #User.find_by(id: params[:id])
        user = User.find_by(email: params[:session][:email]) # なんでも受け取れる

        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:info] = "Successfully logged in."
            redirect_to root_url
        else
            flash[:danger] = "Invalid Credentials."
            render 'new'
        end
    end

    def destroy
        session.delete(:user_id)

        redirect_to login_url
    end
end
