class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status
  # belongs_to :category

  with_options presence: true do
    validates :title        , length: {maximum: 20}
    validates :article_text , length: {maximum: 20}
    with_options numericality: { other_than: 1 } do
      # validates :category_id
      validates :status_id
    end
  end
end
