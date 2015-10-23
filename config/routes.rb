Rails.application.routes.draw do
  get "/signup" => "users#new"

  match "/login", to: "users#create", via: [:post, :get]

  get "dashboard" => "dashboard#home"

  root "pages#index"

  get "pages/about"

  get "pages/contact"

  get "pages/terms"

  get "pages/become_a_taskee"

  get "/logout" => "users#destroy"


end
