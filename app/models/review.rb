class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  scope :order_by_time, -> {order created_at: :desc}
  after_save :calculate_score

  private
  def calculate_score
    sum = book.reviews.reduce(0) {|sum, element| sum + element.rating}
    average_score = sum / book.reviews.count
    book.update_attribute :rate_score, average_score
  end
end
