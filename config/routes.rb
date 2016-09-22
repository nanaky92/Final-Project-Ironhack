Rails.application.routes.draw do

  # resources :votations
  # resources :appointments

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


  # resources :groups, except: [:new, :edit] do
  #   resources :tasks, except: [:new, :edit, :update]
  #     patch 'tasks/:id/complete' => 'tasks#complete'
  #     put 'tasks/:id/complete' => 'tasks#complete'
  #   end
  # end



  get "/groups/", to: "users#show", as: "show_user"
  post "/groups/", to: "groups#create", as: "create_group"

  get "/groups/new", to: "groups#new", as: "new_group"

  get "/groups/:group_id", to: "groups#show", as: "show_group"

  # get "/groups/:group_id/exit", to: "groups#exit_group"
  delete "/groups/:group_id/delete_group", to: "groups#destroy", as: "destroy_group"

  get "/groups/:group_id/invite_users", to: "invitations#new", as: "new_invitation"
  post "/groups/:group_id/invite_users/:invited_id", to: "invitations#create", as: "invitations"
  
  delete "/groups/:group_id/delete_user/:user_id", to: "groups#delete_user", as: "delete_user_from_group"
  delete "/groups/:group_id/exit_group", to: "groups#exit_group", as: "exit_group"

  # get "/invitations/", to: "invitations#index"

  delete "/invitations/:id", to: "invitations#destroy"
  # , as: "invitations"


  get "/groups/:group_id/events/new", to: "events#new", as: "new_event"
  post "/groups/:group_id/events", to: "events#create", as: "create_event"
  get "/groups/:group_id/events/:event_id/", to: "events#show", as: "show_event"
  # patch "/groups/:group_id/events/:event_id/", to: "events#edit", as: "edit_event"

  # get "/groups/:group_id/events/:event_id", to: "events#show"
  
  # delete "/groups/:group_id/events/:event_id", to: "events#delete"


  get "/groups/:group_id/events/:event_id/appointments", to: "appointments#index", as: "appointments"
  get "/groups/:group_id/events/:event_id/appointments/new", to: "appointments#new", as: "new_appointment"
  post "/groups/:group_id/events/:event_id/appointments", to: "appointments#create", as: "create_appointment"
  

  patch "/groups/:group_id/events/:event_id/appointments/:appointment_id/votations", to: "votations#edit", as: "edit_votation"

  # post "/groups/:group_id/events/:event_id/appointments/:appointments_id/votations", to: "votations#", as: "create_appointment"


  devise_scope :user do 
    get "/" => "users#show" 
  end

  get "/", to: "users#show"


end
