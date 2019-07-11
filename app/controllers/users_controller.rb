class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @subs = @user.books
    @reviews = Review.where(user_id: params[:id])
  end
  
    
end
