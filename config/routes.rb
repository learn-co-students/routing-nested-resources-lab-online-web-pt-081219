Rails.application.routes.draw do
  resources :artists do
    # nested resource for posts
    resources :songs, only: [:show, :index]
  end
 
  resources :songs, only: [:index, :show, :new, :create, :edit, :update]
 
  root 'songs#index'
end
