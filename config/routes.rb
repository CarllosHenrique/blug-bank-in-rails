Rails.application.routes.draw do
  root 'home#index'

  namespace :users do
    get 'registrations/new', to: 'registrations#new', as: 'new_registrations'
    post 'registrations', to: 'registrations#create'

    get 'sessions/sign_in', to: 'sessions#sign_in', as: 'new_sessions'
    post 'sessions', to: 'sessions#create'
    delete 'sessions', to: 'sessions#destroy', as: 'destroy_session'
  end

  resources :messages
end
