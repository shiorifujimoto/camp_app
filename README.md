# アプリケーション名
  マイキャン

# 概要
  キャンプに限定した内容を投稿してもらうための投稿アプリです。  
  キャンプ記事の投稿及び編集、削除、投稿へのユーザー間のコメント、いいね、お気に入り機能、ユーザー情報の編集。

# 制作背景
- キャンプの思い出が振り返ると、いつどこでの出来事なのか、携帯写真データや記憶が混ざりがちなキャンプユーザーのために制作。  
- 写真だけでなくコメントをつけられたらより鮮明に思い出が残ると思いました。  
- 個人のキャンプの思い出をコメントをつけて記録し、その投稿で大切な楽しい時間を振り返ることを目的で使用します。  
  また、他のキャンプユーザーの情報も閲覧できる事で、よりキャンプライフの充実を図る。

# 利用方法
- アカウントの登録(SNS認証または手打ち入力)をすること。
- アカウントを登録しない場合は、公開中の記事とそのコメント、投稿ユーザーの詳細閲覧のみに機能が限定される。
- ヘッダーに表示の新規投稿アイコンから、記事投稿ができる。
- 本人のみ投稿内容の編集、削除で自身の記事を管理する。
- 他ユーザーの投稿記事にコメント投稿することができ、また自身のコメントを削除できる。
- 自身及び他ユーザーの投稿記事に対し、いいねができる。
また、いいねを外すことができる。
- 自身及び他ユーザーの投稿記事に対し、お気に入り登録ができる。お気に入り登録をした記事は、マイページで一覧で表示される。お気に入りを外すことができ、外すと一覧に表示されなくなる。
- 本人のみユーザー情報の編集をすることができる。
- ユーザー情報のアカウントは、デフォルト画像から変更が可能。
- マイページからアカウントのログアウトができる。

# 目指した課題解決
- キャンプをする上で自身の思い出を鮮明に残すこと。  
- 携帯カメラで写真撮影をする機会が多くなったが、月日が経つと記憶が薄れてしまい鮮明に思い出せない。  
- キャンプライフの充実のため、他のキャンプユーザーのキャンプライフや自慢のキャンプギアを「見たい」「見せたい」を叶えること。

# 実装予定の機能
  AWSへのデプロイ  
  S3の実装

