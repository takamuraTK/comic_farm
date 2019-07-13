class UsersController < ApplicationController
  def show
    unless user_signed_in?
      flash[:warning] = 'ユーザーページをみるにはログインが必要です。'
      redirect_to user_session_path
    end
    
    @user = User.find(params[:id])
    @subs = @user.books.page(params[:page]).per(10)
    @reviews = Review.where(user_id: params[:id])
  end
end
