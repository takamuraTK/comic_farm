module BooksHelper

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