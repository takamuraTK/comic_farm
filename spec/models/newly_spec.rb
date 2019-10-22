require 'rails_helper'
RSpec.describe Newly, type: :model do
  it "有効なnewlyレコードが登録できること" do
    expect(FactoryBot.build(:newly)).to be_valid
  end

  it "publisherNameがないときは無効であること" do
    expect(FactoryBot.build(:newly, publisherName: nil)).to be_invalid
  end

  it "counterがないときは無効であること" do
    expect(FactoryBot.build(:newly, counter: nil)).to be_invalid
  end

  it "monthがないときは無効であること" do
    expect(FactoryBot.build(:newly, month: nil)).to be_invalid
  end
end
