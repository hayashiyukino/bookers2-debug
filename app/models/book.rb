class Book < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: {maximum:200}
  
  
  # 既にいいね済みであれば、複数回いいねは出来ません
  
  def favorited_by(user)
    # whereモデル名.where(任意のカラム名: 格納されている値)となる
    favorites.where(user_id: user.id).exists?
  end
  
end
