class User < ApplicationRecord
  
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent:    :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password
  validates :email, :presence => true, :uniqueness => true

  def feed
    # Post.where("user_id = ?", id)
    following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  
end
