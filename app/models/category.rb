class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  scope :order_by_time, -> {order created_at: :desc}
end
