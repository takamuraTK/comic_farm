module BooksHelper
  def search_books(title, sort, page)
    results = RakutenWebService::Books::Book.search(
        title: title,
        booksGenreId: '001001',
        outOfStockFlag: '1',
        sort: sort,
        page: page
      )
    results.each do |result|
      book = Book.new(read(result))
      @books << book unless book.title =~ /コミックカレンダー|(巻|冊|BOX)セット/
    end
  end

  def search_isbn(isbn)
    results = RakutenWebService::Books::Book.search(
      isbn: isbn,
      outOfStockFlag: '1'
    )
    return read(results.first)
  end

  def read(result)
    {
      title: result['title'],
      author: result['author'],
      publisherName: result['publisherName'],
      url: result['itemUrl'],
      salesDate: result['salesDate'],
      isbn: result['isbn'],
      image_url: result['mediumImageUrl'].gsub('?_ex=120x120', '?_ex=350x350'),
      series: series_create(result['title']),
      salesint: result['salesDate'].gsub(/年|月|日/, '').to_i
    }
  end

  def series_create(title)
    title.sub(
      /\（.*|\(.*|\p{blank}\d.*|公式ファンブック.*|外伝.*|\p{blank}巻ノ.*/,""
      )
    .gsub(
      /\p{blank}/,""
      )
  end

  def publisher_name_array
    return ['集英社', '小学館', '講談社', '竹書房', '白泉社', '新潮社', '双葉社', '宙出版','秋田書店','少年画報社', 'KADOKAWA', 'ハーパーコリンズ・ジャパン']
  end

  def change_isbn(isbn13)
    body = isbn13[3..-2]

    sum = body.each_char.map.with_index{|a,b| a.to_i * (10-b) }.sum

    mod = sum % 11

    raw_digit = 11 - mod

    digit =
      case raw_digit
      when 11 then '0'
      when 10 then 'X'
      else raw_digit.to_s
      end

    "#{body}#{digit}"
  end
end