defmodule ElixUtils.Base do
	def init(filename) do
		# Before decoding, make sure file works
		pre = case File.read("config/#{filename}") do
			{:ok, result} -> result
			_ -> fn -> 
					IO.puts("Failed to open configuration file")
					System.stop(1)
				end.()
		end
		
		# Try to decode the file
		post = case Jason.decode(pre) do
			{:ok, value} -> value
			_ -> fn ->
					IO.puts("Failed to decode file -- check that it is valid JSON format")
					System.stop(1)
				end.()
		end
		post
	end
end