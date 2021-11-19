Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :invitations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
