# frozen_string_literal: true

class Newly < ApplicationRecord
  validates :publisherName, presence: true
  validates :counter, presence: true
  validates :month, presence: true
  before_validation :search_month_book

  def search_month_book
    str_month(month)
    str_pre_month(month)
    @check_page = 'running'
    @count = 0
    @page = 0

    while @check_page == 'running'
      @page += 1
      search_publisher(publisherName, @page)
    end

    self.counter = @count
  end

  def search_publisher(publisher, page)
    @results = RakutenWebService::Books::Book.search(
      publisherName: publisher,
      booksGenreId: '001001',
      outOfStockFlag: '1',
      sort: '-releaseDate',
      page: page
    )
    check_results(@results)
  end

  def check_results(results)
    results.each do |result|
      @book = Book.new(read(result))

      if @book.salesDate.include?(@pre_month)
        @check_page = 'stop'
        break
      end

      next unless @book.salesDate.include?(@month)

      save_result(@book)
    end
    @check_page
  end

  def save_result(book)
    comic = Book.find_or_initialize_by(isbn: book.isbn)
    unless comic.persisted?
      @count += 1 if book.save
    end
    @count
  end

  private

  def str_month(month)
    @month = month.in_time_zone.strftime('%Y年%m月')
  end

  def str_pre_month(month)
    @pre_month = month.in_time_zone.prev_month.strftime('%Y年%m月')
  end

  def read(result)
    { title: result['title'],
      author: result['author'],
      publisherName: result['publisherName'],
      url: result['itemUrl'],
      salesDate: result['salesDate'],
      isbn: result['isbn'],
      image_url: result['mediumImageUrl'].gsub('?_ex=120x120', '?_ex=350x350'),
      series: series_create(result['title']),
      salesint: result['salesDate'].gsub(/年|月|日/, '').to_i }
  end

  def series_create(title)
    title.sub(
      /（.*|\(.*|\p{blank}\d.*|公式ファンブック.*|外伝.*|\p{blank}巻ノ.*/, ''
    )
         .gsub(
           /\p{blank}/, ''
         )
  end
end
