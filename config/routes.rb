Rails.application.routes.draw do
  devise_for :users
  # resources :groups
  # resources :users

  get "/groups/", to: "groups#index"
  post "/groups/", to: "groups#create", as: "create_group"

  get "/groups/new", to: "groups#new"

  get "/groups/:group_id", to: "groups#show"

  get "/groups/:group_id/exit", to: "groups#exit"
  get "/groups/:group_id/invite_users", to: "groups#invite_user"
  get "/groups/:group_id/delete_user", to: "groups#delete_user"



  devise_scope :user do 
    get "/" => "users#show" 
  end

  get "/", to: "users#show"


end
