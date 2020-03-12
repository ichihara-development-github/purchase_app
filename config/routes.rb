Rails.application.routes.draw do

  get 'relationships/create'

  get 'relationships/destroy'

  get "comments/index"

  get "purcahce/new"

 root "welcome#top"

 post "login", to: "session#create"

 get "edit_productions", to: "productions#edit_productions"
 get "registration", to: "users#registration"
 post "payment", to: "users#payment"
 get "complete_payment", to: "users#complete_payment"

 post "guest_login", to: "session#guest_login"
 post "guest_user_login", to: "session#guest_user_login"

 get "store_management", to: "users#management"

 get "search", to: "productions#search"
 get "free_search", to: "productions#free_search"

 post "basket_add", to: "baskets#add"
 post "basket_delete", to: "baskets#delete"

 post   "/baskets/:production_id" => "baskets#create", as: "in_basket"
 delete "/baskets/:production_id" => "baskets#destroy", as: "out_basket"

 get "after_purchace", to: "purchaces#after_purchace"

 delete "notifications", to: "notifications#destroy"

 resources :users
 resources :password_resets, only: [:new, :create, :edit, :update]
 resources :session, only: [:new, :create, :destroy]
 resources :stores
 resources :productions
 resources :comments, only: [:create, :destroy]
 resources :baskets, only: [:index]
 resources :purchaces, only: [:new, :create]
 resources :notifications, only: [:index]
 resources :relationships, only: [:create, :destroy]

 resources :users do
    member do
      get :following, :followers
    end
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
