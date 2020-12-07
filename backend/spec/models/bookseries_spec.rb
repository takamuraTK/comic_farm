# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookseries, type: :model do
  it '有効なBookseriesレコードが登録できること' do
    expect(FactoryBot.build(:bookseries)).to be_valid
  end

  it 'titleがないときは無効であること' do
    bookseries = FactoryBot.build(:bookseries, title: nil)
    bookseries.valid?
    expect(bookseries.errors[:title]).to include('を入力してください')
  end

  it 'titleが重複したときは無効であること' do
    FactoryBot.create(:bookseries, title: 'hogehoge')
    bookseries = FactoryBot.build(:bookseries, title: 'hogehoge')
    bookseries.valid?
    expect(bookseries.errors[:title]).to include('はすでに存在します')
  end

  it 'publisherがないときは無効であること' do
    bookseries = FactoryBot.build(:bookseries, publisher: nil)
    bookseries.valid?
    expect(bookseries.errors[:publisher]).to include('を入力してください')
  end
end
