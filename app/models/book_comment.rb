class BookComment < ApplicationRecord
  belongs_to:user
  belongs_to:book
  #バリデーション空欄はNG!
  validates :comment, presence: true
end
