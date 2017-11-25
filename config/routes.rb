Rails.application.routes.draw do
  use_doorkeeper

  root 'welcome#index'

  namespace :api, constraints: { format: 'json' } do
    resources :reports
    resources :report_types, only: [:index]
    resources :tokens, only: [:create]
    resources :photos, only: [:create]
  end
end
