require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    require'open-uri'
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    raw_data = open(url).read
    require 'JSON'
    parsed_data = JSON.parse(open(url).read)

    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lon = parsed_data["results"][0]["geometry"]["location"]["lng"]

    urlw = "https://api.forecast.io/forecast/714531fe02b2f727074906aa78836c12/#{@lat},#{@lon}"
    raw_data = open(urlw).read
    parsed_data = JSON.parse(open(urlw).read)
    currently = parsed_data["currently"]
    minutely = parsed_data["minutely"]
    hourly = parsed_data["hourly"]
    daily = parsed_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("street_to_weather.html.erb")
  end
end
