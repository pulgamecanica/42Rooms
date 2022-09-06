module Rooms42Helper

	def aprox_15_min
		if (Time.zone.now.min > 45)
			return "00"
		elsif (Time.zone.now.min > 30)
			return "45"
		elsif (Time.zone.now.min > 15)
			return "30"
		end
		return ("15")
	end

	def aprox_1_hour
		if (Time.zone.now.min > 45)
			return ((Time.zone.now + 1.hour).hour.to_s)
		end
		return (Time.zone.now.hour.to_s)
	end

	def options_for_select_duration(max_time, min_time = 15.minutes)
		map = {}
		(min_time..max_time).step(15.minutes) do |t|
			res = ""
			if (t >= 1.hours)
				res += (t / 1.hours).to_s
				if (t >= 1.hours && t < 2.hours)
					res += " hr "
				else
					res += " hrs "
				end
			end
			res += ((t / 1.minutes) % 60).to_s + " min" unless t % 1.hours == 0
			map[res] = t/1.minutes
		end
		return map
	end

end
