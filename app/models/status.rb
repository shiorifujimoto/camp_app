class Status < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '公開' },
    { id: 3, name: '非公開' },
  ]

  include ActiveHash::Associations
  has_many :posts

end