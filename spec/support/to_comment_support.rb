module ToCommentSupport
  def to_comment(post,comment)
    # 詳細ページへ遷移する
    visit post_path(post)
    # コメントを入力する
    fill_in 'comment[comment]', with: comment
    # コメントを送信するとコメントテーブルのカウントが１上がる
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトしていることを確認する
    expect(current_path).to eq(post_path(post))
  end
end
