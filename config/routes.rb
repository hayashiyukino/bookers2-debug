Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # get 'book_comments create/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  
  # ネストさせる
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources:book_comments,only:[:create,:destroy]
  end
  
  # ネストさせる
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
