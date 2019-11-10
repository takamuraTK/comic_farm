# frozen_string_literal: true

class NewlysController < ApplicationController
  def search
    unless user_signed_in?
      flash[:warning] = '新刊検索をするにはログインが必要です。'
      redirect_to user_session_path
    end
    @month = params[:month]
    @publisherName = params[:publisher_select]
    if @publisherName.present? && @month.present?
      @books = Book.where('salesDate LIKE ?', "%#{@month}%").where(publisherName: @publisherName)
      @no_results = '漫画は見つかりませんでした。' if @books.blank?
    end
  end

  def download
    @downloads = Newly.order('created_at DESC')
    if current_user.admin == true && current_user.downloadadmin == true
      @page = '1'
      @select_month = params[:month]
      now = Time.current
      @check_page = 0
      @publisherName = params[:publisher_select]
      @books = []
      @counter = 0

      case @select_month
      when now.strftime('%Y年%m月') then
        @month = now.strftime('%m')
        @pre_month = now.prev_month.strftime('%m')
      when now.next_month.strftime('%Y年%m月') then
        @month = now.next_month.strftime('%m')
        @pre_month = now.strftime('%m')
      when now.since(2.month).strftime('%Y年%m月') then
        @month = now.since(2.month).strftime('%m')
        @pre_month = now.next_month.strftime('%m')
      end

      if @publisherName.present? && @month.present? && @pre_month.present?
        books_search
        while @check_page == 0
          @page = @page.to_i + 1
          @page.to_s
          books_search
        end
        Newly.create(
          publisherName: @publisherName,
          counter: @counter,
          month: @month
        )
      end
    else
      flash[:warning] = '権限がありません'
      redirect_to root_path
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

  def books_search
    results = RakutenWebService::Books::Book.search(
      publisherName: @publisherName,
      booksGenreId: '001001',
      outOfStockFlag: '1',
      sort: '-releaseDate',
      page: @page
    )
    results.each do |result|
      book = Book.new(read(result))
      @check_page = 1 if book.salesDate =~ /#{@pre_month}月/
      next if book.title =~ /コミックカレンダー|(巻|冊|BOX)セット/

      next unless book.salesDate =~ /#{@month}月/

      comic = Book.find_or_initialize_by(isbn: book.isbn)
      unless comic.persisted?
        @counter += 1
        book.save
      end
    end
  end

  def read(result)
    title = result['title']
    author = result['author']
    publisherName = result['publisherName']
    url = result['itemUrl']
    salesDate = result['salesDate']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '?_ex=350x350')
    series = view_context.series_create(result['title'])
    salesint = result['salesDate'].gsub(/年|月|日/, '').to_i
    {
      title: title,
      author: author,
      publisherName: publisherName,
      url: url,
      salesDate: salesDate,
      isbn: isbn,
      image_url: image_url,
      series: series,
      salesint: salesint
    }
  end
end
