class User < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  def online?
    online
  end

  def set_online(value)
    update(online: value)
  end

  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id'
  has_many :received_notifications, class_name: 'Notification', foreign_key: 'recipient_id'

  has_many :stocks, dependent: :destroy
end
