Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#home"

  get '/signup'       , to: 'users#new'

  get '/login'        , to: "sessions#new"
  post '/login'       , to: "sessions#create"
  delete '/logout'    , to: "sessions#destroy" 
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :tags
  resources :questions 
  
  resources :quizzes, only: [:index, :new, :create, :show, :update, :destroy] do
    member do
      get "restart"
      get "continue"
      get "scoring"
      get "back"
    end
    resources :lists, only: [:new, :update, :create, :show] 

  end
  resources :rankings, only: [:index]


end
