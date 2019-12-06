# frozen_string_literal: true

Bookseries.all.each do |series|
  series.update(publisher: Book.find_by(series: series.title).publisherName) if series.publisher.nil?
end
