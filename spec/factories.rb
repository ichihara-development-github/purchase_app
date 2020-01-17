FactoryBot.define do
  
 
  factory :user, class: User do
    id {1}
    name{"user"}
    email { "user@user.com"}
    password{ "password"}
    seller {true}
    admin{ true}
  end 
 
  factory :normal_user, class: User do
    id {2}
   name { "normal_user"}
   email {"normal_user@user.com"}
   password {"password"}
  end
  
  factory :has_no_store, class: User do
    id {3}
   name { "has_no_store"}
   email {"has_no_store@user.com"}
   password {"password"}
   seller {true}
  end
  
  factory :store, class: Store do
    name {"store"}
    description {"This is my store"}
    top_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.jpg')) }
    user_id { 1 }
  end
  
  factory :production, class: Production do
    store_id { 1}
    name  {"production"}
    price  {1}
    description  {"This is the production"}
    main_image  {"p"}
  end
  
  factory :production2, class: Production do
    store_id { 1}
    name  {"production2"}
    price  {1}
    description  {"This is the production2"}
    main_image  {"p"}
  end
  
  factory :comment, class: Comment do
    content { "This is a comment" }
    user_id { 1 }
    production_id { 1 }
  end
  
   factory :comment2, class: Comment do
    content { "This is a comment2" }
    user_id { 1 }
    production_id { 1 }
  end
  
  factory :basket, class: Basket do
    user_id {1}
    production_id {1}
  end
  
  factory :purchaced, class: Purchaced do
    user_id {1}
    production_id {1}
  end

end