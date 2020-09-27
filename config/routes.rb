# frozen_string_literal: true

Rails.application.routes.draw do

  get 'shops/index'

  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }


  #get 'users/show'
  resources :users,               only: [:show, :index] do
    member do
      get :following, :followers, :liking
    end
  end
  resources :microposts,          only: [:new, :create, :destroy, :show] do
    resources :comments,          only: [:create, :destroy]
  end
  resources :relationships,       only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # deviseコントローラーによる追加
  # devise_for :users, controllers: {
  # sessions: 'users/sessions',
  # ログイン、アカウント編集後、任意のページに推移させるための記述
  # registrations: 'users/registrations'
  # }
end
