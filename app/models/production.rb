class Production < ApplicationRecord

    def self.search(sp)

       if sp
           sp.reject! { |key, value| value.empty?}

           if sp[:min] or sp[:max]
               if sp[:min]
                   @result = Production.where("price >  ?", sp[:min])
                   sp.reject! { |key, value| key["min"] }
               end
               if sp[:max]
                    @result = Production.where("price <  ?", sp[:max])
                    sp.reject! { |key, value| key["max"]}
               end
            else
                sp.each do |key, value|
                    @result = @result.where("#{key.first}": "#{value.first}")
                end
            end

           @result = Production.where("#{key}": "#{value}")
           sp.each do |key, value|
               @result = presult.where("#{key}": "#{value}")
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
  has_many :purchaceds, dependent: :nullify
  has_many :purchaced_user, through: :purchaceds, source: :user

  has_many :comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0, :less_than => 1000000 }


  mount_uploader :main_image, ImageUploader
  mount_uploader :sub_image1, ImageUploader
  mount_uploader :sub_image2, ImageUploader
end
