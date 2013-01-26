Nftixs::Application.routes.draw do
  root to: 'tickets#index'
  resources :tickets
  resources :ticket_groups
  resources :users
end
