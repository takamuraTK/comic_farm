class SubscribesController < ApplicationController
  def create
    book = Book.find_or_initialize_by(isbn: params[:isbn_id])
    unless book.persisted?
        results = RakutenWebService::Books::Book.search({
          isbn: params[:isbn_id],
          outOfStockFlag: '1',
        })
        book = Book.new(read(results.first))
        book.save
    end
    current_user.addsub(book)
    flash[:success] = "登録完了しました！"
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    book = Book.find_or_initialize_by(isbn: params[:isbn_id])
    current_user.removesub(book)
    flash[:success] = "登録解除しました！"
    redirect_back(fallback_location: root_url)
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

