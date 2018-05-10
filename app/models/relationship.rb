class Relationship < ApplicationRecord
  validates :user_id, presence: true
  validates :followed_id, presence: true
  validates_uniqueness_of :user_id, scope: [:followed_id]
end
