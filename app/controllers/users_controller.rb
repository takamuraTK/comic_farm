# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_sign_in

  def show
    if User.find_by(id: params[:id]).nil?
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @subs = @user.books.page(params[:page]).per(15)
      @reviews = Review.where(user_id: params[:id])
      @favs = @user.favbooks.page(params[:page]).per(10)
      @user.books
      @recently_subs_id = @user.subscribes.order('id DESC').limit(4).select('book_id')
      @subs_series = @user.books.group(:series).count.sort
      @favs_series = @user.favbooks.group(:series).count.sort
    end
  end

  def edit
    if current_user.id.to_s == params[:id]
      @user = User.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = '編集する権限がありません。'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '編集が完了しました。'
      redirect_to @user
    else
      flash.now[:danger] = '編集が失敗しました。'
      render :edit
    end
  end

  private
  def require_sign_in
    return if user_signed_in?

    flash[:warning] = 'このページをみるにはログインが必要です。'
    redirect_to user_session_path
  end

  def user_params
    params.require(:user).permit(:name, :image, :profile)
  end
end
