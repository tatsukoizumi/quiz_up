class QuestionsController < ApplicationController

before_action :logged_in_user, only: [:new, :confirm_quiz, :create, :create, :edit, :update, :destroy]

def new
  @user = current_user
  @group = Group.find_by(id: params[:id])
  @quiz = QuizForm.new
  @questions = Question.of_group(@group)
end

def confirm_quiz
  @group = Group.find(params[:id])
  @quiz = QuizForm.new(quiz_params)
  @questions = Question.of_group(@group)
  render :new unless @quiz.valid?
end

def create
  @user = current_user
  @group = Group.find(params[:id])
  @quiz = QuizForm.new(quiz_params)
  
  if params[:back].present?
    render :new
    return
  end
  
  if params[:done].present?
    @quiz.save
    redirect_to current_user
    flash[:success] = '　保存しました'
    return
  end
  
  if @quiz.save
    redirect_to new_quiz_path(@group)
    flash[:success] = '保存しました'
  else
    render :new
  end
end

def edit
  get_quiz
end

def update
  get_quiz
  
  if params[:back].present?
    redirect_to edit_group_path(@group)
    return
  end
  
  if quiz_update
    redirect_to edit_group_path(@group)
    flash[:success] = '更新しました'
  else
    render :edit
  end
end

def destroy
  @group = Group.find(params[:id])
  @question = Question.find(params[:question_id])
  @question.destroy
  redirect_to edit_group_path(@group), notice: '削除しました'
end

private
  def quiz_params
    params.require(:quiz_form).permit(
      :question_content,
      :question_user_id,
      :group_id,
      :answer,
      :wrong_choice_1,
      :wrong_choice_2,
      :wrong_choice_3)
  end
  
  def get_quiz
    @group = Group.find(params[:id])
    @question = Question.find(params[:question_id])
    @answer = @question.choices.find_by(is_answer: true)
    @wrong_choices = @question.choices.where(is_answer: false)
  end
  
  def quiz_update
    @question.update(content: params[:question_content]) &&
    @answer.update(content: params[:answer]) &&
    @wrong_choices[0].update(content: params[:wrong_choice_1]) &&
    @wrong_choices[1].update(content: params[:wrong_choice_2]) &&
    @wrong_choices[2].update(content: params[:wrong_choice_3])
  end
end
