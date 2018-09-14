require 'rest-client'
require 'base64'
class SpotifyFetchesController < ApplicationController

  def index
    spotifyfetches = SpotifyFetch.all
    render json: spotifyfetches, include:[:yelp_fetch]
  end

  def show
    spotifyfetch = SpotifyFetch.find(params[:id])
    render json: spotifyfetches
  end

  def create
    # byebug
    spotifyfetch = SpotifyFetch.new(spotify_fetches_params)

    if spotifyfetch.valid?
      spotifyfetch.save
      render json: spotifyfetch
    else
      render json: spotifyfetch.errors
    end
  end
# receives the GET request from spotify
# we get the params a auth code that it uses that says ok to use our app
# requires us to send back our client secret so they know we are who we say we are
# secret stays on server in yml file
  def authorization
    authoVar = ENV['client_id'].chomp + ':' + ENV['client_secret'].chomp
    encoded = Base64.strict_encode64(authoVar.chomp).chomp
    # byebug

    response = RestClient.post('https://accounts.spotify.com/api/token',
      {
        code: params[:code],
        redirect_uri: 'http://localhost:3000/authorization',
        grant_type: 'authorization_code'
      },
      {
          'Authorization' => "Basic #{encoded}",
          'Content-Type' => 'application/json'
      })

    result = JSON.parse(response.body)
    # save in session
    session[:spotify_access_token] = result['access_token']

    redirect_to "http://localhost:8000"
  end
# their reponse is the access token which grab and save to session
  def caught_access_token
    # byebug
    # renders json is the response
    response.headers['Access-Control-Allow-Credentials'] = true
    render json: { spotify_access_token: session[:spotify_access_token]}
  end

  private

  def spotify_fetches_params
    params.require(:spotify_fetch).permit(:business_name, :song_name, :artist_name, :full_url, :prev_url, :album_cover, :album_cover_sm, :album_name, :yelp_fetch_id)
  end


end
