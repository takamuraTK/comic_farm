class UsersController < ApplicationController
  def show
    unless user_signed_in?
      flash[:warning] = 'ユーザーページをみるにはログインが必要です。'
      redirect_to user_session_path
    end
    if User.find_by(id: params[:id]).nil?
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @subs = @user.books.page(params[:page]).per(15)
      @reviews = Review.where(user_id: params[:id])
      @favs = @user.favbooks.page(params[:page]).per(10)
    end
  end
end
