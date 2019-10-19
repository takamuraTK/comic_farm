require 'rails_helper'

RSpec.describe Review, type: :model do
  it "有効なreviewレコードが登録できること" do
    expect(FactoryBot.build(:review)).to be_valid
  end

  it "user_idがないときは無効であること" do
    expect(FactoryBot.build(:review, user_id: nil)).to be_invalid
  end

  it "book_idがないときは無効であること" do
    expect(FactoryBot.build(:review, book_id: nil)).to be_invalid
  end

  it "headがないときは無効であること" do
    review = FactoryBot.build(:review, head: nil)
    review.valid?
    expect(review.errors[:head]).to include("を入力してください","は1文字以上で入力してください")
  end

  it "headが21文字以上のときは無効であること" do
    review = FactoryBot.build(:review, head: "a" * 21)
    review.valid?
    expect(review.errors[:head]).to include("は20文字以内で入力してください")
  end

  it "contentがないときは無効であること" do
    review = FactoryBot.build(:review, content: nil)
    review.valid?
    expect(review.errors[:content]).to include("を入力してください","は1文字以上で入力してください")
  end

  it "contentが2000文字以上のときは無効であること" do
    review = FactoryBot.build(:review, content: "a" * 2001)
    review.valid?
    expect(review.errors[:content]).to include("は2000文字以内で入力してください")
  end

  it "pointがないときは無効であること" do
    review = FactoryBot.build(:review, point: nil)
    review.valid?
    expect(review.errors[:point]).to include("を入力してください")
  end

  it "pointが5.1以上のときは無効であること" do
    expect(FactoryBot.build(:review, point: 5.1)).to be_invalid
  end

end