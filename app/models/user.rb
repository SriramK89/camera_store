class User < ApplicationRecord
  # ENCRYPT PASSWORD
  has_secure_password

  # VALIDATIONS
  validates_uniqueness_of :email

  # ASSOCIATIONS
  has_many :carts

  # CONSTANTS
  KEY_SPLIT = '::'

  # Class method to find the user from the given api_token
  def self.get_from_api_token(api_token)
    user_key = CACHE.read(api_token)
    if user_key
      user_id, user_email = user_key.split(KEY_SPLIT)
      User.where(id: user_id, email: user_email).first
    end
  end

  # Instance method to get an API token for an instance of user
  def get_api_token
    encryptor = ActiveSupport::MessageEncryptor.new Rails.application.secrets.secret_key_base[0..31]
    api_token = encryptor.encrypt_and_sign("#{Time.now.to_i}#{self.email}#{self.id}").gsub(/[\+=\/-]/, '')
    CACHE.write(api_token, get_cache_key, expires_in: 24.hours)
    api_token
  end

  # Instance method to get the cache key for an instance of user
  def get_cache_key
    "#{id}#{KEY_SPLIT}#{email}"
  end
end
