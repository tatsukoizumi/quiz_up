Rails.application.routes.draw do
  root to: 'static_pages#home'
  
  get 'groups/new'
  get 'groups/show'
  get 'groups/serch'
  get 'groups/score_label'
  get 'groups/wrong_choice'
  get 'groups/edit'
  get 'groups/index'
  get 'groups/correct_answer'
  get 'groups/answering'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
