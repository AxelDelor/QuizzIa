Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "profile", to: "pages#profile"
  resources :quizzes, only: [:new, :create, :show] do
    member do
      get :next
    end
    resources :questions, only: [:create]
  end

  resources :questions, only: [:edit, :update]

  get "quizzes/:id/results", to: "quizzes#results", as: :quiz_results
end
 