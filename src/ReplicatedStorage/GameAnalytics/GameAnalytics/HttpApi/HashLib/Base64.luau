-- Reviewed by Claude
-- variables reassigned
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
function t2.Encode(inputString)
	local outputIndex = 0
	local encodedBytes = {}
	for i = 1, #inputString, 3 do
		local byte1, byte2, byte3 = string.byte(inputString, i, i + 2)
		local index1 = rshift(byte1, 2)
		local index2 = lshift(band(byte1, 3), 4) + rshift(byte2 or 0, 4)
		local index3 = lshift(band(byte2 or 0, 15), 2) + rshift(byte3 or 0, 6)
		local index4 = band(byte3 or 0, 63)
		local pos1 = outputIndex + 1
		encodedBytes[pos1] = list[index1 + 1]
		local pos2 = pos1 + 1
		encodedBytes[pos2] = list[index2 + 1]
		local pos3 = pos2 + 1
		encodedBytes[pos3] = byte2 and list[index3 + 1] or 61
		outputIndex = pos3 + 1
		encodedBytes[outputIndex] = byte3 and list[index4 + 1] or 61
	end
	local count = 0
	local t2 = {}
	for j = 1, outputIndex, 4096 do
		local chunkEnd
		count = count + 1
		local maxPos = j + 4096 - 1
		chunkEnd = if outputIndex < maxPos then outputIndex else maxPos
		t2[count] = string.char(table.unpack(encodedBytes, j, chunkEnd))
	end
	return table.concat(t2)
end
function t2.Decode(inputString)
	local count = 0
	local decodedBytes = {}
	for i = 1, #inputString, 4 do
		local byte1, byte2, byte3, byte4 = string.byte(inputString, i, i + 3)
		local index2 = t[byte2] - 1
		local index3 = (t[byte3] or 1) - 1
		local decodedByte1 = lshift(t[byte1] - 1, 2) + rshift(index2, 4)
		local decodedByte2 = lshift(band(index2, 15), 4) + rshift(index3, 2)
		local decodedByte3 = lshift(band(index3, 3), 6) + ((t[byte4] or 1) - 1)
		count = count + 1
		decodedBytes[count] = decodedByte1
		if byte3 ~= 61 then
			count = count + 1
			decodedBytes[count] = decodedByte2
		end
		if byte4 ~= 61 then
			count = count + 1
			decodedBytes[count] = decodedByte3
		end
	end
	local count_2 = 0
	local decodedChunks = {}
	for j = 1, count, 4096 do
		local chunkEnd
		count_2 = count_2 + 1
		local maxPos = j + 4096 - 1
		chunkEnd = if count < maxPos then count else maxPos
		decodedChunks[count_2] = string.char(table.unpack(decodedBytes, j, chunkEnd))
	end
	return table.concat(decodedChunks)
end
return t2
