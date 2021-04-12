Rails.application.routes.draw do

 root to: "welcome#top"

 post "login", to: "session#create"
 post "guest_login", to: "session#guest_login"
 post "guest_user_login", to: "session#guest_user_login"

 get "edit_products", to: "products#edit_products"
 get "registration", to: "users#registration"
 post "payment", to: "users#payment"
 get "complete_payment", to: "users#complete_payment"

 get "store_management", to: "users#management"

 get "compare_price", to: "products#compare"

 # search & linup
 get "search", to: "products#search"
 get "free_search", to: "products#free_search"
 get "line_up", to: "products#line_up"

 # add cart
 post "basket_add", to: "baskets#add"
 post "basket_delete", to: "baskets#delete"

 post   "/baskets/:product_id" => "baskets#create", as: "in_basket"
 delete "/baskets/:product_id" => "baskets#destroy", as: "out_basket"

 get "after_purchase", to: "purchases#after_purchase"

 delete "notifications", to: "notifications#destroy"

 # aws api
 get "compare", to: "products#compare"

 # line-bot
 post "/callback", to: "linebot#callback"

 resources :users
 resources :password_resets, only: [:new, :create, :edit, :update]
 resources :session, only: [:new, :destroy]
 resources :stores
 resources :products, except: [:compare]
 resources :comments, only: [:create, :destroy]
 resources :baskets, only: [:index, :update]
 resources :purchases, only: [:new, :create]
 resources :notifications, only: [:index]
 resources :relationships, only: [:create, :destroy]
 resources :evaluations

 resources :users do
    member do
      get :following, :followers
    end
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
