Rails.application.routes.draw do
  root to: 'static_pages#home'
  resources :users, except: [:index]
  resources :groups do
    get :serch, on: :collection
  end
  resources :questions, except:[:new, :create, :edit, :update, :destroy] 
  post '/groups/:id/confirm-quiz', to: 'questions#confirm_quiz', as: 'confirm_quiz'
  get '/groups/:id/confirm-quiz', to: 'questions#new'
  get '/groups/:id/new-quiz', to: 'questions#new', as: 'new_quiz'
  post '/groups/:id/new-quiz', to: 'questions#create', as: 'quiz'
  get 'groups/:id/questions/:question_id/edit', to: 'questions#edit', as: 'edit_quiz'
  post 'groups/:id/questions/:question_id', to: 'questions#update', as: 'quiz_update'
  delete 'groups/:id/questions/:question_id', to: 'questions#destroy', as: 'delete_question'
  
  get '/groups/:id/answering', to: 'groups#answering', as: 'answering'
  post '/groups/:id/result', to: 'groups#show_result', as: 'show_result'
  post '/groups/:id/create-answer', to: 'groups#answer_create', as: 'answer_create'
  get '/groups/:id/result/correct', to: 'groups#correct_answer', as: 'correct_answer'
  get '/groups/:id/result/miss', to: 'groups#wrong_choice', as: 'wrong_choice'
  get '/groups/:id/result/score', to: 'groups#score_label', as: 'score_label'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/signup', to: 'users#new'
  get 'users/:id/delete-account', to: 'users#delete_account', as: 'delete_account'
end
