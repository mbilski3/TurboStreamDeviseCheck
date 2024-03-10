# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'tweets#index'

  resources :tweets, only: %i[index new create destroy] do
    member do
      get :actions
    end
  end
end
