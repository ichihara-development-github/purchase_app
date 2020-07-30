class User < ApplicationRecord

  before_save :downcase_email

  attr_accessor :reset_token


  def self.collect_data(user, model)
      list = []
      products = user.store.products
      products.each do |product|
        data = model.where(product_id: product.id)
        data.each{|datum| list << datum}
      end
      list
  end

  def self.pay_off(data)
      total = 0
      data.map{|product| total += Product.find(product.product_id).price}
      total
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_mail
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  #follow

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def remove(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

#-------------------------------------------------------------------------

  has_one :store, dependent: :destroy, class_name: Store
  has_many :payment, dependent: :nullify
  has_many :baskets, dependent: :destroy
  has_many :considering_products, through: :baskets, source: :product
  has_many :purchases, dependent: :destroy
  has_many :purchase_products, through: :purchases, source: :product

  has_many :comments, dependent: :destroy

  #notification
  has_many :active_notifications, class_name: "Notification", foreign_key: "active_user_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",foreign_key:  "passive_user_id", dependent: :destroy

  #follow
  has_many :active_relationships, class_name: "Relationship",
                           foreign_key: "following_id",
                           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_realtionships, class_name: "Relationship",
                             foreign_key: "followed_id",
                             dependent: :destroy
  has_many :followers, through: :passive_realtionships, source: :following


  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, uniqueness: true, length: { minimum: 1}
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: { minimum: 6}, allow_nil: true

  mount_uploader :profile_image, ImageUploader


  geocoded_by :address
  after_validation :geocode


   private

    def downcase_email
      self.email = email.downcase
    end

    def geocode
      res = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=AIzaSyAAWezrBjtug-O85xz84V_TYNCmv1pYxDQ")
      response = JSON.parse(res)
      self.latitude = response["results"][0]["geometry"]["location"]["lat"]
      self.longitude = response["results"][0]["geometry"]["location"]["lng"]
    end


end
