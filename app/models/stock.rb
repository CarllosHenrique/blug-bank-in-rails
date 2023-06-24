class Stock < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  extend FriendlyId
  friendly_id :name, use: :slugged
end
