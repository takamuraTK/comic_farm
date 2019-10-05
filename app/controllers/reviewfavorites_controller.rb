class ReviewfavoritesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    current_user.addreviewfav(review)
    flash[:success] = "いいねしました！"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    review = Review.find(params[:review_id])
    current_user.removereviewfav(review)
    flash[:success] = "いいねを解除しました！"
    redirect_back(fallback_location: root_path)
  end
end
