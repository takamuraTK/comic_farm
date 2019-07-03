class BooksController < ApplicationController
  def new
    @books = []
    
    @title = params[:title]
    
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        booksGenreId: '001001'
      })
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end
  
  
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
  end
  
  
private
  
  def read(result)
    title = result['title']
    author = result['author']
    publisherName = result['publisherName']
    url = result['itemUrl']
    salesDate = result['salesDate']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '?_ex=350x350')

    {
      title: title,
      author: author,
      publisherName: publisherName,
      url: url,
      salesDate: salesDate,
      isbn: isbn,
      image_url: image_url,
    }
  end
end