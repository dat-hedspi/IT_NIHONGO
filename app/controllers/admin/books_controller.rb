class Admin::BooksController < ApplicationController
  before_action :find_book, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @books = Book.order_by_time.page(params[:page]).per Settings.size
    @categories = Category.all
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new book_params
    if @book.save
      redirect_to admin_books_path
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    @book = Book.find_by_id params[:id]
  end


  def edit
    @categories = Category.all
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "activerecord.controllers.admin.update.success"
      redirect_to admin_books_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "activerecord.controllers.admin.destroy.success"
    else
      flash[:danger] = t "activerecord.controllers.admin.destroy.danger"
    end
    redirect_to :back
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_time, :author,
      :pages, :picture, :category_id, :description
  end
  def find_book
    @book = Book.find params[:id]
  end
end
