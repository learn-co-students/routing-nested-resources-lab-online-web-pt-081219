Rails.application.routes.draw do
  resources :artists do 
  resources :songs, only: [:show, :index]
  end

  resources :songs
  
  root 'songs#index'

end


# resources :authors, only: [:show] do
#   # nested resource for posts
#   resources :posts, only: [:show, :index]
# end
