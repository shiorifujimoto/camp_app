require 'rails_helper'

describe "PostsController", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  describe "GET #index" do
    # indexアクションにリクエスト
    it '200レスポンスが返ってくる' do
      get posts_path
      expect(response.status).to eq 200
    end
    it 'レスポンスに投稿済みの記事のタイトルが存在する' do
      get posts_path
      expect(response.body).to include(@post.title)
    end
    it 'レスポンスに投稿済みの画像が存在する' do
      get posts_path
      expect(response.body).to include('img')
    end
    it 'レスポンスに投稿済みの記事のユーザーニックネームが存在する' do
      get posts_path
      expect(response.body).to include(@post.user.nickname)
    end
  end

  describe "GET #show" do
    # showアクションにリクエスト
    it '200レスポンスが返ってくる' do
      get post_path(@post)
      expect(response.status).to eq 200
    end
    it 'レスポンスに投稿済みの記事のタイトルが存在する' do
      get post_path(@post)
      expect(response.body).to include(@post.title)
    end
    it 'レスポンスに投稿済みの記事のテキストが存在する' do
      get post_path(@post)
      expect(response.body).to include(@post.article_text)
    end
    it 'レスポンスに投稿済みの記事の日付が存在する' do
      get post_path(@post)
      expect(response.body).to include("#{@post.created_at.year}/#{@post.created_at.month}/#{@post.created_at.day}")
    end
    it 'レスポンスに投稿済みの記事の画像が存在する' do
      get post_path(@post)
      expect(response.body).to include('img')
    end
    it 'レスポンスに投稿済みの記事のユーザーニックネームが存在する' do
      get post_path(@post)
      expect(response.body).to include(@post.user.nickname)
    end
    it 'レスポンスにコメント一覧表示部分が存在する' do
      get post_path(@post)
      expect(response.body).to include('＜コメント一覧＞')
    end
  end

  describe "GET #new" do
    # newアクションにリクエスト
    context 'ログインしている場合' do
      it '200レスポンスが返ってくる' do
        sign_in(@user)
        get new_post_path
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it "302レスポンスが返ってくる" do
        get new_post_path
        expect(response.status).to eq 302
      end
    end
  end
end
