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
      @user.books
      @subs_series = @user.books.group(:series).count.sort
      @favs_series = @user.favbooks.group(:series).count.sort
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '設定完了'
      redirect_to @user
    else
      flash.now[:danger] = '失敗しました'
      render :edit
    end
  end

  private

  # Strong Parameter
  def user_params
    params.require(:user).permit(:name, :image, :profile)
  end
end
