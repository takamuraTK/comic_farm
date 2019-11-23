# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reviewfavorite, type: :model do
  it '有効なReviewfavoriteレコードが登録できること' do
    expect(FactoryBot.build(:reviewfavorite)).to be_valid
  end

  it 'user_idがないときは無効であること' do
    expect(FactoryBot.build(:reviewfavorite, user_id: nil)).to be_invalid
  end

  it 'review_idがないときは無効であること' do
    expect(FactoryBot.build(:reviewfavorite, review_id: nil)).to be_invalid
  end

  it 'user_idとreview_idの組み合わせが重複しているときは無効であること' do
    user = FactoryBot.create(:user)
    review = FactoryBot.create(:review)
    FactoryBot.create(
      :reviewfavorite,
      user: user,
      review: review
    )
    other_reviewfavorite = FactoryBot.build(
      :reviewfavorite,
      user: user,
      review: review
    )
    other_reviewfavorite.valid?
    expect(other_reviewfavorite.errors[:user_id]).to include 'はすでに存在します'
  end
end
