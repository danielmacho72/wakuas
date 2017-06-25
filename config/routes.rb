Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'home/index'

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  root to: "home#index"

  post 'authenticate', to: 'authentication#authenticate'
  get 'validate', to: 'authentication#validate'
end
