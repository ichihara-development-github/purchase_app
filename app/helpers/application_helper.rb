
module ApplicationHelper

    def current_user
      @current_user = User.find(session[:user_id])   if session[:user_id]
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

    def basket_count
        current_user.baskets.sum(:count)
    end

end
