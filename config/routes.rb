require 'api_constraints'
Rails.application.routes.draw do
  root to: 'reservations#index'
  resources :reservations, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :api, path: '/api', as: :api, defaults: { format: 'json' } do
    scope module: :v1,as: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      root to: 'base#test', as: :root

      # Just to test authentication
      get 'test', to: 'base#test'
      resources :reservations, only: :create
    end
  end
end
