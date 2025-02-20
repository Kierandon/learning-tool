class User < ApplicationRecord
  has_many :progressions
  has_many :courses, through: :progressions
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  before_create :generate_login_hash

  validates :login_hash, uniqueness: true

  private

  # Yes this may (will) break eventually but for the amount of users testing the app it's fine.
  def generate_login_hash
    loop do
      self.login_hash = SecureRandom.random_number(999999)
      break unless User.exists?(login_hash: login_hash)
    end
  end
end
