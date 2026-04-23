return function(p1, p2) --[[ Line: 2 ]]
	local v1 = string.len(p1)
	local v2 = string.len(p2)
	local t = {}
	if v1 == 0 then
		return v2
	elseif v2 == 0 then
		return v1
	elseif p1 == p2 then
		return 0
	else
		for i = 0, v1 do
			t[i] = {}
			t[i][0] = i
		end
		for j = 0, v2 do
			t[0][j] = j
		end
		for k = 1, v1 do
			for n = 1, v2 do
				local v3
				v3 = if p1:byte(k) == p2:byte(n) then 0 else 1
				t[k][n] = math.min(t[k - 1][n] + 1, t[k][n - 1] + 1, t[k - 1][n - 1] + v3)
			end
		end
		return t[v1][v2]
	end
end