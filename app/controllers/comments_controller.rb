class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, :load_review, :load_comment
  before_action :correct_user, only: [:update, :destroy]

  def new
    @comment = @review.comments.build
  end

  def create
    @comment = @review.comments.build comment_params
    if @comment.save
      @comments = @review.comments.order_by_time
      flash[:success] = "Create comment success"
    else
      flash[:danger] = "Create comment fail"
    end
  end

  def edit
  end

  def update
    if @comment.update comment_params
      flash[:success] = "Update comment success"
      @comments = @review.comments.order_by_time
    else
      flash[:danger] = "Update comment fail"
    end
  end

  def destroy
    if @comment.destroy
      @comments = @review.comments.order_by_time
      flash[:success] = "Delete comment success"
    else
      flash[:danger] = "Delete comment fail"
    end
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :content
  end

  def load_book
    @book = Book.find_by_id params[:book_id]
    redirect_to root_url if @book.nil?
  end

  def load_review
    @review = Review.find_by_id params[:review_id]
    redirect_to root_url if @review.nil?
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

  def correct_user
    redirect_to root_url if @comment.user != current_user
  end
end
