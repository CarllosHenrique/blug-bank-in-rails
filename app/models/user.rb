class User < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true

  has_many :messages, dependent: :destroy
end
