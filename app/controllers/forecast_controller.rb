require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/9bded32844920f92024e5417d56b8737/#{@lat},#{@lng}"

    parsed_data = JSON.parse(open(url).read)

    current_temp = parsed_data["currently"]["temperature"]
    current_sum = parsed_data["currently"]["summary"]
    sum_of_next_sixty_min = parsed_data["minutely"]["summary"]
    sum_of_next_several_hrs = parsed_data["minutely"]["summary"]
    sum_of_next_several_days = parsed_data["daily"]["summary"]

    @current_temperature = current_temp

    @current_summary = current_sum

    @summary_of_next_sixty_minutes = sum_of_next_sixty_min

    @summary_of_next_several_hours = sum_of_next_several_hrs

    @summary_of_next_several_days = sum_of_next_several_days

    render("forecast/coords_to_weather.html.erb")
  end
end
