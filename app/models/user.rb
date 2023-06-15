class User < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :nickname, use: :slugged
end
