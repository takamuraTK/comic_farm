# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Newly, type: :model do
  it '有効なnewlyレコードが登録できること' do
    expect(FactoryBot.build(:newly)).to be_valid
  end
end
