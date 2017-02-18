Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:index]
  end
  resources :posts, except: [:index]
end
