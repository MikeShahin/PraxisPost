Rails.application.routes.draw do
  root 'posts#index'
  
  match '/auth/:provider/callback', to: 'sessions#facebook', via: [:get, :post]
  
  resources :posts
  
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
