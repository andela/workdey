Rails.application.routes.draw do
  root "pages#index"

  get "signup" => "users#new"
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"

  get "auth/:provider/callback" => "sessions#create"
  get "auth/failure" => "sessions#destroy"

  get "role" => "dashboard#choose_role"
  post "role" => "dashboard#set_role"
  get "dashboard" => "dashboard#home"

  get "account_activations/:id/edit" =>
  "account_activations#confirm_email", as: :confirm

  post "account_activations" =>
  "account_activations#resend_activation_mail", as: :resend_mail

  get "pages/about"
  match "pages/contact" => "pages#contact", as: :contact, via: [:post, :get]
  get "pages/terms"
  get "pages/become_a_taskee"

  resources :users, only: [:create]
end