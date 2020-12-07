# frozen_string_literal: true

class ReviewfavoritesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    current_user.addreviewfav(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    current_user.removereviewfav(@review)
  end
end
