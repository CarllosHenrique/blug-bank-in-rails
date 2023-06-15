Rails.application.routes.draw do
  root 'home#index'

  namespace :users do
    get 'sessions/sign_in', to: 'sessions#sign_in', as: 'new_sessions'
    post 'sessions', to: 'sessions#create'
    delete 'sessions', to: 'sessions#destroy', as: 'destroy_session'

    get 'sessions/confirmation', to: 'sessions#confirmation', as: 'sessions_confirmation'
    post 'sessions/confirmation', to: 'sessions#password_confirmation'

    get 'account/:id', to: 'sessions#account', as: 'account'
    put 'account/:id', to: 'sessions#new_password', as: 'new_password'

    put 'salary', to: 'moneys#salary', as: 'salary_update'
  end
end
