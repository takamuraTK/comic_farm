# frozen_string_literal: true

class NewlysController < ApplicationController
  before_action :require_sign_in, only: %i[search download]
  before_action :download, only: %i[download]
  def search
    return unless params[:publisher_select].present? && params[:month].present?

    @books = Book.where('salesDate LIKE ?', "%#{params[:month]}%").where(publisherName: params[:publisher_select])
    @no_results = '漫画は見つかりませんでした。' if @books.blank?
  end

  def download
    @downloads = Newly.order('created_at DESC')
    return unless params[:publisher_select].present? && params[:month].present?

    @month = view_context.get_month_str(params[:month])
    @pre_month = view_context.get_pre_month_str(params[:month])
    search_new
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

  def search_new
    check_page = 'running'
    counter = 0
    page = 0
    while check_page == 'running'
      page += 1
      results = RakutenWebService::Books::Book.search(
        publisherName: params[:publisher_select],
        booksGenreId: '001001',
        outOfStockFlag: '1',
        sort: '-releaseDate',
        page: page
      )
      results.each do |result|
        book = Book.new(view_context.read(result))
        if book.salesDate.include?(@pre_month)
          check_page = 'stop'
          break
        end

        next unless book.salesDate.include?(@month)

        comic = Book.find_or_initialize_by(isbn: book.isbn)
        next if comic.persisted?

        counter += 1 if book.save
      end
    end
    @page = 0
    Newly.create(publisherName: params[:publisher_select], counter: counter, month: @month)
  end
end
