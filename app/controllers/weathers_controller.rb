class WeathersController < ApplicationController
	def index
		if Weather.last 
			@weathers = Weather.last_five
		else
			create_weather
			@weathers = Weather.all
		end
	end

	def show
		if Weather.last 
			@weather = Weather.last
		else
			@weather = create_weather
		end
	end

	def destroy
		Weather.destroy_all
		redirect_to '/'
	end

	def create
		generate_new_weather(Weather.last)
		redirect_to "/admin"
	end

	private

		def create_weather
			precipitation_roll = d20
			wind_roll = d20
			time = "late_night"
			Weather.create(precipitation: precipitation(precipitation_roll),
															wind: wind(wind_roll),
															time: time)
		end

		def d20
			rand(1..20)
		end

		def precipitation(roll)
			if roll > 1 && roll < 17
				"clear_skies"
			elsif roll >= 17 && roll <= 19
				"light_precipitation"
			else
				"heavy_precipitation"
			end
		end

		def wind(roll)
			if roll > 1 && roll < 15
				"no_wind"
			elsif roll >= 15 && roll <= 19
				"low_winds"
			else
				"high_winds"
			end
		end
		
		def generate_new_weather(weather)
			Weather.create(precipitation: get_new_precipitation(weather.precipitation),
															wind: get_new_wind(weather.wind),
															time: get_new_time(weather.time))
		end

		def get_new_precipitation(old_precipitation)
			if old_precipitation == "clear_skies"
				return precipitation(d20)
			elsif old_precipitation == "light_precipitation"
				roll = d20
				return "heavy_precipitation" if roll >= 18 && roll <= 20
				return "light_precipitation" if roll >= 10 && roll <= 17
				return "clear_skies" if roll <= 9
			else
				roll = d20
				return "heavy_precipitation" if roll >= 14 && roll <= 20
				return "light_precipitation" if roll >= 7 && roll <= 13
				return "clear_skies" if roll <=6
			end
			"clear_skies"
		end

		def get_new_wind(old_wind)
			if old_wind == "no_wind"
				return wind(d20)
			elsif old_wind == "low_winds"
				roll = d20
				return "high_winds" if roll >= 18 && roll <= 20
				return "low_winds" if roll >= 11 && roll <= 17
				return "no_wind" if roll <= 10
			else
				roll = d20
				return "high_winds" if roll >= 15 && roll <= 20
				return "low_winds" if roll >= 9 && roll <= 14
				return "no_wind" if roll <= 8
			end
			"no_wind"
		end

		def get_new_time(old_time)
			return "early_morning" if old_time == "late_night"
			return "morning" if old_time == "early_morning"
			return "afternoon" if old_time == "morning"
			return "evening" if old_time == "afternoon"
			return "night" if old_time == "evening"
			return "late_night" if old_time == "night"
			"late_night"
		end
end
