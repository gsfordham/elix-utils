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
		#Enum.map(records, fn x -> 
		#		#IO.puts("Record: #{inspect x}\n\n")
		#		IO.puts("got a record")
		#	end)
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
	
	# Get the core mapping
	defp mapping do
		%{
			"physical id" => :socket,
			"processor" => :core_id,
			"vendor_id" => :vendor,
			"model name" => :name,
			"cache size" => :core_cache,
			"cpu mhz" => :core_clock,
			"cpu cores" => :core_count,
			"siblings" => :thread_count,
			"stepping" => :current_step
		}
	end
	
	# Initialize the core layout
	# Takes a single core's data to generate 
	# core structure formatter
	def init(data) do
		lines = Regex.split(~r/\r?\n/, data)
		seg_raw = partition(lines, length(lines))
		#IO.puts("Segments consist of: #{inspect seg_raw}")
		segments = clean(seg_raw)
		#Enum.map(segments, fn seg ->
		#		IO.puts("#{inspect seg}")
		#	end)
		cstruct = build_core(invert(mapping()), segments)
		#IO.puts("\n\nInverted mapping is: #{inspect invert(mapping())}\n\n")
		IO.puts("#{inspect cstruct}")
		cstruct
	end
	
	# Invert the key-value pair for
	# Object creation
	defp invert(m) do
		m
		|> Enum.map(fn {k, v} -> {v, k} end)
		|> Map.new()
	end
	
	# Filter only values of actual use
	def clean(items) do
		# Map.values(%ElixUtils.CPU.Core{})
		# Will return the map as a list, so as
		# to avoid duplication of code
		Enum.reject(items, fn item ->
				!Enum.member?(
					Map.keys(mapping),
					String.downcase(elem(item, 2)))
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
		raw_kv = line
		|> String.split(":")
		|> Enum.map(&String.trim/1)
		
		k = String.downcase(hd raw_kv)
		v = hd (tl raw_kv)

		map_atom = mapping[k]
		#IO.puts("The atom to search the map for is: #{map_atom}")
		[List.to_tuple(
			Enum.concat([index], # index
				[
					map_atom, # atom to build keyword list with
					k, # key
					v # value
			])
		)]
	end
	
	# Combine core components into usable struct
	def build_core(core, parts) do
		#IO.puts("core parts count: #{length(parts)} ")
		#IO.puts("Core is a: #{inspect core}")
		#IO.puts("Current part is: #{inspect (hd parts)}")
		if length(parts) > 0 do
			#IO.puts("Current core part: #{inspect (hd parts)}")
			#IO.puts("Items to merge are: #{inspect elem((hd parts), 1)}")
			build_core(%{core | elem((hd parts), 1) => elem((hd parts), 0)}, (tl parts))
			#IO.puts("#{inspect (hd parts)}")
			#core
		else
			core
		end
	end
	
	# Read a single core from the list
	def new(fmt, data) do
		
		
		
	end
end