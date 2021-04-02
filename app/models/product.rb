class Product < ApplicationRecord

  require 'net/http'
  require 'uri'
  require 'json'

  CRUD_API_KEY = ""
  STEPFUNC_API_KEY = ""

  URL = ""

  after_initialize :set_default

    def self.search(sp)
       if sp
           sp.reject! { |_key, value| value.empty? }
           if sp[:min] or sp[:max]
               if sp[:min]
                   @products = Product.where("price =>  ?", sp[:min])
                   sp.reject! { |key, _value | key["min"] }
               end
               if sp[:max]
                    @products = Product.where("price <=  ?", sp[:max])
                    sp.reject! { |key, _value | key["max"]}
               end
           else
              @products = Product
           end
            sp.each do |key, value|
                @products = @products.where("#{key}": "#{value}")
            end
            @products
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

   def self.popular(arg=Product)
     product_ids = Purchase.group(:product_id).order('count(product_id) desc').pluck(:product_id))
     arg.where(id: product_ids).order(['field(id, ?)', product_ids] )
   end

   def self.has_many_reviews(arg=Product)
     product_ids = Evaluation.group(:product_id).order('count(product_id) desc').pluck(:product_id)
     arg.where(id: product_ids).order(['field(id, ?)', product_ids] )
   end

   def self.products_review_avarage(arg=Product)
     product_ids = Evaluation.group(:product_id).order('avg(star) desc').pluck(:product_id))
     arg.where(id: product_ids).order(['field(id, ?)', product_ids] )
   end

   def self.input_request(name)
     url = "https://wpt6sy2360.execute-api.us-east-2.amazonaws.com/default"
     uri = URI.parse(url)
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = true
     req = Net::HTTP::Post.new(uri.request_uri)
     headers = {"Content-Type" => "application/json", "x-api-key" => STEPFUNC_API_KEY}
     data = {"source" => "other", "name" => ["#{name}"]}.to_json
     req.initialize_http_header(headers)
     res = http.request(req, data)
     return JSON.parse(res.body)
   end

   def self.update_request(old_name, name)
     url = "#{URL}?oldname=#{old_name}&name=#{name}"
     uri = URI.parse(url)
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = true
     req = Net::HTTP::Patch.new(uri.request_uri)
     headers = {'x-api-key' => CRUD_API_KEY, "Content-Type" => "application/json"}
     req.initialize_http_header(headers)
     http.request(req)
   end

   def self.delete_request(name)
     url = "#{URL}?name=#{name}"
     uri = URI.parse(url)
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = true
     req = Net::HTTP::Delete.new(uri.request_uri)
     headers = {'x-api-key' => CRUD_API_KEY, "Content-Type" => "application/json"}
     req.initialize_http_header(headers)
     res = http.request(req)
     return JSON.parse(res.body)
   end

   def self.send_get_request(name)
      url = "#{URL}?name=#{name}"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(uri.request_uri)
      headers = {'x-api-key' => CRUD_API_KEY, "Content-Type" => "application/json"}
      req.initialize_http_header(headers)
      res = http.request(req)
      return JSON.parse(res.body)
   end

#-------------------------------------------compare-------------------------------------------

  belongs_to :store

  has_many :baskets, dependent: :destroy
  has_many :considered_user, through: :baskets, source: :user
  has_many :purchases, dependent: :nullify
  has_many :purchase_user, through: :Purchases, source: :user

  has_many :comments, dependent: :destroy

  has_many :evaluations, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_many :evaluations, dependent: :destroy
  has_many :reviewer, through: :evaluations, source: :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than => 0, :less_than => 1000000 }


  mount_uploader :main_image, ImageUploader
  mount_uploader :sub_image1, ImageUploader
  mount_uploader :sub_image2, ImageUploader

  private

  def set_default
    self.count ||= 1
  end
end
