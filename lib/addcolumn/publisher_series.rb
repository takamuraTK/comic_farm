
Bookseries.all.each do |series|
  if series.publisher.nil?
    series.update(publisher: Book.find_by(series: series.title).publisherName)
  end
end