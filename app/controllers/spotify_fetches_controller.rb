require 'rest-client'
require 'base64'
class SpotifyFetchesController < ApplicationController

  def index
    spotifyfetches = SpotifyFetch.all
    render json: spotifyfetches
  end

  def show
    spotifyfetch = SpotifyFetch.find(params[:id])
    render json: spotifyfetches
  end

  def create
    spotifyfetch = SpotifyFetch.new(spotify_fetches_params)

    if spotifyfetch.valid?
      spotifyfetch.save
      render json: spotifyfetch
    else
      render json: spotifyfetch.errors
    end
  end

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
    session[:spotify_access_token] = result['access_token']

    redirect_to "http://localhost:8000"
  end

  def caught_access_token
    # byebug
    response.headers['Access-Control-Allow-Credentials'] = true
    render json: { spotify_access_token: session[:spotify_access_token]}
  end

  private

  def spotify_fetches_params
    params.require(:spotifyfetch).permit(:business_name, :song_name, :artist_name)
  end


end
