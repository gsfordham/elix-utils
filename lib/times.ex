defmodule ElixUtils.Times do
	# System uptime
	def uptime(file) do
		case File.read(file) do
			{:ok, data} -> fn ->
					seconds = String.split(data, " ", trim: true)
					parse_uptime(seconds)
				end.()
			_ -> "Error reading uptime!"
		end
	end
	
	# Extract uptime components
	def parse_uptime(seconds) do
		# Extract the seconds from text
		sraw = trunc(String.to_float(hd seconds))
		mraw = trunc(sraw / 60) # Minutes w/o seconds
		
		secs = rem(sraw, 60) # Final seconds
		hraw = trunc(mraw / 60) # Hours w/o minutes
		
		mins = rem(mraw, 60) # Final minutes
		draw = trunc(hraw / 24) # Days w/o hours
		
		hours = rem(hraw, 24) # Final hours
		weeks = trunc(draw / 7) # Weeks w/o days
		
		days = rem(draw, 7) # Final days
		
		%{weeks: weeks, days: days, hours: hours, minutes: mins, seconds: secs}
		#"#{weeks}, #{days}, #{hours}:#{mins}:#{secs}"
	end
end