class SubscribesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    current_user.addsub(book)
    flash[:success] = "登録完了しました！"
    redirect_back(fallback_location: 'book'+book.isbn)
  end
  
  def destroy
    book = Book.find(params[:book_id])
    current_user.removesub(book)
    flash[:success] = "登録解除しました！"
    redirect_back(fallback_location: 'book'+book.isbn)
  end
end
