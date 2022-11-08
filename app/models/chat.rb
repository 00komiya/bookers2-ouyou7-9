class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room

 # 140 字まで送信可能にする
  validates :message, presence: true, length: { maximum: 140 }

end
