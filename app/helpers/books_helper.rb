module BooksHelper

def change_isbn(isbn13)
  # 手順１：まず、 ISBN13の先頭3文字と末尾1文字を捨てます。
  body = isbn13[3..-2]

  # 手順２：それぞれの数にについて、下記のように計算します。
  # 4*10 + 0*9 + 6*8 + 3*7 + 8*6 + 4*5 + 2*4 +7*3 + 6*2 = 218
  sum = body.each_char.map.with_index{|a,b| a.to_i * (10-b) }.sum

  # 手順３：手順２の結果を11で割った余りを求めます。
  mod = sum % 11

  # 手順４：「11 - 手順３の答え」　を計算します。
  raw_digit = 11 - mod

  # 手順５：手順４の答えが 11なら0に,10ならxに置き換えます。それ以外ならそのまま。
  digit =
    case raw_digit
    when 11 then '0'
    when 10 then 'X'
    else raw_digit.to_s
    end

  # 手順６：手順５の結果がチェックディジットです。これを手順１の末尾に付けます。
  "#{body}#{digit}"
end

end