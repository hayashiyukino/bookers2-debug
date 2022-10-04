class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # bookモデルに対してのアソシエーション
  has_many :books, dependent: :destroy
  # いいねモデルに対して
  has_many :favorites, dependent: :destroy
  # コメントに対して
  has_many :book_comments, dependent: :destroy
  
  # フォローをした
  #  relationships = 分かりやすいように名前をつけただけ
  #  class_name: "Relationship"でRelationshipテーブルを参照
  #  foreign_key(外侮キー)で参照するカラムを指定
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされた
  #  reverse_of_relationships = 分かりやすいように名前をつけただけ
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_one_attached :profile_image
  # 一覧画面で使う
  #  フォロー・フォロワーの一覧画面で、user.followersという記述でフォロワーを表示したいので、
  #  throughでスルーするテーブル、sourceで参照するカラムを指定。
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  # favoritesテーブルに「book_id」が存在するかどうかの検索をかけます。
  # exists?メソッドは値が存在すればtrue、存在しない場合はfalseを返すメソッド
  def favorited_by?(book_id)
    favorites.where(book_id: book_id).exists?  
  end
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # フォローしたときの処理の定義
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理の定義
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end
