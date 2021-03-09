class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :star, numericality: {
   greater_than_or_equal_to: 1,
   less_than_or_equal_to: 5,
 }, presence: true

  validates :comment, length: { minimum: 10, maximum: 200}
end
