require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザ新規登録' do
    context '正常系' do
      it 'nickname,last_name,first_name,email,password,assword_confirmation,profileが存在すれば場合、登録できる' do
        expect(@user).to be_valid
      end

      it 'profileが存在しない場合、登録できる' do
        @user.profile = ''
        expect(@user).to be_valid
      end
    end

    context '異常系' do
      it 'nicknameが空の場合、登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank") 
      end

      it 'last_nameが空の場合、登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank") 
      end

      it 'last_nameがひらがな、カナ、漢字でない場合、登録できない' do
        @user.last_name = 'Suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name ひらがな、カナ、漢字のみが使えます") 
      
      end

      it 'first_nameが空の場合、登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank") 
      end

      it 'first_nameがひらがな、カナ、漢字でない場合、登録できない' do
        @user.first_name = 'Takuto'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name ひらがな、カナ、漢字のみが使えます") 
      end

      it 'emailが空の場合、登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank") 
      end

      it 'emailに＠が含まれていない場合、登録できない' do
        @user.email = 'suzukigmail.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid") 
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空の場合、登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank") 
      end

      it 'passwordが５文字以下の場合、登録できない' do
        @user.password = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 英数字で6文字以上を入力してください")
      end

      it 'passwordが半角数字が含まれていない場合、登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 英数字で6文字以上を入力してください")
      end

      it 'passwordが半角英字が含まれていない場合、登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 英数字で6文字以上を入力してください")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'xyz987'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'profileが51文字以上の場合登録できない' do
        @user.profile = 'あいうえおあいう１０あいうえおあいう２０あいうえおあいう３０あいうえおあいう４０あいうえおあいう５０ん'
        @user.valid?
        expect(@user.errors.full_messages).to include("Profile 最大50文字まで使えます")
      end
    end
  end  
end
