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
  get "quiz" => "dashboard#quiz"
  post "quiz" => "dashboard#quiz"
  get "dashboard" => "dashboard#home"
  match "dashboard/profile" => "dashboard#user_profile", as: :profile, via: [:post, :get]

  get "dashboard/assign" => "taskmanagements#new", as: :assign_task
  post "dashboard/assign" => "taskmanagements#create", as: :create_task
  get "dashboard/notifications" => "notifications#index", as: :notifications
  post "dashboard/notifications/:id" => "notifications#show"
  put "dashboard/notifications/:id" => "notifications#update"

  get "user/profile" => "dashboard#profile_view", as: :user_profile

  get "account_activations/:id/edit" =>
  "account_activations#confirm_email", as: :confirm

  post "account_activations" =>
  "account_activations#resend_activation_mail", as: :resend_mail

  get "pages/about"
  match "contact" => "pages#contact", as: :contact, via: [:post, :get]
  get "pages/terms"

  match "search/taskees" => "pages#search", as: "search", via: [:post, :get]

  get "pages/become_a_taskee"

  post "user/settings" => "users#update_notification_settings"

  resources :users, only: [:create]
end
