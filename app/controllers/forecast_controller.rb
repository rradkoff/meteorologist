require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url_safe_lat = URI.encode(@lat)
    url_safe_lng = URI.encode(@lng)

    url = "https://api.forecast.io/forecast/714531fe02b2f727074906aa78836c12/#{@lat},#{@lng}"
    raw_data = open(url).read
    parsed_data = JSON.parse(open(url).read)
    currently = parsed_data["currently"]
    minutely = parsed_data["minutely"]
    hourly = parsed_data["hourly"]
    daily = parsed_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("coords_to_weather.html.erb")
  end
end
