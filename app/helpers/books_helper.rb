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
end