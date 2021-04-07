class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status

  with_options presence: true do
    validates :title        , length: {maximum: 20}
    validates :article_text , length: {maximum: 300}
    validates :status_id    , numericality: {other_than: 1, message: "は--以外から選んでください"}
    validates :category_id    , numericality: {other_than: 1, message: "は--以外から選んでください"}
    validates :image
  end

end
