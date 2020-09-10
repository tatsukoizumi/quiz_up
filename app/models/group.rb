class Group < ApplicationRecord
  belongs_to :user, optional: true
  has_many :questions, foreign_key: :group_id, dependent: :destroy
  validates :content, presence: true
  default_scope { order(updated_at: :desc) }
  scope :like, -> cont { where('content LIKE ?', "%#{cont}%")}
  scope :of_user, -> user { where(user_id: user.id) }
end
