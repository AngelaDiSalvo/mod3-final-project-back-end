require 'rest-client'
class YelpFetchesController < ApplicationController

  def index
    yelpfetches = YelpFetch.all
    render json: yelpfetches
  end

  def show
    yelpfetch = YelpFetch.find(params[:id])
    render json: yelpfetches
  end

  def create
    yelpfetch = YelpFetch.new(yelp_fetches_params)

    if yelpfetch.valid?
      yelpfetch.save
      render json: yelpfetch
    else
      render json: yelpfetch.errors
    end
  end

  def search
    yelpBaseURL = "https://api.yelp.com/v3/businesses/search?"
    yelpURL = "#{yelpBaseURL}term=#{params[:search_term]}&location=#{params[:location]}"
    yelpAPI = ENV['yelpAPIKey']
    response = RestClient.get(yelpURL, {'Authorization' => "Bearer #{yelpAPI}"  })
    result = JSON.parse(response.body)

    render json: result
  end

  private

  def yelp_fetches_params
    params.require(:yelpfetch).permit(:location, :search_term)
  end


end
