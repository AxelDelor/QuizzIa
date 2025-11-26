Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "profile", to: "pages#profile"
  resources :quizzes, only: [:new, :create, :show] do
    resources :questions, only: [:create]
  end
  resources :questions, only: [:edit, :update]

end
