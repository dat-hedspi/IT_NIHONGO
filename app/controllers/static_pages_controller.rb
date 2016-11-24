class StaticPagesController < ApplicationController

  def home
    @categories = Category.all
    @reviews = Review.order_by_time
    @book_random = Book.random
  end
end
