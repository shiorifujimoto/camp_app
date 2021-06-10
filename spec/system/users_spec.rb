require 'rails_helper'

RSpec.describe "Users/registrations#new", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに遷移する' do
      # トップページに遷移する
      visit root_path
      # トップページに新規登録方法の選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # サインアップ方法の選択ページへ遷移する
      visit new_user_path
      # メールアドレスによるサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('メールアドレスで登録')
      # 新規登録ページへ遷移する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_last_name', with: @user.last_name
      fill_in 'user_first_name', with: @user.first_name
      fill_in 'user_last_name', with: @user.last_name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect{
      find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 登録完了が表示されていることを確認する
      expect(page).to have_content('アカウント登録が完了しました')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに遷移する
      visit root_path
      # トップページに新規登録方法の選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # サインアップ方法の選択ページへ遷移する
      visit new_user_path
      # メールアドレスによるサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('メールアドレスで登録')
      # 新規登録ページへ遷移する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_last_name', with: ''
      fill_in 'user_first_name', with: ''
      fill_in 'user_last_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # サインアップボタンを押しても、ユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'devise/sessions#new', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # フラッシュメッセージ「ログインしました。」が表示されることを確認する
      expect(page).to have_content('ログインしました')
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # 新規登録ボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      # ログインページへ遷移するボタンが表示されていないことを確認するため、再度トップページに遷移（リロード）する
      visit root_path
      # ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
