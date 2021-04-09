class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :sns_credentials
  has_many :posts
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i.freeze
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶー一-龠]+\z/u.freeze
 
  with_options presence: true do
    validates :nickname    , length: { maximum: 10, too_long: "最大%{count}文字まで使えます"}
    validates :password    , format: { with: VALID_PASSWORD_REGEX , message: "を半角英数字を両方
      含めた6文字以上を入力してください"}
    validates :email       , uniqueness: true
    with_options format: { with: VALID_NAME_REGEX,  message: "はひらがな、カナ、漢字のみが使えます" } do
      validates :last_name
      validates :first_name
    end
  end
  validates :profile       , length: { maximum: 50, too_long: "は最大%{count}文字まで使えます"}, allow_nil: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create

    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email:  auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
