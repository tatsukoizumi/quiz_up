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

  scope :rank, -> { order(total_score: :desc) }
  
  def update_quiz_data(score, count)
    score = self.total_score + score
    done = self.done_quiz_count + count
    self.update(total_score: score, done_quiz_count: done)
  end

  def accurancy
    if self.done_quiz_count == 0
      return 0
    else
      return ((self.total_score / self.done_quiz_count.to_f) * 100).round
    end
  end

  def point
    return self.total_score * 10
  end
  
end

