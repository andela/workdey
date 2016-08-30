Rails.application.routes.draw do
  get "taskees/index"  => "taskees#index", as: :taskees

  root "pages#index"

  put "broadcast" => "tasks#broadcast_task"
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
  post "/dashboard/choose_skillset" => "dashboard#create_skillset"

  get "dashboard/assign" => "task_managements#new", as: :assign_task
  post "dashboard/assign" => "task_managements#create", as: :create_task
  get "dashboard/notifications" => "notifications#index", as: :notifications
  get "dashboard/notifications/:id" => "notifications#show"
  put "dashboard/notifications/:id" => "notifications#update"

  get "user/profile" => "dashboard#profile_view", as: :user_profile

  get "skillsets/index" => "skillsets#index", as: :my_skillset

  get "account_activations/:id/edit" =>
  "account_activations#confirm_email", as: :confirm

  post "/dashboard/update_location" =>
  "dashboard#update_location", as: :location_update

  get "/dashboard/map_search" =>
    "dashboard#search_with_map", as: :map_search

  post "account_activations" =>
  "account_activations#resend_activation_mail", as: :resend_mail

  get "pages/about"
  match "contact" => "pages#contact", as: :contact, via: [:post, :get]
  get "pages/terms"

  match "search/taskees" => "pages#search", as: "search", via: [:post, :get]

  get "pages/become_a_taskee"

  get "dashboard/tasks" => "task_managements#index", as: :my_tasks
  get "dashboard/tasks/review" => "task_managements#show", as: :review_task
  post "tasks_managements/update" => "task_managements#update", as: :completed
  post "user/settings" => "users#update_notification_settings"
  put "task_management/share/:id", to: "task_managements#share", as: :share_contact
  get "user_plans" => "user_plans#index"
  post "/charge" => "user_plans#create"

  get "/my_skillsets" => "taskee_skillsets#index", as: :my_skillsets
  put "/taskee_skillsets" => "taskee_skillsets#update"

  get "/tasks/:id/close_bid" => "tasks#close_bid", as: "close_bid"

  resources :biddings
  resources :tasks
  post "/tasks/search", to: "tasks#search", as: :tasks_search
  resources :users, only: :create
  resources :charges, only: [:new, :create]

  namespace :dashboard do
    resources :references, only: [:index, :new, :create]
    resources :endorsements, only: [:new, :create]
  end
end
