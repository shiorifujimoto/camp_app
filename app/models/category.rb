class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: 'キャンプ場' },
    { id: 3, name: 'キャンプギア' },
  ]

  include ActiveHash::Associations
  has_many :posts

end