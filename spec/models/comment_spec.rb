require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user){build(:user)}
  let(:store){build(:store)}
  let(:product){build(:product)}



   it "is comment belongs to product?" do
     comment = user.comments.build(content: "hoge fuga piyo")
     expect(comment).not_to be_valid
  end

   it "is comment belongs to user?" do
     comment = Comment.new(content: "hoge fuga piyo",product_id: product.id)
     expect(comment).not_to be_valid
  end

  it "isn't save less than 1 charactor" do
      comment = user.comments.build(product_id: product.id)
     expect(comment).not_to be_valid

  end

end
