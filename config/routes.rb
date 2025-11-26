Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :quizzes, only: [:new, :create, :show] do 
    resources :questions, only: [:create]
  end
  
end
