require 'rails_helper'

RSpec.describe Basket, type: :model do
  
  let(:store){build(:store)}
  let(:product){build(:product)}

   it "is basket belongs to product?" do
     basket = product.baskets.build()
     expect(basket).not_to be_valid
  end

   it "is basket belongs to user?" do
     basket = Basket.new(product_id: product.id)
     expect(basket).not_to be_valid
  end


end
