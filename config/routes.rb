Rails.application.routes.draw do
  root "pages#index"

  get "signup" => "users#new"
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"

  get "auth/:provider/callback" => "sessions#create"
  get "auth/failure" => "sessions#destroy"

  get "dashboard" => "dashboard#home"

  get "pages/about"
  get "pages/contact"
  get "pages/terms"
  get "pages/become_a_taskee"

  resources :users, only: [:create]
end
