defmodule ElixUtils.Mobo do
	# Create the directory and file list from 
	# config data passed
	def split(config) do
		list = config["mobo"]
		directory = list["dir"]
		{list, directory}
	end
	
	# Return the motherboard hardware info
	def hw(files) do
		{list, directory} = split(files)
		
		%{
			name: extract("#{directory}#{list["hw_name"]}"), 
			vendor: extract("#{directory}#{list["hw_vendor"]}"), 
			version: extract("#{directory}#{list["hw_version"]}"), 
			model: extract("#{directory}#{list["hw_model"]}")
		}
	end
	
	# Return the motherboard BIOS info
	def bios(files) do
		{list, directory} = split(files)
		
		%{
			vendor: extract("#{directory}#{list["bios_vendor"]}"), 
			version: extract("#{directory}#{list["bios_version"]}"), 
			date: extract("#{directory}#{list["bios_date"]}")
		}
	end
	
	# Return product identifying data
	# THIS ONE ONLY WORKS UNDER ROOT
	def product(files) do
		{list, directory} = split(files)
		
		%{
			serial: extract("#{directory}#{list["board_serial"]}")
		}
	end
	
	# Extract the data from the file requested
	def extract(file) do
		rgx = ~r/\r|\n/
		case File.read(file) do
			{:ok, x} -> String.replace(x, rgx, "")
			#{:error, reason} -> "#{reason}"
			_ -> "CANNOT ACCESS"
		end
	end
end