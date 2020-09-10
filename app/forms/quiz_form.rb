class QuizForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  
  attribute :question_content, :string
  attribute :question_user_id, :string
  attribute :group_id, :string
  attribute :answer, :string
  attribute :wrong_choice_1, :string
  attribute :wrong_choice_2, :string
  attribute :wrong_choice_3, :string
  
  validates :question_content, presence: true, length: { maximum: 140 }
  validates :question_user_id, presence: true
  validates :group_id, presence: true
  validates :answer, presence: true, length: { maximum: 30 }
  validates :wrong_choice_1, presence: true, length: { maximum: 30 }
  validates :wrong_choice_2, presence: true, length: { maximum: 30 }
  validates :wrong_choice_3, presence: true, length: { maximum: 30 }
  
  def save
    return false unless valid?
    question = Question.new(content: question_content, user_id: question_user_id, group_id: group_id)
    question.save
    
    choice = question.choices.build(content: answer, is_answer: true)
    choice.save
    
    question.choices.create(content: wrong_choice_1, is_answer: false)
    question.choices.create(content: wrong_choice_2, is_answer: false)
    question.choices.create(content: wrong_choice_3, is_answer: false)
  end
end
