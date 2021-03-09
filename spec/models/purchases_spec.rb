require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let(:user){build(:user)}
  let(:store){build(:store)}
  let(:product){build(:product)}


   it "is purchase belongs to product?" do
     purchase = user.purchases.build()
     expect(purchase).not_to be_valid
  end

   it "is purcahced belongs to user?" do
      purchase = Purchase.new(product_id: product.id)
     expect(purchase).not_to be_valid
  end

end
