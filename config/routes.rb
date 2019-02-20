Rails.application.routes.draw do
  get 'accounts/new'
  get 'accounts/create'
  devise_for :users, controllers: { registrations: 'registrations' }
  resource :accounts
  get 'activity/mine'
  get 'activity/feed'

  
  root to: 'activity#mine'
end
