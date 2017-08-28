Rails.application.routes.draw do
  resources :users
  root to: "users#index"

  namespace :api do
    match '/users' => 'users#all', via: [ :get, :options]
    match '/users/:id' => 'users#single', via: [ :get, :options]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
