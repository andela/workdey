Rails.application.routes.draw do
  root "pages#index"

<<<<<<< HEAD
  match "/login", to: "users#create", via: [:post, :get]

  get "dashboard" => "dashboard#home"
=======
  get "/signup" => "users#new"

  get "/temp" => "users#temp"
>>>>>>> 5eefcb86e25c30923b74e0acb3f20ed662b15fef

  get "/dashboard" => "dashboard#home"

  get "pages/about"

  get "pages/contact"

  get "pages/terms"

  get "pages/become_a_taskee"

<<<<<<< HEAD
  get "/logout" => "users#destroy"

=======
  resources :users
>>>>>>> 5eefcb86e25c30923b74e0acb3f20ed662b15fef

end
