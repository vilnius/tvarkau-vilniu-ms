Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'welcome#index'

  namespace :auth do
    resource :viisp, controller: :viisp, only: [:new, :create]
  end

  namespace :api, constraints: { format: 'json' } do
    resource :me, controller: :users, only: :show
    resources :reports
    resources :report_types, only: [:index]
    resources :tokens, only: [:create]
    resources :photos, only: [:create]
  end
end
