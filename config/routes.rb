Rails.application.routes.draw do
  use_doorkeeper

  root 'welcome#index'

  scope '/app' do
    devise_for :users, controllers: { omniauth_callbacks: 'auth/omniauth_callbacks' }
  end

  namespace :auth do
    resource :viisp, controller: :viisp, only: [:new, :create]
  end

  defaults format: :json do
    resource :me, controller: :users, only: :show
    resources :cities, only: [:index]
    resources :reports
    resources :report_statuses, only: [:index]
    resources :report_types, only: [:index]
    resources :tokens, only: [:create]
    resources :report_photos, only: [:create]
    resource :guest_migration, only: [:create]
  end
end
