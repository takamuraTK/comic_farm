# frozen_string_literal: true

class NewlysController < ApplicationController
  before_action :require_sign_in, only: %i[search download]
  before_action :check_admin, only: %i[download]
  def search
    return unless params[:publisher_select].present? && params[:month].present?

    @books = Book.where('salesDate LIKE ?', "%#{params[:month]}%").where(publisherName: params[:publisher_select])
    @no_results = '漫画は見つかりませんでした。' if @books.blank?
  end

  def download
    @downloads = Newly.order('created_at DESC')
    return unless params[:publisher_select].present? && params[:month].present?

    download_comics = Newly.new(publisherName: params[:publisher_select], month: params[:month])
    download_comics.save
  end

  def newfav
    if user_signed_in?
      @books = []
      now = Time.now
      @month = now.mon.to_s
      @year = now.year.to_s
      @subbooks = current_user.books.group(:series).count.keys
      @subbooks.each do |book|
        comics = Book.where('title LIKE ?', "%#{book}%").where('salesDate LIKE ?', "%#{@year}年#{@month}月%")
        comics.each do |comic|
          @books << comic
        end
      end
    else
      flash[:warning] = '買うかもしれない機能を使うにはログインが必要です。'
      redirect_to user_session_path
    end
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(
        isbn: @book.isbn,
        outOfStockFlag: '1'
      )
      @book = Book.new(read(results.first))
      @book.save
    end
  end

  private

  def require_sign_in
    return if user_signed_in?

    flash[:warning] = 'このページをみるにはログインが必要です。'
    redirect_to user_session_path
  end

  def check_admin
    redirect_to root_path unless current_user.admin == true && current_user.downloadadmin == true
  end
end
