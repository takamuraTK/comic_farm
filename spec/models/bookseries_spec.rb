require 'rails_helper'

RSpec.describe Bookseries, type: :model do
  it "titleがないときは無効であること" do
    bookseries = FactoryBot.build(:bookseries, title: nil)
    bookseries.valid?
    expect(bookseries.errors[:title]).to include("を入力してください")
  end
end