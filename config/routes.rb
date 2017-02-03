Rails.application.routes.draw do
  resources :elections, only: :index
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
