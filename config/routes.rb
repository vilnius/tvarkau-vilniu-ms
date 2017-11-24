Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :api, constraints: { format: 'json' } do
    resources :reports
    resources :report_types, only: [:index]
    resources :tokens, only: [:create]
    resources :photos, only: [:create]
  end
end
