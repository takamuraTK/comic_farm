class BooksController < ApplicationController
  def new
    unless user_signed_in?
      flash[:warning] = '漫画を探すにはログインが必要です。'
      redirect_to user_session_path
    end
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        booksGenreId: '001001',
        sort: '+releaseDate',
      })
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(15)
  end
  
  def monthly
    @books = Book.where("salesDate LIKE ?", "%2019年07月%")
  end
  
  
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
  end
  
  
  def show
    unless user_signed_in?
      flash[:warning] = '漫画の詳細ページをみるにはログインが必要です。'
      redirect_to user_session_path
    end
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
  end
  
  def ranking
    unless user_signed_in?
      flash[:warning] = '登録数ランキングをみるにはログインが必要です。'
      redirect_to user_session_path
    end
    @book_subs_count = Book.joins(:subscribes).group(:book_id).count
    @book_subs_ids = Hash[@book_subs_count.sort_by{ |_, v| -v }].keys
    @book_ranking = Book.where(id: @book_subs_ids).page(params[:page]).per(10)
    
    if params[:page].nil?
      @rank = 1
    else
      page = params[:page].to_i
      @rank = (page - 1)*10 + 1
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