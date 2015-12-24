Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions

  resources :contacts do
    resources :phones
    member { patch "hide_contact" }
  end

  root 'contacts#index'
end
