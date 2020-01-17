module AuthenticationHelper
    def current_user
        if session[:user_id]
          @current_user = User.find(session[:user_id])
        end
    end
    
    def sign_in(user)
        session[:user_id] = user.id
        @current_user = User.find(session[:user_id])
    end
end