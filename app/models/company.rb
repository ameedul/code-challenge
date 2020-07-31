class Company < ApplicationRecord
  has_rich_text :description

  VALID_EMAIL_REGEX = /\A([^@\s]+)@getmainstreet.com\z/i
  validates :email, format: VALID_EMAIL_REGEX, if: -> { email.present? }

  validates :zip_code, presence: true

  validate :validate_zip_code # will check if it is a valid US zip code or not

  before_validation :set_city_and_state, if: -> { self.zip_code_changed? }

  def set_city_and_state
    self.city = ZipCodes.identify(self.zip_code).try(:[], :city)
    self.state = ZipCodes.identify(self.zip_code).try(:[], :state_name)
  end

  def validate_zip_code
    errors.add(:zip_code, :invalid) unless ZipCodes.identify(zip_code)
  end

end
