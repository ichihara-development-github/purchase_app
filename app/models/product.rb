class Product < ApplicationRecord

    def self.search(sp)
       if sp
           sp.reject! { |_key, value| value.empty? }

           if sp[:min] or sp[:max]
               if sp[:min]
                   @result = Product.where("price >  ?", sp[:min])
                   sp.reject! { |key, _value | key["min"] }
               end
               if sp[:max]
                    @result = Product.where("price <  ?", sp[:max])
                    sp.reject! { |key, _value | key["max"]}
               end
           else
              @result = Product
           end

            sp.each do |key, value|
                @result = @result.where("#{key}": "#{value}")
            end

           return @result

       end
    end

   def self.free_search(free_search)
        if free_search
            #検索ワードがあるかどうか
            Product.where("name LIKE ? OR description LIKE ?", "%#{free_search}%", "%#{free_search}%")
            #検索結果がなければblank
        else
            #なければオールをreturn
            all
        end
   end

   def self.popular
     Product.find(Purchase.group(:product_id).order('count(product_id) desc').pluck(:product_id))
   end

  belongs_to :store

  has_many :baskets, dependent: :destroy
  has_many :considered_user, through: :baskets, source: :user
  has_many :Purchases, dependent: :nullify
  has_many :Purchase_user, through: :Purchases, source: :user

  has_many :comments, dependent: :destroy

  has_many :notifications, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0, :less_than => 1000000 }


  mount_uploader :main_image, ImageUploader
  mount_uploader :sub_image1, ImageUploader
  mount_uploader :sub_image2, ImageUploader
end
