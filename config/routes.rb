GithubTrelloRails::Application.routes.draw do

  root :to => "pages#dashboard"
  get "login" => "pages#login"
  get "board/:id" => "boards#show", :as => :board
  resources :admins
  resources :harvest_trellos
  resources :users, :only => :show
  resources :estimations, :only => [:index, :create]

end
