class Relationship < ApplicationRecord
  # フォローするユーザーに結びついている
  belongs_to :followed, class_name: "User"

  # フォローされるユーザーに結びついている
  belongs_to :follower, class_name: "User"

end