return function(str1, str2)
	local str1Len = string.len(str1)
	local str2Len = string.len(str2)
	local distanceMatrix = {}
	if str1Len == 0 then
		return str2Len
	elseif str2Len == 0 then
		return str1Len
	elseif str1 == str2 then
		return 0
	else
		for i = 0, str1Len do
			distanceMatrix[i] = {}
			distanceMatrix[i][0] = i
		end
		for j = 0, str2Len do
			distanceMatrix[0][j] = j
		end
		for k = 1, str1Len do
			for n = 1, str2Len do
				local cost
				cost = if str1:byte(k) == str2:byte(n) then 0 else 1
				distanceMatrix[k][n] = math.min(distanceMatrix[k - 1][n] + 1, distanceMatrix[k][n - 1] + 1, distanceMatrix[k - 1][n - 1] + cost)
			end
		end
		return distanceMatrix[str1Len][str2Len]
	end
end
