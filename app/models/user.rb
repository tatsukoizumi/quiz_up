class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :with_password

  has_many :groups, foreign_key: :user_id, dependent: :destroy
  has_many :questions, foreign_key: :user_id, dependent: :destroy
  
  def update_quiz_data(score, count)
    total_score = self.total_score + score
    done = self.done_quiz_count + count
    self.update(total_score: total_score, done_quiz_count: done)
  end
  
end
