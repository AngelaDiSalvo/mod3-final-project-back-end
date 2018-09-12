require 'rest-client'
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
    byebug
  end

  private

  def spotify_fetches_params
    params.require(:spotifyfetch).permit(:business_name, :song_name, :artist_name)
  end


end
