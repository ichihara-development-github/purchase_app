class Production < ApplicationRecord
    
    def self.search(sp)
     
       if sp
           sp.reject! { |key, value| value.empty?}
      
           @result = Production.where(price: sp[:min] .. sp[:max])
           sp.reject! { |key, value| key["min"] or key["max"]}
           
           sp.each do |key, value|
               @result = @result.where("#{key}": "#{value}")
           end
           return @result
    
       end
    end
  
   def self.free_search(free_search)
        if free_search
            #検索ワードがあるかどうか
            Production.where("name LIKE ? OR description LIKE ?", "%#{free_search}%", "%#{free_search}%")
            #検索結果がなければblank
        else
            #なければオールをreturn
            all
        end
   end
  
  
  belongs_to :store
  
  has_many :baskets, dependent: :destroy
  has_many :considered_user, through: :baskets, source: :user
  has_many :purchaceds, dependent: :destroy
  has_many :purchaced_user, through: :purchaceds, source: :user
  
  has_many :comments
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0, :less_than => 1000000 } 
  validates :main_image, presence: true
end
