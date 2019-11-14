# frozen_string_literal: true

class NewlysController < ApplicationController
  before_action :require_sign_in, only: %i[search download]
  def search
    return unless params[:publisher_select].present? && params[:month].present?

    @books = Book.where('salesDate LIKE ?', "%#{params[:month]}%").where(publisherName: params[:publisher_select])
    @no_results = '漫画は見つかりませんでした。' if @books.blank?
  end

  def download
    unless current_user.admin == true && current_user.downloadadmin == true
      flash[:warning] = '権限がありません'
      redirect_to root_path
    end
    @downloads = Newly.order('created_at DESC')
    if params[:publisher_select].present? && params[:month].present?
      @page = 0
      @month = params[:month].in_time_zone.strftime('%Y年%m月')
      @pre_month = params[:month].in_time_zone.prev_month.strftime('%Y年%m月')
      @check_page = 'running'
      while @check_page == 'running'
        @page += 1
        search_new
      end
      Newly.create(
        publisherName: params[:publisher_select],
        counter: @counter,
        month: @month
      )
      @page = 0
    end
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

  def search_new
    @counter = 0
    results = RakutenWebService::Books::Book.search(
      publisherName: params[:publisher_select],
      booksGenreId: '001001',
      outOfStockFlag: '1',
      sort: '-releaseDate',
      page: @page
    )
    results.each do |result|
      book = Book.new(view_context.read(result))
      if book.salesDate.include?(@pre_month)
        @check_page = 'stop'
        break
      end

      next unless book.salesDate.include?(@month)

      comic = Book.find_or_initialize_by(isbn: book.isbn)
      next if comic.persisted?

      @counter += 1 if book.save
    end
  end
end
