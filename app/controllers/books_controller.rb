class BooksController < ApplicationController

  def index
    @books = Book.order_by_time.page(params[:page]).per Settings.size
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @book = Book.find_by_id params[:id]
    check_null @book
    @reviews = @book.reviews.page(params[:page]).per Settings.size
    @review_new = @reviews.build
  end
end
