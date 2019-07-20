class ReviewsController < ApplicationController
  before_action :correct_user, only: [:edit,:destroy]
  
  def index
    unless user_signed_in?
      flash[:warning] = 'レビューをみるにはログインが必要です。'
      redirect_to user_session_path
    end
    @book_id = params[:id]
    @reviews = Review.where(book_id: @book_id)
  end

  def show
    unless user_signed_in?
      flash[:warning] = 'レビューをみるにはログインが必要です。'
      redirect_to user_session_path
    end
    @review = Review.find(params[:id])
    @review_book = Book.find(@review.book_id)
    @user = User.find(@review.user_id)
  end

  def new
    unless user_signed_in?
      flash[:warning] = 'レビューを書くにはログインが必要です。'
      redirect_to user_session_path
    end
    @review = Review.new
    @book = Book.find_by(isbn: params[:isbn])
    @book_id = @book.id
    
  end
  

  def create
    @review = Review.new(
      user_id: current_user.id,
      book_id: params[:book_id],
      head: review_params["head"],
      content: review_params["content"],
      point: review_params["point"],
      )
    @book = Book.find(params[:book_id])
    if @review.save
      flash[:success] = 'レビュー が正常に投稿されました'
      redirect_to book_path(@book.isbn)
    else
      flash.now[:danger] = 'レビュー が投稿されませんでした'
      render reviews_new_path
    end
  end

  def edit
    @book_id = Book.find(@review.book_id)
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
  
private
  def review_params
    params.require(:review).permit(:head,:content,:point)
  end
  
  def correct_user
    @review = current_user.reviews.find(params[:id])
    if current_user.id != @review.user_id
      flash[:warning] = "権限がありません"
      redirect_to root_path
    end
  end
  
end
