FactoryBot.define do
  factory :linenonce do
    nonce { 1 }
    user_id { 1 }
  end

  factory :evaluation do
    star { 1 }
    comment { "MyString" }
  end


  factory :user, class: User do
    id {1}
    name{"user"}
    email { "user@user.com"}
    password{ "password"}
    seller {true}
    admin{true}
    store_id {1}
    address{"Tokyo"}
  end

  factory :user2, class: User do
    id {2}
    name{"user2"}
    email { "user2@user.com"}
    password{ "password"}
    seller {true}
    admin{ true}
    address{ "Tokyo"}
  end



  factory :normal_user, class: User do
    id {3}
   name { "normal_user"}
   email {"normal_user@user.com"}
   password {"password"}
   address{ "Tokyo"}
  end

  factory :has_no_store, class: User do
  id {4}
   name { "has_no_store"}
   email {"has_no_store@user.com"}
   password {"password"}
   seller {true}
   address{"Tokyo"}
  end

  factory :store, class: Store do
    id {1}
    name {"store"}
    description {"This is my store"}
    user_id { 1 }
    address {"銀座"}
  end

  factory :product, class: Product do
    id {1}
    store_id { 1}
    name  {"product"}
    price  {100}
    description  {"This is the product"}
  end

  factory :product2, class: Product do
    id {2}
    store_id { 1}
    name  {"product2"}
    price  {1000}
    description  {"This is the product2"}
    category {"food"}
    main_image  {"p"}
  end

  factory :comment, class: Comment do
    content { "This is a comment" }
    product_id { 1 }
    user_id {1}
  end

   factory :comment2, class: Comment do
    content { "This is a comment2" }
    product_id { 1 }
  end

  factory :basket, class: Basket do
    user_id {1}
    product_id {1}
  end

  factory :follow, class: Relationship do
    following_id {1}
    followed_id {2}
  end

end
