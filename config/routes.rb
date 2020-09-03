Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'

  resource :user_sessions, only: :create

  resources :carts, only: [:index, :create]
end
