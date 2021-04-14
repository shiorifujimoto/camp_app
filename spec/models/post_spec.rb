require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @post = FactoryBot.build(:post)
  end

  describe '新規投稿機能' do
    context '正常系' do
      it 'title,article_text,suatus_id,category_id,imagesが存在すれば場合、投稿できる' do
        expect(@post).to be_valid
      end
    end

    context '異常系' do
      it 'imagesが空の場合、投稿できない' do
        @post.images = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("画像を入力してください")
      end

      it 'titleが空の場合、投稿できない' do
        @post.title = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルを入力してください")
      end

      it 'titleが21文字以上の場合、投稿できない' do
        @post.title = "test-title!test-title"
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルは20文字以内で入力してください")
      end

      it 'article_textが空の場合、投稿できない' do
        @post.article_text = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("記事テキストを入力してください")
      end

      it 'article_textが301文字以上の場合、投稿できない' do
        @post.article_text = "テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！テストテキストです！＿"
        @post.valid?
        expect(@post.errors.full_messages).to include("記事テキストは300文字以内で入力してください")
      end

      it 'status_idが1の場合、投稿できない' do
        @post.status_id = 1
        @post.valid?
        expect(@post.errors.full_messages).to include("公開/非公開を選んでください")
      end

      it 'category_idが1の場合、投稿できない' do
        @post.category_id = 1
        @post.valid?
        expect(@post.errors.full_messages).to include("カテゴリーを選んでください")
      end
    end
  end 
end
