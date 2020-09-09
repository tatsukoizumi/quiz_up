class Question < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :group, optional: true
  has_many :choices, dependent: :destroy
  validates :content, presence: true
  default_scope { order(created_at: :desc) }
  scope :of_group, -> group { where(group_id: group.id)} 
end