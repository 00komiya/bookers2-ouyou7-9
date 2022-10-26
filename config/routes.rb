Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :index, :edit, :update]
  resources :books
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end