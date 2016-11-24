class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  scope :order_by_time, -> {order created_at: :desc}
end
