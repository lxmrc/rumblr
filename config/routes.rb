Rails.application.routes.draw do
  resources :resources
  devise_for :users
  root to: 'pages#home'
end
