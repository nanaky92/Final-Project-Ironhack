Rails.application.routes.draw do

  namespace :api do
    get 'users/:key', to: "users#show"
    patch "/groups/events/votations", to: "votations#update", as: "group_event_votation"
    patch "/groups/events/votations/finish", to: "votations#finish", as: "group_event_votation_finish"
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  get "/groups/", to: "users#show", as: "show_user"

  resources :groups, except: [:index, :edit, :update] do

    delete "/delete_user/:user_id", to: "groups#delete_user", as: "delete_user_from_group"
    delete "/exit_group", to: "groups#exit_group", as: "exit_group"

    resources :invitations, only: [:new, :destroy, :destroy]
    post "/invitations/:id/", to: "invitations#create"

    resources :events, except: [:index, :edit, :update, :destroy] do
      resources :appointments, except: [:edit, :update, :destroy]
        resources :votations, only: [:index]
        # patch "/votations/:data", to: "votations#update", as: "update_votation"
    end
  end

  devise_scope :user do 
    root "users#show"
  end

  root "users#show"

end
