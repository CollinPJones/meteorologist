require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_without_spaces}&sensor=false" #Google Geocode Url

    geo_parsed_data = JSON.parse(open(geocode_url).read)
    latitude = geo_parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = geo_parsed_data["results"][0]["geometry"]["location"]["lng"]

    darksky_url = "https://api.darksky.net/forecast/9bded32844920f92024e5417d56b8737/#{latitude},#{longitude}" #Darksky URL


    ds_parsed_data = JSON.parse(open(darksky_url).read)

    @current_temperature = ds_parsed_data["currently"]["temperature"]

    @current_summary = ds_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = ds_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = ds_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = ds_parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
