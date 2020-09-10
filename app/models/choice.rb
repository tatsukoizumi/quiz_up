class Choice < ApplicationRecord
  belongs_to :question, optional: true
  validates :content, presence: true
end
