# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it '有効なBookレコードを登録できること' do
    expect(FactoryBot.build(:book)).to be_valid
  end

  it 'titleがなければ無効であること' do
    expect(FactoryBot.build(:book, title: nil)).to be_invalid
  end

  it 'authorがなければ無効であること' do
    expect(FactoryBot.build(:book, author: nil)).to be_invalid
  end

  it 'publisherNameがなければ無効であること' do
    expect(FactoryBot.build(:book, publisherName: nil)).to be_invalid
  end

  it 'urlがなければ無効であること' do
    expect(FactoryBot.build(:book, url: nil)).to be_invalid
  end

  it 'urlが不正なURLの形式になっていれば無効であること' do
    expect(FactoryBot.build(:book, url: 'aaa')).to be_invalid
  end

  it 'urlが正しいURLの形式になっていれば有効であること' do
    expect(FactoryBot.build(:book, url: 'https://books.rakuten.co.jp/rb/0000000')).to be_valid
  end

  it 'salesDateがなければ無効であること' do
    expect(FactoryBot.build(:book, salesDate: nil)).to be_invalid
  end

  it 'isbnがなければ無効であること' do
    expect(FactoryBot.build(:book, isbn: nil)).to be_invalid
  end

  it 'isbnが13桁じゃないと無効であること' do
    expect(FactoryBot.build(:book, isbn: '123456789012')).to be_invalid
  end

  it 'image_urlがなければ無効であること' do
    expect(FactoryBot.build(:book, image_url: nil)).to be_invalid
  end

  it 'image_urlが不正なURLの形式になっていれば無効であること' do
    expect(FactoryBot.build(:book, image_url: 'aaa')).to be_invalid
  end

  it 'image_urlが正しいURLの形式になっていれば有効であること' do
    expect(FactoryBot.build(:book, image_url: 'https://books.rakuten.co.jp/rb/0000000.jpg')).to be_valid
  end

  it 'seriesがなければ無効であること' do
    expect(FactoryBot.build(:book, series: nil)).to be_invalid
  end

  it 'salesintがなければ無効であること' do
    expect(FactoryBot.build(:book, salesint: nil)).to be_invalid
  end
end