# データベース設計
![index](https://user-images.githubusercontent.com/57311261/117401078-d7e6ea80-af3e-11eb-97b6-5a342081d6df.png)

# ローカルでの動作方法(テスト用)
  http://localhost:3000/
### ログイン情報1
- Eメール : sena.04091919@gmail.com
- パスワード : 111111a
### ログイン情報2
- Eメール : natu@natu
- パスワード : 111111a

<!-- # URL -->
<!-- # 本番環境(デプロイ先 テストアカウント＆ID) -->
<!-- # テスト用アカウント -->
# DEMO
### トップページ
[![Image from Gyazo](https://i.gyazo.com/7488c1f3f03646f8b915011e90f36efa.jpg)](https://gyazo.com/7488c1f3f03646f8b915011e90f36efa)
- モバイルファーストを意識して、当アプリの主体である「ユーザー自身の思い出を記録すること」の核となる、写真画像サイズが目立ち、使いやすさを求めてシンプルな構造にしました。
- トップページでは、ログインユーザー自身の投稿を日付の新しい順に１カラムで表示しています。
- ログインしてない、ログインしても投稿数０件の場合は、全ユーザーの投稿を表示しています。

### トップページ/レスポンシブ画面(タブレット.ver)
[![Image from Gyazo](https://i.gyazo.com/5253a9566c47c61a8216a3f67c895f80.png)](https://gyazo.com/5253a9566c47c61a8216a3f67c895f80)
- スマホより詳しく、PCよりシンプルな構造になっています。
- スマホとの相違点 1：ヘッダーアイコンに機能名を表示、ログアウトボタンを追加表示しました。
- モバイルとの相違点 2：投稿画像を1カラムから2カラムに変更しました。

### トップページ/レスポンシブ画面(pc.ver)
[![Image from Gyazo](https://i.gyazo.com/c34f98b769009835dc26f82a09eab8ea.png)](https://gyazo.com/c34f98b769009835dc26f82a09eab8ea)
- スマホ、タブレットとの相違点 ：投稿画像を3カラムに変更しました。

### 記事の新規登録画面
[![Image from Gyazo](https://i.gyazo.com/977d9e7c22371e3e4b8c1289a433cb6d.png)](https://gyazo.com/977d9e7c22371e3e4b8c1289a433cb6d)
- 新規投稿では全ての項目入力が必要です。
- 入力内容の不備がある中で保存ボタンを押下された場合は、各項目に入力された状態で新規投稿画面に遷移し、ヘッダー直下に日本語エラー文が表示されます。

### 記事の新規登録画面(複数のimageを選択した際の表示)
[![Image from Gyazo](https://i.gyazo.com/8858fae2471f473358d79dc8e16442f2.png)](https://gyazo.com/8858fae2471f473358d79dc8e16442f2)
- 画像選択の最低枚数は1件以上です。
- ファイル選択ボタンで画像選択をすると、プレビュー画像が表示されます。
- 次の画像を選択する場合は、プレビュー画像直下に新しく
表示されたファイル選択ボタンを押下することで、画像の追加が可能です。
- 保存が完了すると詳細表示画面に遷移します。

### 詳細表示画面
[![Image from Gyazo](https://i.gyazo.com/d42e52d48c28e33ff493969e3eac8c70.png)](https://gyazo.com/d42e52d48c28e33ff493969e3eac8c70)
- 詳細表示画面は、投稿者または公開している場合のみ表示されます。
- 画像の表示は、Ajaxで画像切り替え機能を実装しました。投稿画像のいずれかを押下することで、ワイド画像表示が切り替わります。
- 画面中央右端に位置する手の形のアイコンは、いいね機能を実装したアイコンです。投稿記事が気に入った場合は押下することで投稿者の記事に賛同したという目的を持っています。
- 画面中央右端に位置するテントのアイコンは、お気に入り機能を実装したアイコンです。投稿記事が気に入った場合は押下することでマイページで表示されることで公開中であればいつでも気軽に確認できるようにする目的を持っています。
- いいね機能とお気に入り機能は、ログインしていなければアイコンと右配置のカウント数のみ表示され、押下できません。  
投稿者自身も押下ができます。押下後はカウント数が変動し、色が切り替わります。  
いいねまたはお気に入りを外す場合は、色がついたアイコンを再度押下することで外すことができ、カウント数が1減ります。  
（例 いいねをした場合：灰色から緑色に変わる。カウント数が1増える。）
- コメント機能は詳細表示でのみ表示されます。  
コメント投稿した本人画面のみ、自身のコメント直下に「削除する」が表示され、押下することで削除が可能です。  
31文字以上の入力の上、「コメントする」を押下すると、詳細画面に遷移し、画面上部にエラー文が表示されます。

### 編集画面
[![Image from Gyazo](https://i.gyazo.com/bfab8d8235fd8f41133bdb857a544261.png)](https://gyazo.com/bfab8d8235fd8f41133bdb857a544261)
- 編集画面へは、投稿者の詳細表示画面に表示される「編集」を押下することで遷移します。
- 編集は投稿者のみ可能です。
- 変更する場合は、内容を変更し、「保存する」を押下します。

### 削除画面
[![Image from Gyazo](https://i.gyazo.com/78b2b4d09969dd0c070578e440c08969.png)](https://gyazo.com/78b2b4d09969dd0c070578e440c08969)
- 投稿者の詳細表示画面に表示される「削除」を押下することで、投稿を削除します。
- 削除は投稿者のみ可能です。

### ユーザー詳細表示画面
[![Image from Gyazo](https://i.gyazo.com/6417131afaa799a15814c02b69a7733e.png)](https://gyazo.com/6417131afaa799a15814c02b69a7733e)
- スマホの表示画面状況です。
- 本人のみ表示：ユーザー情報の一部（氏名とemail）、「アカウント編集」と「ログアウト」ボタン
- ログインしていなくても閲覧可能です。
- いいね機能とお気に入り機能の押下が可能です。

### ユーザーページ/レスポンシブ画面(タブレット.ver)
[![Image from Gyazo](https://i.gyazo.com/a81f71e9e4fd26fc723e73642968c28a.png)](https://gyazo.com/a81f71e9e4fd26fc723e73642968c28a)
- スマホとの相違点：投稿画像の比率で高さを縮め、目的の投稿に辿りつくまでのスクロールする回数を減らしました。

### ユーザーページ/レスポンシブ画面(pc.ver)
[![Image from Gyazo](https://i.gyazo.com/7ea7a9e0e387dcc2cb6b8c4b56039876.jpg)](https://gyazo.com/7ea7a9e0e387dcc2cb6b8c4b56039876)
- スマホ、タブレットとの相違点：サイドバーを表示し、お気に入り記事を新しい順に表示しました。

### みんなの投稿ページ
[![Image from Gyazo](https://i.gyazo.com/5f97cec0dbff2ba297ad854e94e50585.png)](https://gyazo.com/5f97cec0dbff2ba297ad854e94e50585)
- 公開中の全ユーザーの投稿を新しい順に表示しています。
- ログインユーザーは、いいね機能またはお気に入り機能の押下が可能です。

# DEMO/動画
### ログイン(SNS認証)
[![Image from Gyazo](https://i.gyazo.com/89f68780d13a135c287d6dcbe0b0c5dc.gif)](https://gyazo.com/89f68780d13a135c287d6dcbe0b0c5dc)
- SNS認証を実行した様子です。
 
### 詳細表示(画面Ajaxの様子)
[![Image from Gyazo](https://i.gyazo.com/0979eeef261e6efddb3f9267fe93bd71.gif)](https://gyazo.com/0979eeef261e6efddb3f9267fe93bd71)
- 投稿画像が中央に配置されており、いずれかの画像を押下すると大きな画像がその画像に切り替わります。
- 投稿画像1枚の場合には、切り替えが不要なので大きな画像のみ表示されています。

# 工夫したポイント
- レスポンシブにより、モバイル、ダブレット、pcの３つに分け、ヘッダーや画像のカラム表示を変え見やすいサイズに気を付けました。
- 直感的に管理できるように画像を詳細ページで画像をAjaxで切り替えられるようにしました。
- 写真が主体なので一覧表示では、表示させる項目を減らし目立たせるようにしました。
- エラー文は、英語から日本語へ変更、ビューでは必要以上に文字の表示をしないアイコンを設置する等、ユーザーが使いやすいアプリを意識しました。

# 使用技術(開発環境)
## バックエンド
### Ruby, Ruby on Rails
## フロントエンド
### HTML, CSS, Javascript, Ajax
## データーベース
### MySQL, Sequel Pro
<!-- ## インフラ
### 未設定(AWS予定)
## Webサーバ(本番環境)
### 未設定
## アプリケーションサーバ(本番環境)
### 未設定 -->
## ソース管理
### GitHub, GitHubDesktop
## テスト
### RSpec
## エディタ
### VSCode

# 課題や今後実装したい機能
## 課題
- キャンプの内容を振り返る時に検索機能が無いため、目的の投稿にたどり着くのに時間がかかる。
- お気に入りの投稿表示がPC画面のみのため、スマホユーザーには使用できない機能になっている。ヘッダー等からハンバーガーメニュー等でお気に入りページを設ける対策が必要である。
- 
## 実装したい機能
- キャンプのカテゴリ分けを細かく選択またはタグ付け機能の実装すること。
- 検索機能の実装。

# テーブル設計
## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| nickname           | string | null: false               |
| profile            | text   | null: false               |

### Association

- has_many :sns_credentials
- has_many :posts
- has_many :comments
- has_many :likes
- has_many :favorites

## sns_credentials テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| provider | string     |                                |
| uid      | string     |                                |

### Association

- has_many :user

## posts テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| title        | string     | null: false                    |
| article_text | text       | null: false                    |
| status_id    | integer    | null: false                    |
| category_id  | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :posts
- has_many :comments
- has_many :likes
- has_many :favorites

## likes テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :tags

## favorites テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

