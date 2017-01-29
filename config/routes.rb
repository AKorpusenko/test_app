Rails.application.routes.draw do

  devise_for :users

  get 'welcome/index', as: 'user_root'

  resources :books
  resources :authors

 
  root 'welcome#index'

  post 'user_token' => 'user_token#create'
  namespace :api, defaults: {format: 'json'}  do
    resources :users
  	namespace :v1 do
  		resources :books, only: [:index, :show]
  		resources :authors, only: [:index, :show]
  		# resources :users, only: [:index, :show]
  	end
  end
end
