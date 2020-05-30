require 'rails_helper'

RSpec.describe Purchaced, type: :model do
  let(:user){build(:user)}
  let(:store){build(:store)}
  let(:product){build(:product)}


   it "is purchaecd belongs to product?" do
     purchaced = user.purchaceds.build()
     expect(purchaced).not_to be_valid
  end

   it "is purcahced belongs to user?" do
      purchaced = Purchaced.new(product_id: product.id)
     expect(purchaced).not_to be_valid
  end

end
