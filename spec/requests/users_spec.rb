require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    sleep(0.1)
  end

  describe "Get #index" do
    # indexアクションにリクエスト
    it '200レスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq(200)
    end
    context 'ログインした場合' do
      context '投稿件数が0件の場合' do
        it 'トップページに「まだ投稿していません」の文字が表示される' do
          sign_in(@user)
          get root_path
          expect(response.body).to include("まだ投稿していません")
        end
      end
      context '投稿件数が1件以上の場合' do
        it 'トップページに自身の投稿が表示される' do
          sign_in(@user)
          @p = FactoryBot.create(:post,user: @user)
          get root_path
          expect(response.body).to include(@p.title)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'トップページに他のユーザーの投稿が表示される' do
        get root_path
        expect(response.body).to include(@post.title)
      end
    end
  end
  describe "Get #new" do
    # newアクションにリクエスト
    it '200レスポンスが返ってくる' do
        get new_user_path
        expect(response.status).to eq(200)
    end
  end
  describe "Get #show" do
    # showアクションにリクエスト
    it '200レスポンスが返ってくる' do
      get user_path(@user)
      expect(response.status).to eq(200)
    end

    describe '特定のレスポンスが返ってくる' do
      it 'プロフィールが設定済みの場合、プロフィールがレスポンスに返ってくる' do
        get user_path(@user)
        expect(response.body).to include(@user.profile)
      end
      it 'ユーザー自身のマイページには、氏名のレスポンスが返ってくる' do
        sign_in(@user)
        get user_path(@user)
        expect(response.body).to include("#{@user.last_name} #{@user.first_name}")
      end
      it 'ユーザー自身のマイページには、emailのレスポンスが返ってくる' do
        sign_in(@user)
        get user_path(@user)
        expect(response.body).to include(@user.email)
      end
    end
    describe '特定のレスポンスが返ってこない' do
      context 'ログインしていない場合' do
        it 'ユーザーページには、氏名のレスポンスが返ってこない' do
          get user_path(@user)
          expect(response.body).not_to include("#{@user.last_name} #{@user.first_name}")
        end
        it 'ユーザーページには、emailのレスポンスが返ってこない' do
          get user_path(@user)
          expect(response.body).not_to include(@user.email)
        end
      end
      context 'ログインしている場合' do
        it '他のユーザーページには、氏名のレスポンスが返ってこない' do
          sign_in(@user)
          get user_path(@another_user)
          expect(response.body).not_to include("#{@user.last_name} #{@user.first_name}")
        end
        it '他のユーザーページには、emailのレスポンスが返ってこない' do
          sign_in(@user)
          get user_path(@another_user)
          expect(response.body).not_to include(@user.email)
        end
      end
    end
  end
  describe "Get #edit" do
    # editアクションにリクエスト
    context 'ログインしている場合' do
      it '200レスポンスが返ってくる' do
        sign_in(@user)
        get edit_user_path(@user)
        expect(response.status).to eq(200)
      end
    end
    context 'ログインしていない場合' do
      it '302レスポンスが返ってくる' do
        get edit_user_path(@user)
        expect(response.status).to eq(302)
      end
    end
  end
end