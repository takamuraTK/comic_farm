# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_sign_in

  def show
    redirect_to root_path if User.find_by(id: params[:id]).nil?

    @user = User.find(params[:id])
    @reviews = Review.where(user_id: params[:id])
    get_subs(params[:sub_series_title])
    get_favs(params[:fav_series_title])
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

  def get_subs(series)
    @sub_books = @user.books.where(series: series).order('salesint')
  end

  def get_favs(series)
    @fav_books = @user.favbooks.where(series: series).order('salesint')
  end
end
