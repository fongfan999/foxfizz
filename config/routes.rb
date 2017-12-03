Rails.application.routes.draw do
  root 'welcome#index'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  delete 'sessions/destroy', as: :logout
end
