Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  
  match '/auth/:provider/callback', to: 'sessions#facebook', via: [:get, :post]

  resources :posts do
    resources :comment, only: [:index, :show, :new, :edit, :destroy]
  end 
  
  resources :users do
    resources :posts, only: [:show, :index, :new]
  end

  resources :comments

  delete '/posts/:id' => 'posts#destroy'

  get '/signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  get '/logout' => 'sessions#destroy'
end
