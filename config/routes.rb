Rails.application.routes.draw do
  
  resources :products
  root "pins#index"
  get 'cart/index'


  resources :picture_frames
  get 'picture_frames/portrait'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'uses/new'

  get '/cart' => 'cart#index'
  
  get '/cart/clear' => 'cart#clearCart'
  
  get '/cart/:id' => 'cart#add'

 resources :pins do
  collection do
    get 'search'
  end
  resources :reviews, except: [:show, :index, :edit]
end

  resources :products do
    get "delete"
  end

  resources :pins do
  	resources :pins
  	member do
  		put "like",    to: "pins#upvote"
  	end
  end

  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'signup'  => 'uses#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :uses

  resources :pins
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]


end


