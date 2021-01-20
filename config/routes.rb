Rails.application.routes.draw do
  resources :communities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  
  match '/auth/:provider/callback', to: 'sessions#facebook', via: [:get, :post]
  # get '/auth/facebook/callback' => 'sessions#facebook'

  resources :posts do
    # nested resource for comments
    resources :comment, only: [:index, :show, :new, :edit, :destroy]
  end 

  resources :communities do
    # nested resource for community
    resources :posts
  end
  
  resources :users

  resources :comments

  delete '/posts/:id' => 'posts#destroy'

  get '/signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  get '/logout' => 'sessions#destroy'
end
