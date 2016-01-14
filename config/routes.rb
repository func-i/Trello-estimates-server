GithubTrelloRails::Application.routes.draw do

  root to: "pages#dashboard"

  get "trello_callback", to: "pages#trello_callback"

  get "board/:id", to: "boards#show", as: :board

  resources :admins
  resources :harvest_trellos
  resources :users, only: :show
  resources :estimations, only: [:index, :create]

end
