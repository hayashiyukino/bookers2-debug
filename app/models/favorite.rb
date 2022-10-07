class Favorite < ApplicationRecord
  belongs_to :user  # この1行を追加
  belongs_to :book  # この1行を追加
  
  # 1回以上は押せない様にバリデーションを設定します。
  # validates :user_id, uniqueness: { scope: :book_id }
end
