FactoryBot.define do
  factory :address do
    name { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
  end

  factory :relationship do

  end

  factory :notification do

  end



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

  factory :product, class: Product do
    store_id { 1}
    name  {"product"}
    price  {1}
    description  {"This is the product"}
    main_image  {"p"}
  end

  factory :product2, class: Product do
    store_id { 1}
    name  {"product2"}
    price  {1}
    description  {"This is the product2"}
    main_image  {"p"}
  end

  factory :comment, class: Comment do
    content { "This is a comment" }
    user_id { 1 }
    product_id { 1 }
  end

   factory :comment2, class: Comment do
    content { "This is a comment2" }
    user_id { 1 }
    product_id { 1 }
  end

  factory :basket, class: Basket do
    user_id {1}
    product_id {1}
  end

  factory :purchaced, class: Purchaced do
    user_id {1}
    product_id {1}
  end

end
