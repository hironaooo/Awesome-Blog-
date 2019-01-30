module SessionsHelper

    def current_user
        User.find_by(id: session[:user_id])  
        #User.find(session[:user_id]) = error  もしユーザーidがnilなら
        #User.find_by(id: session[:user_id]) = nil もしユーザーidがnilなら
    end

    def logged_in?
        #NOT operator == != !
        !current_user.nil? #nilならfaulseを返す
    end

    def current_user?(user)
        current_user == user
        
    end
end
