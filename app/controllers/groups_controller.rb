class GroupsController < ApplicationController

before_action :set_quiz, only: [:answering, :show_result, :correct_answer, :wrong_choice, :answer_create]
before_action :get_answer, only: [:correct_answer, :wrong_choice]
before_action :valid_groups, only: [:index, :serch]
before_action :logged_in_user, only: [:index, :serch, :new, :create, :edit, :update, :destroy]  
  
def index
  @groups = Kaminari.paginate_array(@valid_groups).page(params[:page]).per(10)
end

def serch
  if params[:cont].present?
    @serched_groups = Group.like(params[:cont]).page(params[:page]).per(10)
  else
    @serched_groups = []
  end
  @groups = Kaminari.paginate_array(@valid_groups).page(params[:page]).per(10)
end

def show
  @user = current_user
  @group = Group.find(params[:id])
  set_available_groups
  @questions = Question.of_group(@group)
end

def new
  @user = current_user
  @group = Group.new
  @groups = Group.of_user(@user)
end

def create
  @user = current_user
  @group = Group.new(group_params)
  @groups = Group.where(user_id: current_user.id)
  if @group.save
    redirect_to new_quiz_path(@group)
    flash[:success] = 'グループを作成しました'
  else
    render :new
  end
end

def edit
  @group = Group.find(params[:id])
end

def update
  @group = Group.find(params[:id])
  if @group.update(group_params)
    redirect_to edit_group_path(@group)
    flash[:success] = '更新しました'
  else
    render :edit
  end
end

def destroy
  @group = Group.find(params[:id])
  @group.destroy
  redirect_to current_user, notice: 'グループを削除しました'
end

def answering
  reset_count if @@quiz_num == 0
  @score = @@score
  @miss = @@miss
end

def show_result
  return if params[:choice_id].nil?
  @@quiz_num += 1 unless @@quiz_num >= @questions.count
  if correct?
    redirect_to correct_answer_url
  else
    redirect_to wrong_choice_url
  end
end

def correct_answer
end

def wrong_choice
end

def answer_create
  if params[:score_label].present?
    @@quiz_num = 0
    redirect_to score_label_url
    return
  end
  redirect_to answering_url
end

def score_label
  @group = Group.find(params[:id])
  @score = @@score
  @miss = @@miss
  @correct_answer_rate = ((@@score / @group.questions.count.to_f) * 100).round
  current_user.update_quiz_data(@@score, @group.questions.count) unless current_user.nil?
end

private
  def group_params
    params.require(:group).permit(:content, :user_id)
  end

  def set_quiz
    @group = Group.find(params[:id])
    set_available_groups
    @questions = Question.where(group_id: @group.id)
    @quiz_num = @@quiz_num
    @score = @@score
  end
  
  def correct?
    selected_choice = Choice.find(params[:choice_id])
    if selected_choice.is_answer
      @@score += 1  
      return true
    else
      @@miss += 1
      return false  
    end
  end
  
  def get_answer
    @answer = @group.questions[@quiz_num - 1].choices.find_by(is_answer: true)
  end
  
  def valid_groups
    @valid_groups = Group.all.reject { |group| group.questions.count < 5 }
  end

  def set_available_groups
    groups = Group.recent
    valid_groups = groups.reject { |group| group.questions.count < 5 }
    available_without_login = valid_groups.first(10)
    logged_in_user unless @group.in?(available_without_login)
  end
end
