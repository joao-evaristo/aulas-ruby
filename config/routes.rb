Rails.application.routes.draw do
  root 'sessions#new'
  get 'sessions/new'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/admin_only', to: 'admin#admin_only'

  resources :password_resets, only: [:edit, :update]

  # Defines the root path route ("/")
  # root "posts#index"
end
