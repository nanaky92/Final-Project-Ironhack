Rails.application.routes.draw do

  namespace :api do
    get 'users/:key', to: "users#show"
    # patch "/groups/events/votations", to: "votations#update"
    post "/groups/events/votations", to: "votations#update", as: "group_event_votation"
    post "/groups/events/votations/dont_care", to: "votations#dont_care", as: "group_event_votation_dont_care"
    post "/groups/events/votations/not_going", to: "votations#not_going", as: "group_event_votation_not_going"
    # post "/groups/events/votations", to: "votations#create", as: "group_event_votation"
  end

  devise_for :users

  get "/groups/", to: "users#show", as: "show_user"

  resources :groups, except: [:index, :edit, :update] do

    delete "/delete_user/:user_id", to: "groups#delete_user", as: "delete_user_from_group"
    delete "/exit_group", to: "groups#exit_group", as: "exit_group"

    resources :invitations, only: [:new, :destroy, :destroy]
    post "/invitations/:id/", to: "invitations#create"

    resources :events, except: [:index, :edit, :update, :destroy] do
      resources :appointments, except: [:edit, :show, :update, :destroy]
        # resources :votations, only: [:edit]
        # patch "/votations/:data", to: "votations#update", as: "update_votation"
    end
  end

  devise_scope :user do 
    root "users#show"
  end

  root "users#show"


end
