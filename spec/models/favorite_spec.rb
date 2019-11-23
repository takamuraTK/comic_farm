# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it '有効なFavoriteレコードが登録できること' do
    expect(FactoryBot.build(:favorite)).to be_valid
  end

  it 'user_idがないときは無効であること' do
    expect(FactoryBot.build(:favorite, user_id: nil)).to be_invalid
  end

  it 'book_idがないときは無効であること' do
    expect(FactoryBot.build(:favorite, book_id: nil)).to be_invalid
  end

  it 'user_idとbook_idの組み合わせが重複しているときは無効であること' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    FactoryBot.create(
      :favorite,
      user: user,
      book: book
    )
    other_favorite = FactoryBot.build(
      :favorite,
      user: user,
      book: book
    )
    other_favorite.valid?
    expect(other_favorite.errors[:user_id]).to include 'はすでに存在します'
  end
end
