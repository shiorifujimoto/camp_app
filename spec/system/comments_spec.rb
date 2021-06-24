require 'rails_helper'

RSpec.describe 'Comments#create', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @comment = Faker::Lorem.sentence
    sleep(1)
  end
  it 'ログインしたユーザーは記事詳細ページに遷移した場合、コメント投稿ができる' do
    # ログインする
    sign_in(@post.user)
    # コメントする
    to_comment(@post,@comment)
    # 投稿したコメントが表示されていることを確認する
    expect(page).to have_content(@comment)
  end
end

RSpec.describe 'Comments#destroy', type: :system do
  before do
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
  end
  context 'コメントが削除できるとき' do
    it 'ログイン後、ユーザー自身が投稿したコメントのみ、削除ができる' do
      # ログインする
      sign_in(@comment1.user)
      # コメントした記事詳細ページへ遷移する
      visit post_path(@comment1.post)
      # ユーザー自身のコメントに「コメント削除」ボタンが表示されていることを確認する
      expect(page).to have_content 'コメント削除'
      # 「コメント削除」ボタンをクリックすると、commentモデルのカウントが1下がることを確認する
      expect{
        click_on('コメント削除')
      }.to change { Comment.count }.by(-1)
    end
  end
  context 'コメント削除ができないとき' do
    it 'ログインしていない場合、ユーザー自身が投稿したコメントには、削除ボタンが表示されない' do
      # 詳細ページへ遷移する
      visit post_path(@comment1.post)
      # 「コメント削除」ボタンがないことを確認する
      expect(page).to have_no_content 'コメント削除'
    end
    it '他ユーザーが投稿したコメントには、削除ボタンが表示されない' do
      # ログインする
      sign_in(@comment1.user)
      # 他ユーザーのコメント投稿がされている詳細ページへ遷移する
      visit post_path(@comment2.post)
      # 「コメント削除」ボタンがないことを確認する
      expect(page).to have_no_content 'コメント削除'
    end
  end
end