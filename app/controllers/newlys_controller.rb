class NewlysController < ApplicationController
  def search
    unless user_signed_in?
      flash[:warning] = '新刊検索をするにはログインが必要です。'
      redirect_to user_session_path
    end
    @month = params[:month]
    @publisherName = params[:publisher_select]
    if @publisherName.present? && @month.present?
      @books = Book.where("salesDate LIKE ?", "%2019年#{@month}月%").where(publisherName: @publisherName)
      if @books.blank?
        @no_results = "漫画は見つかりませんでした。"
      end
    end
  end

  def download
    @downloads = Newly.order("created_at DESC")
    if current_user.admin == true
      @page = '1'
      @month = params[:month]
      if @month == '01'
        @month = '13'
      end
      @pre_month = @month.to_i - 1
      @check_page = 0
      @publisherName = params[:publisher_select]
      @books = []
      @counter = 0

      if @publisherName.present?
        books_search
        while @check_page == 0
          @page = @page.to_i + 1
          @page.to_s
          books_search
        end
        Newly.create(
          publisherName: @publisherName,
          counter: @counter,
          month: @month,
        )
      end
    else
      flash[:warning] = "権限がありません"
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
        comics = Book.where("title LIKE ?", "%#{book}%").where("salesDate LIKE ?", "%#{@year}年#{@month}月%")
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
      results = RakutenWebService::Books::Book.search({
        isbn: @book.isbn,
        outOfStockFlag: '1',
      })
      @book = Book.new(read(results.first))
      @book.save
    end
  end

  private

  def books_search
    results = RakutenWebService::Books::Book.search({
      publisherName: @publisherName,
      booksGenreId: '001001',
      outOfStockFlag: '1',
      sort: '-releaseDate',
      page: @page
    })
    results.each do |result|
      book = Book.new(read(result))
      if book.salesDate =~ /#{@pre_month.to_s}月/
        @check_page = 1
      end
      unless book.title =~ /コミックカレンダー|(巻|冊|BOX)セット/
        if book.salesDate =~ /#{@month}月/
          comic = Book.find_or_initialize_by(isbn: book.isbn)
          unless comic.persisted?
            @counter += 1
            book.save
          end
        end
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
    salesint = result['salesDate'].gsub(/年|月|日/,"").to_i
    {
      title: title,
      author: author,
      publisherName: publisherName,
      url: url,
      salesDate: salesDate,
      isbn: isbn,
      image_url: image_url,
      series: series,
      salesint: salesint,
    }
  end
end