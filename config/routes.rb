# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get  'help',  to: 'static_pages#help'
  get  'about', to: 'static_pages#about'
  get  'restaurants', to: 'static_pages#restaurants'
  get  'signup', to: 'users#new'
  get  'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
  resources :reviews, only: %i[new edit create update destroy show]
  resources :foods, only: [:show]
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :restaurants, only: %i[index show]
    end
  end
end
