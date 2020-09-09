class StaticPagesController < ApplicationController
  before_action :reset_count
  
  def home
    @groups = Group.all.reject { |group| group.questions.count < 5 }
    recent_groups = Group.order(created_at: :desc)
    @recent_groups = recent_groups.reject { |group| group.questions.count < 5 }
  end
  
end