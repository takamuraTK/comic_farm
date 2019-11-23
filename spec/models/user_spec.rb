# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なuserレコードが登録できること' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it '名前がないときは無効であること' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it '名前があるときは有効であること' do
    user = FactoryBot.build(:user, name: 'taro')
    user.valid?
    expect(user).to be_valid
  end

  it 'メールアドレスがないときは無効であること' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'メールアドレスの形式が不正のときは無効であること' do
    user = FactoryBot.build(:user, email: 'abc')
    user.valid?
    expect(user.errors[:email]).to include('は不正な値です')
  end

  it 'メールアドレスの形式が正しいときは有効であること' do
    user = FactoryBot.build(:user, email: 'aiueo@example.com')
    user.valid?
    expect(user).to be_valid
  end

  it 'メールアドレスが他のユーザーと重複しているときは無効であること' do
    FactoryBot.create(:user, email: 'hoge@example.com')
    user = FactoryBot.build(:user, email: 'hoge@example.com')
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end

  it 'パスワードがないときは無効であること' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it 'パスワードが6文字未満のときは無効であること' do
    user = FactoryBot.build(:user, password: 'abcde')
    expect(user).to_not be_valid
  end

  it 'パスワードが6文字以上のときは有効であること' do
    user = FactoryBot.build(:user, password: 'abcdef')
    expect(user).to be_valid
  end

  it 'プロフィール文が空でも有効であること' do
    user = FactoryBot.build(:user, profile: nil)
    user.valid?
    expect(user).to be_valid
  end

  it 'プロフィール文が1000文字より多い場合は無効であること' do
    user = FactoryBot.build(:user, profile: 'a' * 1001)
    user.valid?
    expect(user).to_not be_valid
  end
end
