Rails.application.routes.draw do
  # get 'products/index'

  root 'static_pages#home'

  # static pages routes, not connected to models
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'

  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  # get '/products', to: 'products#new'
  # patch '/products/index', to: 'products#update'

  get '/reviews', to: 'reviews#new'
  post '/reviews', to: 'reviews#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :reviews
  resources :products
end
