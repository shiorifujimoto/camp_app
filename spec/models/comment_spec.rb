require 'rails_helper'

RSpec.describe Comment, type: :model do

  before do
    @user = FactoryBot.build(:user)
    @post = FactoryBot.build(:post)
    @comment = FactoryBot.build(:comment)
  end

  describe '#Create' do
    context '正常系' do
      it 'commentが存在すれば、投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context '異常系' do
      it 'commentが空の場合、投稿できない' do
        @comment.comment = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end
      it 'commentが31文字以上の場合、投稿できない' do
        @comment.comment = "コメントですコメントですコメントですコメントですコメントです！"
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントは30文字以内で入力してください")
      end
    end
  end
end
