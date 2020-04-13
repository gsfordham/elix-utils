defmodule ElixUtils.Procs do
	def lsproc do
		files = case File.ls("/proc") do
			{:ok, items} -> items
			_ -> nil
		end
		
		procs = case files do
			x when is_list(x) -> Enum.reject(x, fn(val) ->
					Regex.match?(~r/[\D]/, val)
				end)
		end
		
		%{processes: procs, count: length(procs)}
	end
end