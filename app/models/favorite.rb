class Favorite < ApplicationRecord
  belongs_to :user  # この1行を追加
  belongs_to :book  # この1行を追加
end
