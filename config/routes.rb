Rails.application.routes.draw do

  namespace :api do
    get 'users/:key', to: "users#show"
    # get 'users/show_by_name/:name', to: "api/users#show_by_name"
    # get 'users/show_by_email/:email', to: "api/users#show_by_email"
    # get 'users/show_by_id/:id', to: "api/users#show_by_id"
  end

  # resources :groups
  # resources :users

  # get "/groups/", to: "groups#index"

  devise_for :users

  # namespace :groups

  get "/groups/", to: "users#show", as: "show_user"
  post "/groups/", to: "groups#create", as: "create_group"

  get "/groups/new", to: "groups#new", as: "new_group"

  get "/groups/:group_id", to: "groups#show", as: "show_group"

  # get "/groups/:group_id/exit", to: "groups#exit_group"
  delete "/groups/:group_id/delete_group", to: "groups#destroy", as: "destroy_group"

  get "/groups/:group_id/invite_users", to: "invitations#new", as: "new_invitation"
  post "/groups/:group_id/invite_users/:invited_id", to: "invitations#create", as: "invitations"
  
  delete "/groups/:group_id/delete_user", to: "groups#delete_user", as: "delete_user_from_group"
  delete "/groups/:group_id/exit_group", to: "groups#exit_group", as: "exit_group"

  # get "/invitations/", to: "invitations#index"

  delete "/invitations/:id", to: "invitations#destroy"
  # , as: "invitations"

  devise_scope :user do 
    get "/" => "users#show" 
  end

  get "/", to: "users#show"


end
