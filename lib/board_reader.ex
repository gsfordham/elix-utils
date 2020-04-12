defmodule ElixUtils.Mobo do
	# Return the motherboard hardware info
	def hw(files) do
		list = files["mobo"]
		directory = list["dir"]
		
		rgx = ~r/\r|\n/
		
		name = case File.read("#{directory}#{list["hw_name"]}") do
			{:ok, x} -> String.replace(x, rgx, "")
			_ -> "ERROR LOADING"
		end
		
		vendor = case File.read("#{directory}#{list["hw_vendor"]}") do
			{:ok, x} -> String.replace(x, rgx, "")
			_ -> "ERROR LOADING"
		end
		
		version = case File.read("#{directory}#{list["hw_version"]}") do
			{:ok, x} -> String.replace(x, rgx, "")
			_ -> "ERROR LOADING"
		end
		
		model = case File.read("#{directory}#{list["hw_model"]}") do
			{:ok, x} -> String.replace(x, rgx, "")
			_ -> "ERROR LOADING"
		end
		
		%{name: name, vendor: vendor, version: version, model: model}
	end
	
	# Return the motherboard BIOS info
	def bios(files) do
		
	end
end