# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get  'help',  to: 'static_pages#help'
  get  'about', to: 'static_pages#about'
  get  'shops', to: 'static_pages#shops'
  get  'signup', to: 'users#new'
  get  'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
  resources :reviews, only: %i[new edit create update destroy show]
  resources :shop_foods, only: %i[index show]
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :shops, only: %i[index show]
      resources :foods, only: %i[index]
    end
  end
end
