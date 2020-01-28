Rails.application.routes.draw do
  resources :artists
  resources :songs

  resources :artists, only: [:show] do
    resources :songs, only: [:index, :show]
  end
end
