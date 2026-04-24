-- Reviewed by Claude
local list = {}
local t = {}
for i = 65, 90 do
	table.insert(list, i)
end
for j = 97, 122 do
	table.insert(list, j)
end
table.insert(list, 48)
table.insert(list, 49)
table.insert(list, 50)
table.insert(list, 51)
table.insert(list, 52)
table.insert(list, 53)
table.insert(list, 54)
table.insert(list, 55)
table.insert(list, 56)
table.insert(list, 57)
table.insert(list, 43)
table.insert(list, 47)
for i, v in ipairs(list) do
	t[v] = i
end
local t2 = {}
local rshift = bit32.rshift
local lshift = bit32.lshift
local band = bit32.band
function t2.Encode(p1)
	local v1 = 0
	local t = {}
	for i = 1, #p1, 3 do
		local v2, v3, v4 = string.byte(p1, i, i + 2)
		local v5 = rshift(v2, 2)
		local v6 = lshift(band(v2, 3), 4) + rshift(v3 or 0, 4)
		local v7 = lshift(band(v3 or 0, 15), 2) + rshift(v4 or 0, 6)
		local v8 = band(v4 or 0, 63)
		local v9 = v1 + 1
		t[v9] = list[v5 + 1]
		local v10 = v9 + 1
		t[v10] = list[v6 + 1]
		local v11 = v10 + 1
		t[v11] = v3 and list[v7 + 1] or 61
		v1 = v11 + 1
		t[v1] = v4 and list[v8 + 1] or 61
	end
	local count = 0
	local t2 = {}
	for j = 1, v1, 4096 do
		local v14
		count = count + 1
		local v15 = j + 4096 - 1
		v14 = if v1 < v15 then v1 else v15
		t2[count] = string.char(table.unpack(t, j, v14))
	end
	return table.concat(t2)
end
function t2.Decode(p1)
	local count = 0
	local t2 = {}
	for i = 1, #p1, 4 do
		local v1, v2, v3, v4 = string.byte(p1, i, i + 3)
		local v6 = t[v2] - 1
		local v7 = (t[v3] or 1) - 1
		local v9 = lshift(t[v1] - 1, 2) + rshift(v6, 4)
		local v10 = lshift(band(v6, 15), 4) + rshift(v7, 2)
		local v11 = lshift(band(v7, 3), 6) + ((t[v4] or 1) - 1)
		count = count + 1
		t2[count] = v9
		if v3 ~= 61 then
			count = count + 1
			t2[count] = v10
		end
		if v4 ~= 61 then
			count = count + 1
			t2[count] = v11
		end
	end
	local count_2 = 0
	local t3 = {}
	for j = 1, count, 4096 do
		local v12
		count_2 = count_2 + 1
		local v13 = j + 4096 - 1
		v12 = if count < v13 then count else v13
		t3[count_2] = string.char(table.unpack(t2, j, v12))
	end
	return table.concat(t3)
end
return t2
