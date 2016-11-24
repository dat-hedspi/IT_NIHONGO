class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review_book, only: [:edit, :update, :destroy]
  after_action :calculate_score, only: :destroy

  def new
    review = current_user.reviews.new review_params
  end

  def create
    review = current_user.reviews.new review_params
    book = Book.find_by_id params[:book_id]
    check_null book
    review.book_id = book.id
    if review.save
      flash[:success] = t "reviews.success"
      redirect_to book
    else
      flash[:danger] = t "reviews.danger"
      redirect_to :back
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "reviews.success"
    else
      flash[:danger] = t "reviews.danger"
    end
    redirect_to @book
  end

  def edit

  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "reviews.update_success"
      redirect_to category_path
    else
      flash[:danger] = t "reviews.update_danger"
      render :edit
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :rating
  end

  def find_review_book
    @review = Review.find_by_id params[:id]
    check_null @review
    @book = @review.book
    check_null @book
  end

  def calculate_score
    sum = @book.reviews.reduce(0) {|sum, element| sum + element.rating}
    if @book.reviews.size == 0
      average_score = 0
    else
      average_score = sum / @book.reviews.count
    end
    @book.update_attribute :rate_score, average_score
  end
end
