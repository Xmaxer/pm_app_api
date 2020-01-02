class User < ApplicationRecord
  has_secure_password
  attr_accessor :password_confirmation, :current_token
  before_create :create_secret_key

  def get_decrypted_secret_key
    Authentication::Encryptor.decrypt(secret_key)
  end

  def self.get_user_secret_key(user_id)
    user = find_by(user_id: user_id)
    return nil unless user
    Authentication::Encryptor.decrypt(user[:secret_key])
  end

  def change_secret_key
    self.update_attribute(:secret_key, Authentication::Encryptor.encrypt(SecureRandom.hex(64)))
  end

  private

  def create_secret_key
    self.secret_key = Authentication::Encryptor.encrypt(SecureRandom.hex(64))
  end
end
