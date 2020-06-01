
module ApplicationHelper

    def current_user
        if session[:user_id]
          @current_user = User.find(session[:user_id])
        end
    end

    def how_much_postage(distance)
      if distance < 10
        0
      elsif distance < 50
        500
      else
        1000
      end
    end
end
