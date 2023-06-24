Rails.application.routes.draw do
  namespace :stockmarkets do
    resources :stocks, only: [:index, :create, :new]
    put 'stocks/buy/:id', to: 'stocks#buy_stock', as: 'stock_buy'
  end

  root 'home#index'

  namespace :users do
    get 'sessions/sign_in', to: 'sessions#sign_in', as: 'new_sessions'
    post 'sessions', to: 'sessions#create'
    delete 'sessions', to: 'sessions#destroy', as: 'destroy_session'

    get 'sessions/confirmation', to: 'sessions#confirmation', as: 'sessions_confirmation'
    post 'sessions/confirmation', to: 'sessions#password_confirmation'

    get 'account/:id', to: 'sessions#account', as: 'account'
    put 'account/:id', to: 'sessions#new_password', as: 'new_password'
    patch 'account/:id', to: 'sessions#edit_account', as: 'account_edit'

    post '/clear_session', to: 'sessions#clear_session'

    put 'salary', to: 'moneys#salary', as: 'salary_update'
    post 'transfer_money', to: 'moneys#transfer_money', as: 'transfer_money'
  end

  get 'notifications', to: 'notifications#index', as: 'notifications'
  delete 'notifications', to: 'notifications#destroy'

  get 'all/users', to: 'home#all_users', as: 'users'
end
