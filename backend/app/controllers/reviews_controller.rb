# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :correct_user, only: %i[edit destroy]
  before_action :require_sign_in

  def index
    @reviews = Review.where(book_id: params[:id]).page(params[:page]).per(10)
  end

  def show
    @review = Review.find(params[:id])
    @review_book = @review.book
    @user = @review.user
  end

  def new
    @review = Review.new
    @book = Book.find_by(isbn: params[:isbn])
  end

  def create
    @review = Review.new(new_review_params(params[:book_id]))
    @book = Book.find(params[:book_id])
    if @review.save
      flash[:success] = 'レビューが正常に投稿されました'
      redirect_to review_path(@review)
    else
      flash.now[:danger] = 'レビューが投稿されませんでした'
      render new_review_path
    end
  end

  def edit
    if current_user == Review.find(params[:id]).user
      @review = Review.find(params[:id])
    else
      redirect_to review_path(Review.find(params[:id]))
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = 'レビューは正常に更新されました'
      redirect_to @review
    else
      flash.now[:danger] = 'レビューは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @book = Book.find(@review.book_id)
    @review.destroy
    flash[:success] = 'レビューは正常に削除されました'
    redirect_to book_path(@book.isbn)
  end

  def error; end

  private

  def new_review_params(book_id)
    strong_params = params.require(:review).permit(:head, :content, :point)
    strong_params[:user_id] = current_user.id
    strong_params[:book_id] = book_id
    strong_params
  end

  def review_params
    params.require(:review).permit(:head, :content, :point)
  end

  def require_sign_in
    return if user_signed_in?

    flash[:warning] = 'このページをみるにはログインが必要です。'
    redirect_to user_session_path
  end

  def correct_user
    return unless current_user.admin == false

    @review = current_user.reviews.find(params[:id])
    redirect_to root_path if current_user != @review.user
  end
end
