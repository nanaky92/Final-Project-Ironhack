Rails.application.routes.draw do
  devise_for :users
  # resources :groups
  # resources :users

  get "users/:id", to: "users#index"

  get "users/:id/groups/new", to: "groups#new"
  get "users/:id/groups/:group_id", to: "groups#index"

  get "users/:id/groups/:group_id/exit", to: "groups#exit"
  get "/users/:id/groups/:group_id/invite_users", to: "groups#invite_user"
  get "/users/:id/groups/:group_id/delete_user", to: "groups#delete_user"

  # root to: "devise/sessions#new"
  # get "/", to: "devise/sessions#new"

  devise_scope :user do 
    get "/" => "devise/registrations#new" 
  
    # get "/" => "users#index" 
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
