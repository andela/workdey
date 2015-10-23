Rails.application.routes.draw do
  root "pages#index"

  get "/signup" => "users#new"

  get "/temp" => "users#temp"

  get "/dashboard" => "dashboard#home"

  get "pages/about"

  get "pages/contact"

  get "pages/terms"

  get "pages/become_a_taskee"

  resources :users

end
