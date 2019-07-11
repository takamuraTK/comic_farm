class ReviewsController < ApplicationController
  def index
    @book_id = params[:id]
    @reviews = Review.where(book_id: @book_id)
  end

  def show
    
  end

  def new
    @review = Review.new
    @book_id = params[:id]
    
  end
  

  def create
    @review = Review.new(
      user_id: current_user.id,
      book_id: params[:book_id],
      head: review_params["head"],
      content: review_params["content"],
      point: review_params["point"],
      )
    
    
    if @review.save
      flash[:success] = 'レビュー が正常に投稿されました'
      redirect_to reviews_new_path
    else
      flash.now[:danger] = 'レビュー が投稿されませんでした'
      render reviews_new_path
    end
  end

  def edit
  end

  def update
  end
  
private
  def review_params
    params.require(:review).permit(:head,:content,:point)
  end

end
