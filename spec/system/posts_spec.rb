require 'rails_helper'

RSpec.describe "Post#new", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_title  = '大芝キャンプ場'
    @post_article_text = '大芝キャンプ場楽しかったです！'
    @post_status_id    = '公開'
    @post_category_id  = 'キャンプ場'
    @post_image_path = Rails.root.join('public/images/test_image.png')
  end
  context '記事投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクボタンがあることを確認する
      expect(page).to have_link('新規投稿'), href: new_post_path
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      select @post_status_id, from: 'post_status_id'
      select @post_category_id, from: 'post_category_id'
      fill_in 'article_title', with: @post_title
      attach_file('post[images][]', @post_image_path, make_visible: true)
      fill_in 'article__text', with: @post_article_text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Post.count }.by(1)
      # フラッシュメッセージ「投稿しました」の文字があることを確認する
      expect(page).to have_content('投稿しました')
      # 詳細ページには先ほど投稿した内容の記事が存在することを確認する（画像）
      expect(page).to have_selector('img')
      # 詳細ページには先ほど投稿した内容の記事が存在することを確認する（タイトル）
      expect(page).to have_content(@post_title)
      # 詳細ページには先ほど投稿した内容の記事が存在することを確認する（テキスト）
      expect(page).to have_content(@post_article_text)
      # 詳細ページにはいいねボタンがあることを確認する
      expect(page).to have_selector '#like_btn'
      # 詳細ページにはお気に入りボタンがあることを確認する
      expect(page).to have_selector '#favorite_btn'
      # 詳細ページには編集ページへ遷移するボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_post_path(@user.posts.ids)
      # 詳細ページには削除するボタンがあることを確認する
      expect(page).to have_link '削除', href: post_path(@user.posts.ids)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容の記事が存在することを確認する（タイトル）
      expect(page).to have_content(@post_title)
      # トップページには先ほど投稿した内容の記事が存在することを確認する（公開/非公開）
      expect(page).to have_content("公開")
      # トップページには先ほど投稿した内容の記事が存在することを確認する（画像）
      expect(page).to have_selector('img')
    end
  end
  context '記事投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへの遷移ボタンをクリックする
      click_on('新規投稿')
      # ログインぺージに遷移したことを確認する
      expect(current_path).to eq(new_user_session_path)
      # アカウント登録もしくはログインを求める表示があることを確認する
      expect(page).to have_content('アカウント登録もしくはログインしてください。')
    end
  end
end

RSpec.describe 'Post#edit', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '記事編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した記事の編集ができる' do
      # 記事1を投稿したユーザーでログインする
      sign_in(@post1.user)
      # 記事1の詳細ページへ遷移する
      visit post_path(@post1)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_post_path(@post1)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容が各フォームに入っていることを確認する
      expect(
        (find('#post_status_id').value).to_i 
      ).to eq @post1.status_id
      expect(
        (find('#post_category_id').value).to_i 
      ).to eq @post1.category_id
      expect(
        find('#article_title').value
      ).to eq @post1.title
      expect(page).to have_selector('img')
      expect(
        find('#article__text').value
      ).to eq @post1.article_text
      # 投稿内容を編集する
      fill_in 'article__text',with:"#{@post1.article_text} 編集済"
      # 編集してもpostモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Post.count }.by(0)
      # 詳細ページにリダイレクトしたことを確認する
      expect(current_path).to eq(post_path(@post1))
      # フラッシュメッセージ「編集しました」の文字があることを確認する
      expect(page).to have_content('編集しました')
      # 変更した内容が存在することを確認する（テキスト）
      expect(page).to have_content("#{@post1.article_text} 編集済")
    end
  end
  context '投稿記事の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿記事の編集画面には遷移できない' do
      # 記事1を投稿したユーザーでログインする
      sign_in(@post1.user)
      # 記事2の詳細ページへ遷移する
      visit post_path(@post2)
      # 「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
    it 'ログインしていないと投稿記事の編集画面には遷移できない' do
      # トップページへ遷移する
      visit root_path
      # 「ログイン」ボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # 記事1の詳細ページへ遷移する
      visit post_path(@post1)
      # 「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post1)
      # 記事2の詳細ページへ遷移する
      visit post_path(@post2)
      # 「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
  end
end

RSpec.describe 'Post#destroy', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
    sleep(1)
  end
  context '記事の削除ができるとき' do
    it 'ログインしたユーザーは自分が投稿した記事の削除ができる' do
      # ログインする
      sign_in(@post1.user)
      # 詳細ページへ遷移する
      visit post_path(@post1)
      # 「削除」へのリンクがあることを確認する
      expect(page).to have_link '削除', href: post_path(@post1)
      # 「削除」へのリンクをクリックするとpostモデルのカウントが1下がることを確認する
      expect {
        find_link('削除',  href: post_path(@post1)).click
      }.to change { Post.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # フラッシュメッセージ「削除しました」の文字があることを確認する
      expect(page).to have_content('削除しました')
    end
  end
  context '投稿した記事が削除できないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事を削除できない' do
      # ログインする
      sign_in(@post1.user)
      # 記事2の詳細ページへ遷移する
      visit post_path(@post2)
      # 「削除」のリンクがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
    it 'ログインしていない状態で投稿記事詳細ページに遷移できるものの、削除ボタンが表示されない' do
      # トップページへ遷移する
      visit root_path
      # 「ログイン」ボタンがあることを確認する
      expect(page).to have_link 'ログイン', href: new_user_session_path
      # 記事1詳細ページへ遷移する
      visit post_path(@post1)
      # 「削除」のリンクボタンがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post1)
      # 記事2詳細ページへ遷移する
      visit post_path(@post2)
      # 「削除」のリンクボタンがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
  end
end

RSpec.describe 'Post#show', type: :system do
  before do
    @post = FactoryBot.create(:post)
    sleep(1)
  end
  it 'ログインしたユーザーは、記事詳細ページにコメント投稿欄が表示される' do
    # ログインする
    sign_in(@post.user)
    # 詳細ページへ遷移する
    visit post_path(@post)
    # コメント用のフォームがあることを確認する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で詳細ページに遷移できるものの、コメント投稿欄が表示されない' do
    # トップページに遷移する
    visit root_path
    # 記事タイトルに詳細ページへのリンクがあることを確認する
    expect(page).to have_link @post.title, href: post_path(@post)
    # 詳細ページへ遷移する
    visit post_path(@post)
    # コメント用のフォームがないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」の表示があることを確認する
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要です')
  end
end
