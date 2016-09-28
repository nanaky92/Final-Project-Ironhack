Rails.application.routes.draw do

  namespace :api do
    get 'users/:key', to: "users#show"
    post '/api/groups/events/send_reminders', to: "events#show"    
    patch "/groups/events/votations", to: "votations#update", as: "group_event_votation"
    patch "/groups/events/votations/finish", to: "votations#finish", as: "group_event_votation_finish"
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  resources :groups do

    delete "/delete_user/:user_id", to: "groups#delete_user", as: "delete_user_from_group"
    delete "/exit_group", to: "groups#exit_group", as: "exit_group"

    resources :invitations, only: [:new, :destroy]
    post "/invitations/:id/", to: "invitations#create"
    delete "/invitations/:id/delete", to: "invitations#delete", as: "delete_invitation"

    resources :events, except: [:index] do
      get "/vote", to: "events#vote", as: "vote"
      resources :appointments, except: [:index, :update, :edit, :destroy]
        # resources :votations, only: [:index]
        # patch "/votations/:data", to: "votations#update", as: "update_votation"
    end
  end

  devise_scope :user do 
    root "groups#index"
  end

  # root "groups#index"

end
