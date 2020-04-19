defmodule ElixUtils.CPU do
	# Generate initial count of sockets
	def init(files) do
		records = read(files)
		structure = ElixUtils.CPU.Core.init(hd records)
		IO.puts("#{inspect structure}")
		
		%{cpu: nil, core: nil}
	end
	
	# Read CPU file
	def read(files) do
		path = "#{files["cpu"]["dir"]}#{files["cpu"]["data"]}"
		#IO.puts(path)
		case File.read(path) do
			{:ok, x} -> split_cores(x)
			_ -> "CANNOT ACCESS CPU FILE"
		end
	end
	
	# Split the cores by empty lines
	def split_cores(data) do
		records = Enum.reject(
			Regex.split(~r/\r?\n[\s]*\r?\n/, data), fn x -> 
					String.trim(x) == ""
				end)
		IO.puts("There are #{length(records)} cores/threads")
		Enum.map(records, fn x -> 
				IO.puts("Record: #{inspect x}\n\n")
			end)
		#IO.puts("Parts of CPU: #{inspect records}")
		records
	end
end

defmodule ElixUtils.CPU.Core do
	# Struct that is used to generate
	# core data INDICES
	#
	# Comments to the right are the fields
	# as they should be written on the data 
	defstruct [
		#socket: 0, # "physical id"
		#core_id: 0, # "processor"
		#vendor: "DEFAULT VENDOR", # "vendor_id"
		#name: "DEFAULT CPU", # "model name"
		#core_cache: 0, # "cache size"
		#core_clock: 0, # "cpu MHz"
		#core_count: 0, # "cpu cores"
		#thread_count: 0 # "siblings"
		
		socket: "physical id",
		core_id: "processor",
		vendor: "vendor_id",
		name: "model name",
		core_cache: "cache size",
		core_clock: "cpu MHz",
		core_count: "cpu cores",
		thread_count: "siblings",
		current_step: "stepping"
	]
	
	# Initialize the core layout
	# Takes a single core's data to generate 
	# core structure formatter
	def init(data) do
		lines = Regex.split(~r/\r?\n/, data)
		#Enum.map(lines, fn line ->
		#		IO.puts("Line: #{line}")
		#	end)
		#fmt = %Core{}
		#|> Enum.map()
		segments = clean(partition(lines, length(lines)))
		Enum.map(segments, fn seg ->
				IO.puts("#{inspect seg}")
			end)
		cstruct = build_core(%ElixUtils.CPU.Core{}, segments)
		IO.puts("#{inspect cstruct}")
		segments
	end
	
	# Filter only values of actual use
	def clean(items) do
		# Map.values(%ElixUtils.CPU.Core{})
		# Will return the map as a list, so as
		# to avoid duplication of code
		Enum.reject(items, fn item ->
				!Enum.member?(
						#[
						#"processor",
						#"vendor_id",
						#"model name",
						#"cpu mhz",
						#"cache size",
						#"physical id",
						#"siblings",
						#"core id",
						#"cpu cores",
						#"stepping"
						#]
					Map.values(%ElixUtils.CPU.Core{}),
					String.downcase(elem(item, 1)))
			end)
	end
	
	# Split core segments into k/v-like tuples
	def partition(lines, index) do
		cl = length(lines)
		if cl > 1 do
			Enum.concat(
				divide(index - cl, hd lines),
				partition((tl lines), (index)))
		else
			divide(cl - index, hd lines)
		end
	end
	
	# Divide the line
	def divide(index, line) do
		[List.to_tuple(
			Enum.concat([index],
			Regex.split(~r/\s*:\s*/, String.trim(line), parts: 2))
		)]
	end
	
	# Combine core components into usable struct
	def build_core(core, parts) do
		if length(parts) > 0 do
			core
		else
			core
		end
		nil
	end
	
	# Read a single core from the list
	def new(fmt, data) do
		
		
		
	end
end