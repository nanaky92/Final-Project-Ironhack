Rails.application.routes.draw do

  namespace :api do
    get 'users/:key', to: "users#show"
  end

  devise_for :users

  get "/groups/", to: "users#show", as: "show_user"

  resources :groups, except: [:index, :edit, :update] do

    delete "/delete_user/:user_id", to: "groups#delete_user", as: "delete_user_from_group"
    delete "/exit_group", to: "groups#exit_group", as: "exit_group"

    resources :invitations, only: [:new, :create, :destroy]

    resources :events, except: [:index, :edit, :update, :destroy] do
      resources :appointments, except: [:edit, :show, :update, :destroy]
    end
  end

  devise_scope :user do 
    get "/" => "users#show"
  end

  get "/", to: "users#show"


end
      # patch "/events/:event_id/appointments/:appointment_id/votations", to: "votations#edit", as: "edit_votation"
