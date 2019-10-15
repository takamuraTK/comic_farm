class NewlysController < ApplicationController
  def shuei
    @page = '1'
    @month = '10'
    @publisherName = '集英社'
    @books = []
    books_search

      while @books.blank?
          @page = @page.to_i + 1
          @page.to_s
          books_search
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
      unless book.title =~ /コミックカレンダー|(巻|冊|BOX)セット/
        if book.salesDate =~ /#{@month}/
          @books << book
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
    series = result['title'].sub(/\（.*|\(.*|\s.*|公式ファンブック.*/,"")
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