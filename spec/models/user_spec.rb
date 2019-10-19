require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー登録" do
    context "名前、メール、パスワードがある場合" do
      before do
        @user = User.new(
          name: "test_taro",
          email: "test@example.com",
          password: "testpass",
        )
      end
      it "有効な状態であること" do
        expect(@user).to be_valid
      end
    end

    context "何かしらが欠けているとき" do
      context "名前がない場合" do
        before do
          @user = User.new(name: nil)
          @user.valid?
        end
        it "無効な状態であること" do
          expect(@user.errors[:name]).to include("を入力してください")
        end
      end
      context "メールアドレスがない場合" do
        before do
          @user = User.new(email: nil)
          @user.valid?
        end
        it "無効な状態であること" do
          expect(@user.errors[:email]).to include("を入力してください")
        end
      end
      context "パスワードがない場合" do
        before do
          @user = User.new(password: nil)
          @user.valid?
        end
        it "無効な状態であること" do
          expect(@user.errors[:password]).to include("を入力してください")
        end
      end
    end
    
    context "メールアドレスが他と重複している場合" do
      before do
        User.create(
          name: "test_taro",
          email: "test@example.com",
          password: "testpass",
          confirmed_at: Time.zone.now,
        )
        @user = User.new(
          name: "test_hanako",
          email: "test@example.com",
          password: "testpass",
          confirmed_at: Time.zone.now,
        )
        @user.valid?
      end
      it "無効な状態であること" do
        expect(@user.errors[:email]).to include("はすでに存在します")
      end
    end

    context "メールアドレスが6文字未満の場合" do
      before do
        @user = User.new(password: "abcde")
        @user.valid?
      end
      it "無効な状態であること" do
        expect(@user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end
end
