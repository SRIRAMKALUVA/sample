class User < ApplicationRecord

  # validation parts start here
  #syntax :
    #validates :column_name , :options
    #https://api.rubyonrails.org/v5.1.3/classes/ActiveModel/Validations/ClassMethods.html
  validates :name, presence: true, length: {minimum: 4, maximum: 10}
  validates :email, presence: true, uniqueness: true

  # has_one :article
  has_many :articles
  # validation parts ends here
  has_one :image
  accepts_nested_attributes_for :image
  # callbacks
  before_save :encrypt_password
   def encrypt_password
     self.password = Digest::MD5.hexdigest(password)
     self.confirm_password = Digest::MD5.hexdigest(confirm_password)
   end

  def self.authenitcate(email, password)
    where(email: email, password: Digest::MD5.hexdigest(password)).last
  end

  before_destroy :save_into_file
  def save_into_file
    File.open("#{Rails.root}/public/#{self.id}.json", "a+") {|foo|
      foo.write(self.to_json)
    }
  end
  def admin?
    self.admin
  end
end
