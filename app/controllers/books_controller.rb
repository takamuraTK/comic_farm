# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :require_sign_in
  def new
    @books = []
    params[:sortselect].presence || 'standard'
    @page = params[:pageselect].presence || 1
    if params[:title].present?
      view_context.search_books(params[:title], params[:sortselect], @page)
      @no_results = '漫画は見つかりませんでした。' if @books.blank?
    end
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(30)
  end

  def show
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    unless @book.persisted?
      @book = Book.new(view_context.search_isbn(@book.isbn))
      @book.save
    end
  end

  def ranking
    book_subs_ids = Hash[Subscribe.group(:book_id).count.sort_by { |_, v| -v }].keys
    @book_ranking = Book.where(id: book_subs_ids).order("FIELD(id, #{book_subs_ids.join(',')})").page(params[:page]).per(10)
    params[:page].nil? ? (@rank = 1) : (@rank = (params[:page].to_i - 1) * 10 + 1)
  end

  def review_ranking
    @book_review_average = Book.joins(:reviews).group(:book_id).average(:point)
    book_review_ids = Hash[@book_review_average.sort_by { |_, v| -v }].keys
    @review_ranking = Book.where(id: book_review_ids).order("FIELD(id, #{book_review_ids.join(',')})").page(params[:page]).per(10)
    params[:page].nil? ? (@rank = 1) : (@rank = (params[:page].to_i - 1) * 10 + 1)
  end

  private

  def require_sign_in
    unless user_signed_in?
      flash[:warning] = 'このページをみるにはログインが必要です。'
      redirect_to user_session_path
    end
  end
end
