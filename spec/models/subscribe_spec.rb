require 'rails_helper'

RSpec.describe Subscribe, type: :model do
  it "有効なSubscribeレコードが登録できること" do
    expect(FactoryBot.build(:subscribe)).to be_valid
  end

  it "user_idがないときは無効であること" do
    expect(FactoryBot.build(:subscribe, user_id: nil)).to be_invalid
  end

  it "book_idがないときは無効であること" do
    expect(FactoryBot.build(:subscribe, book_id: nil)).to be_invalid
  end

  it "user_idとbook_idの組み合わせが重複しているときは無効であること" do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    FactoryBot.create(
      :subscribe,
      user: user,
      book: book
    )
    other_subscribe = FactoryBot.build(
      :subscribe,
      user: user,
      book: book
    )
    other_subscribe.valid?
    expect(other_subscribe.errors[:user_id]).to include 'はすでに存在します'
  end
end