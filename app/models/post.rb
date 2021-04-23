class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :favorited_users, through: :favorites, source: :user
  has_many :favorites, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status

  with_options presence: true do
    validates :title        , length: {maximum: 20}
    validates :article_text , length: {maximum: 300}
    validates :status_id    , numericality: {other_than: 1, message: "を選んでください"}
    validates :category_id    , numericality: {other_than: 1, message: "を選んでください"}
    validates :images
  end

end