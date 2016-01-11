GithubTrelloRails::Application.routes.draw do

  root to: "pages#dashboard"

  get "login", to: "pages#login"
  get "board/:id", to: "boards#show", as: :board

  resources :admins
  resources :harvest_trellos
  resources :users, only: :show
  resources :estimations, only: [:index, :create]

end
