Rails.application.routes.draw do
  # resources :groups
  # resources :users

  # get "/groups/", to: "groups#index"

  devise_for :users

  get "/groups/", to: "users#show"
  post "/groups/", to: "groups#create", as: "create_group"

  get "/groups/new", to: "groups#new"

  get "/groups/:group_id", to: "groups#show"

  # get "/groups/:group_id/exit", to: "groups#exit_group"
  get "/groups/:group_id/delete_group", to: "groups#destroy"

  get "/groups/:group_id/invite_users", to: "groups#invite_user"
  delete "/groups/:group_id/delete_user", to: "groups#delete_user"


  devise_scope :user do 
    get "/" => "users#show" 
  end

  get "/", to: "users#show"


end
