Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :offers

  get '/search/', to: 'offers#search', as: 'search'
  patch "offers/:id/available", to: "offers#available", as: :available
end
