# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :require_sign_in
  def new
    @books = []
    @page = params[:pageselect].presence || 1
    return unless params[:title].present?

    view_context.search_books(params[:title], params[:sortselect], @page)
    @no_results = '漫画は見つかりませんでした。' if @books.blank?
  end

  def show
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    return if @book.persisted?

    @book = Book.new(view_context.search_isbn(@book.isbn))
    @book.save
  end

  def ranking
    book_subs_ids = Hash[Subscribe.group(:book_id).count.sort_by { |_, v| -v }].keys
    @book_ranking = Book.where(id: book_subs_ids).order("FIELD(id, #{book_subs_ids.join(',')})").limit(30)
  end

  def review_ranking
    @book_review_average = Book.joins(:reviews).group(:book_id).average(:point)
    book_review_ids = Hash[@book_review_average.sort_by { |_, v| -v }].keys
    @review_ranking = Book.where(id: book_review_ids).order("FIELD(id, #{book_review_ids.join(',')})").limit(30)
  end

  private

  def require_sign_in
    return if user_signed_in?

    flash[:warning] = 'このページをみるにはログインが必要です。'
    redirect_to user_session_path
  end
end
