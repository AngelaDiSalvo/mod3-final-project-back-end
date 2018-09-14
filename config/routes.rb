Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :yelp_fetches, only: [:index, :show, :create]
  resources :spotify_fetches, only: [:index, :show, :create]

  post '/yelp_fetches/search', to: 'yelp_fetches#search'
  get '/authorization', to: 'spotify_fetches#authorization'
  get '/', to: 'spotify_fetches#caught_access_token'
end
