Rails.application.routes.draw do

  resources :pins, only: [:index, :create,]
  resources :products do
    get "delete"
  end
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
resources :cart do
  collection do
  end
  resources :pins, except: [:edit, :delete, :destroy]
  end
 resources :pins do
  collection do
    get 'search'
  end
  resources :reviews, except: [:show, :index, :edit]
end

  resources :pins do
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
  get 'logout'  => 'sessions#destroy'
  get    'signup'  => 'uses#new'



  resources :uses
  resources :pins
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]


end


