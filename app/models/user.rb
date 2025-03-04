class User < ApplicationRecord
  has_secure_password
  attr_accessor :password_confirmation, :current_token
  before_create :create_secret_key
  after_initialize :default_values


  has_many :user_company_roles
  has_many :companies, through: :user_company_roles
  has_many :api_keys, through: :companies
  has_many :assets, through: :companies
  has_many :company_roles, through: :user_company_roles


  validates :email, format: {with: /(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})/i, message: Constants::Errors::USER_EMAIL_NOT_VALID_ERROR[:message]}, presence: {message: Constants::Errors::USER_EMAIL_NOT_PRESENT_ERROR[:message]}, uniqueness: {message: Constants::Errors::USER_EMAIL_NOT_UNIQUE_ERROR[:message], case_sensitive: false}
  validates :first_name, length: {in: 2..30, too_long: Constants::Errors::USER_FIRST_NAME_TOO_LONG_ERROR[:message], too_short: Constants::Errors::USER_FIRST_NAME_TOO_SHORT_ERROR[:message]}, presence: {message: Constants::Errors::USER_FIRST_NAME_NOT_PRESENT_ERROR[:message]}
  validates :last_name, length: {in: 2..30, too_long: Constants::Errors::USER_LAST_NAME_TOO_LONG_ERROR[:message], too_short: Constants::Errors::USER_LAST_NAME_TOO_SHORT_ERROR[:message]}, allow_nil: true
  validates :password, presence: {message: Constants::Errors::USER_PASSWORD_NOT_PRESENT_ERROR[:message]}, length: {in: 6..50, too_long: Constants::Errors::USER_PASSWORD_TOO_LONG_ERROR[:message], too_short: Constants::Errors::USER_PASSWORD_TOO_SHORT_ERROR[:message]}, confirmation: {message: Constants::Errors::PASSWORD_CONFIRMATION_INVALID_ERROR[:message]}, if: :password

  def actual_companies
    user = User.find_by(id: self.id)
    Company.where(id: user.companies.ids, deleted: false).or(Company.where(id: Company.where(user_id: user.id).ids, deleted: false))
  end

  def actual_api_keys
    user = User.find_by(id: self.id)
    ApiKey.where(id: user.api_keys.ids, deleted: false).or(ApiKey.where(id: ApiKey.where(user_id: user.id).ids, deleted: false))
  end

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

  def default_values
    self.enabled = true if self.enabled.nil?
  end

  def create_secret_key
    self.secret_key = Authentication::Encryptor.encrypt(SecureRandom.hex(64))
  end
end
