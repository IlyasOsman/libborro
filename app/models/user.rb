class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  # Email normalization before validation
  before_validation :normalize_email

  validates :email_address, presence: true,
                          uniqueness: { case_sensitive: false, message: "is already registered" },
                          format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true,
                      length: { minimum: 6, message: "must be at least 6 characters" },
                      if: :password_required?
  validates :password_confirmation, presence: true,
                                  if: :password_required?
  validate :password_matches_confirmation, if: :password_required?

  
  private

  def normalize_email
    self.email_address = email_address.to_s.strip.downcase
  end

  def password_required?
    new_record? || password.present?
  end

  def password_matches_confirmation
    return unless password.present?
    return if password == password_confirmation
    errors.add(:password_confirmation, "doesn't match password")
  end
end
