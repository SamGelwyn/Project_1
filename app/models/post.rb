class Post < ApplicationRecord
  belongs_to :user, :optional => true,
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { minimum: 5 }
  validates :user_id, presence: true
end
