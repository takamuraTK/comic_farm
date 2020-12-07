# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn_id])
    unless @book.persisted?
      @book = Book.new(view_context.search_isbn(params[:isbn_id]))
      @book.save
    end
    current_user.addfav(@book)
  end

  def destroy
    @book = Book.find_or_initialize_by(isbn: params[:isbn_id])
    current_user.removefav(@book)
  end
end
