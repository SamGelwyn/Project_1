Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "pages#home"
  
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

end
