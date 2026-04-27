return function(path)
	local pathSegments = string.split(path, "/")
	for i = #pathSegments, 1, -1 do
		if pathSegments[i] == "" then
			table.remove(pathSegments, i)
		end
	end
	return pathSegments
end
