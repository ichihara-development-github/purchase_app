require 'test_helper'

RSpec.describe "四則演算" do
  it "計算できること" do
    
    expect(1 + 2).to eq 3
    expect(10 - 1).to eq 9
    expect(4 * 8).to eq 32
    exepect(40 / 8).t eq 5
  end
end

class BasketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
