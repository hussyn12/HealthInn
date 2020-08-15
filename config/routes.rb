Rails.application.routes.draw do

  
 root to: 'page#home'
 get '/login' => 'admin/sessions#new'
 get '/logout' => 'admin/sessions#destroy'
 #get 'tags/:tag', to: 'admin/posts#index', as: :tag
 get 'tags/:tag', to: 'posts#index', as: :tag
 get 'categories/:cat', to: 'admin/posts#index', as: :cat
 get 'home' => 'page#home', as: :home
 get 'index' => 'posts#index', as: :index
 get '/:id' => 'posts#show', as: :post, :via => [:get, :post]
  

  namespace :admin do
  	resources :page
    resources :posts
    resources :elfinder, only: [:index]
    resources :settings, only: [:new, :create, :edit, :update]
    resources :dashboard, only: [:index]
    resources :categories, except: [:index]
    resources :sessions, only: [:new, :create, :destroy]
    resources :moderators, only: [:index, :edit, :update]
 end

end
