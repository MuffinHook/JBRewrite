local t = {}
local function int_from_uint(bitWidth, value)
	local moduloBase = 2 ^ bitWidth
	local wrappedValue = value % moduloBase
	if moduloBase / 2 <= wrappedValue then
		return wrappedValue - moduloBase
	else
		return wrappedValue
	end
end
local function int_to_uint(bitWidth, value)
	return value % 2 ^ bitWidth
end
local function float32_to_uint(floatValue)
	return string.unpack("<I4", string.pack("<f", floatValue))
end
local function float32_from_uint(uintValue)
	return string.unpack("<f", string.pack("<I4", uintValue))
end
local function float64_to_uint(floatValue)
	return string.unpack("<I8", string.pack("<d", floatValue))
end
local function float64_from_uint(uintValue)
	return string.unpack("<d", string.pack("<I8", uintValue))
end
local function float_to_fixed(intBits, fracBits, floatValue)
	local moduloBase = 2 ^ (intBits + fracBits)
	local scaledValue = math.floor(floatValue * 2 ^ fracBits) % moduloBase
	if moduloBase / 2 <= scaledValue then
		return scaledValue - moduloBase
	else
		return scaledValue
	end
end
local function float_from_fixed(intBits, fracBits, fixedValue)
	local moduloBase = 2 ^ (intBits + fracBits)
	local wrappedValue = fixedValue % moduloBase
	return math.floor(if moduloBase / 2 <= wrappedValue then wrappedValue - moduloBase else wrappedValue) * 2 ^ (-fracBits)
end
local function float_to_ufixed(intBits, fracBits, floatValue)
	return math.floor(floatValue * 2 ^ fracBits) % 2 ^ (intBits + fracBits)
end
local function float_from_ufixed(intBits, fracBits, ufixedValue)
	return math.floor(ufixedValue % 2 ^ (intBits + fracBits)) * 2 ^ (-fracBits)
end
local t2 = {
	__index = {}
}
function t.new(bufferSize)
	assert(bufferSize == nil or type(bufferSize) == "number", "number expected")
	local initialSize = bufferSize or 0
	return setmetatable({
		buf = table.create(math.ceil(initialSize / 32), 0),
		len = initialSize,
		i = 0
	}, t2)
end
function t.fromString(dataString)
	assert(type(dataString) == "string", "string expected")
	local bufferElementCount = math.ceil(#dataString / 4)
	local newBuffer = {
		buf = table.create(bufferElementCount, 0),
		len = #dataString * 8,
		i = 0
	}
	for i = 0, math.floor(#dataString / 4) - 1 do
		local byte1, byte2, byte3, byte4 = string.byte(dataString, i * 4 + 1, i * 4 + 4)
		newBuffer.buf[i + 1] = bit32.bor(byte1, byte2 * 256, byte3 * 65536, byte4 * 16777216)
	end
	for j = 0, #dataString % 4 - 1 do
		newBuffer.buf[bufferElementCount] = bit32.bor(newBuffer.buf[bufferElementCount], string.byte(dataString, (bufferElementCount - 1) * 4 + j + 1) * 256 ^ j)
	end
	return setmetatable(newBuffer, t2)
end
local function String(buffer)
	local bufferWordCount = math.ceil(buffer.len / 32)
	local byteStringTable = table.create(bufferWordCount, "")
	for i in ipairs(byteStringTable) do
		local bufferWord = buffer.buf[i]
		if bufferWord then
			byteStringTable[i] = string.pack("<I4", bufferWord)
		else
			byteStringTable[i] = "\0\0\0\0"
		end
	end
	local remainingBits = buffer.len % 32
	if remainingBits > 0 then
		local maskedWord = bit32.band(buffer.buf[bufferWordCount] or 0, bit32.lshift(1, remainingBits) - 1)
		byteStringTable[bufferWordCount] = string.pack("<I" .. math.floor((buffer.len - 1) / 8) % 4 + 1, maskedWord)
	end
	return table.concat(byteStringTable)
end
t2.__index.String = String
local function writeUnit(buffer, bitCount, value)
	assert(if bitCount >= 0 then bitCount <= 32 else false, "size must be in range [0,32]")
	if bitCount ~= 0 then
		local bufferIndex = bit32.rshift(buffer.i, 5) + 1
		local bitOffset = buffer.i % 32
		if bitOffset == 0 and bitCount == 32 then
			buffer.buf[bufferIndex] = bit32.band(value, 4294967295)
		else
			local bitsAvailable = 32 - bitOffset
			local bitsOverflow = bitCount - bitsAvailable
			if bitsOverflow <= 0 then
				buffer.buf[bufferIndex] = bit32.replace(buffer.buf[bufferIndex] or 0, value, bitOffset, bitCount)
			else
				buffer.buf[bufferIndex] = bit32.replace(buffer.buf[bufferIndex] or 0, bit32.extract(value, 0, bitsAvailable), bitOffset, bitsAvailable)
				buffer.buf[bufferIndex + 1] = bit32.replace(buffer.buf[bufferIndex + 1] or 0, bit32.extract(value, bitsAvailable, bitsOverflow), 0, bitsOverflow)
			end
		end
		buffer.i = buffer.i + bitCount
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
	end
end
t2.__index.writeUnit = writeUnit
local function readUnit(buffer, bitCount)
	assert(if bitCount >= 0 then bitCount <= 32 else false, "size must be in range [0,32]")
	if bitCount == 0 then
		return 0
	else
		local bufferIndex = bit32.rshift(buffer.i, 5) + 1
		local bitOffset = buffer.i % 32
		buffer.i = buffer.i + bitCount
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
		if bitOffset == 0 and bitCount == 32 then
			return buffer.buf[bufferIndex] or 0
		else
			local bitsAvailable = 32 - bitOffset
			local bitsSingleWord = bitsAvailable - bitCount
			if bitsSingleWord >= 0 then
				return bit32.extract(buffer.buf[bufferIndex] or 0, bitOffset, bitCount)
			else
				return bit32.bor(bit32.extract(buffer.buf[bufferIndex] or 0, bitOffset, bitsAvailable), (bit32.lshift(bit32.extract(buffer.buf[bufferIndex + 1] or 0, 0, -bitsSingleWord), bitsAvailable)))
			end
		end
	end
end
t2.__index.readUnit = readUnit
local function Len(buffer)
	return buffer.len
end
t2.__index.Len = Len
local function SetLen(buffer, newLength)
	if newLength < 0 then
		newLength = 0
	end
	if newLength < buffer.len then
		local bufferIndex = math.floor(newLength / 32) + 1
		if newLength % 32 == 0 then
			buffer.buf[bufferIndex] = nil
		else
			buffer.buf[bufferIndex] = bit32.band(buffer.buf[bufferIndex], 2 ^ (newLength % 32) - 1)
		end
		for i = bufferIndex + 1, math.floor((buffer.len - 1) / 32) + 1 do
			buffer.buf[i] = nil
		end
	end
	buffer.len = newLength
	if newLength < buffer.i then
		buffer.i = newLength
	end
end
t2.__index.SetLen = SetLen
local function Index(buffer)
	return buffer.i
end
t2.__index.Index = Index
local function SetIndex(buffer, newIndex)
	if newIndex < 0 then
		newIndex = 0
	end
	buffer.i = newIndex
	if buffer.len < newIndex then
		buffer.len = newIndex
	end
end
t2.__index.SetIndex = SetIndex
local function Fits(buffer, bitCount)
	assert(type(bitCount) == "number", "number expected")
	return bitCount <= buffer.len - buffer.i
end
t2.__index.Fits = Fits
local function readPad(buffer, bitCount)
	buffer.i = buffer.i + bitCount
	if buffer.i > buffer.len then
		buffer.len = buffer.i
	end
end
local function writePad(buffer, bitCount)
	for i = 1, math.floor(bitCount / 32) do
		buffer:writeUnit(32, 0)
	end
	buffer:writeUnit(bitCount % 32, 0)
end
local function WritePad(buffer, bitCount)
	assert(type(bitCount) == "number", "number expected")
	if not (bitCount <= 0) then
		writePad(buffer, bitCount)
	end
end
t2.__index.WritePad = WritePad
local function ReadPad(buffer, bitCount)
	assert(type(bitCount) == "number", "number expected")
	if not (bitCount <= 0) then
		buffer.i = buffer.i + bitCount
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
	end
end
t2.__index.ReadPad = ReadPad
local function WriteAlign(buffer, alignment)
	assert(type(alignment) == "number", "number expected")
	if not (alignment <= 1) and buffer.i % alignment ~= 0 then
		writePad(buffer, (math.floor(math.ceil(buffer.i / alignment) * alignment - buffer.i)))
	end
end
t2.__index.WriteAlign = WriteAlign
local function ReadAlign(buffer, alignment)
	assert(type(alignment) == "number", "number expected")
	if not (alignment <= 1) and buffer.i % alignment ~= 0 then
		buffer.i = buffer.i + math.floor(math.ceil(buffer.i / alignment) * alignment - buffer.i)
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
	end
end
t2.__index.ReadAlign = ReadAlign
local function Reset(buffer)
	buffer.i = 0
	buffer.len = 0
	table.clear(buffer.buf)
end
t2.__index.Reset = Reset
local function fastWriteBytes(buffer, byteString)
	if #byteString <= 4 then
		buffer:writeUnit(#byteString * 8, (string.unpack("<I" .. #byteString, byteString)))
	else
		local alignmentBytes = math.floor(3 - (buffer.i / 8 - 1) % 4)
		if alignmentBytes > 0 then
			buffer:writeUnit(alignmentBytes * 8, (string.unpack("<I" .. alignmentBytes, byteString)))
		end
		local fullWordCount = math.floor((#byteString - alignmentBytes) / 4)
		local bufferWordIndex = bit32.rshift(buffer.i, 5) + 1
		for i2 = 0, fullWordCount - 1 do
			buffer.buf[bufferWordIndex + i2] = string.unpack("<I4", byteString, alignmentBytes + i2 * 4 + 1)
		end
		buffer.i = buffer.i + fullWordCount * 32
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
		local remainingBytes = (#byteString - alignmentBytes) % 4
		if remainingBytes > 0 then
			buffer:writeUnit(remainingBytes * 8, string.unpack("<I" .. remainingBytes, byteString, #byteString - remainingBytes + 1))
		end
	end
end
local function WriteBytes(buffer, byteString)
	assert(type(byteString) == "string", "string expected")
	if byteString ~= "" then
		if buffer.i % 8 == 0 then
			fastWriteBytes(buffer, byteString)
			return
		end
		for i = 1, #byteString do
			buffer:writeUnit(8, string.byte(byteString, i))
		end
	end
end
t2.__index.WriteBytes = WriteBytes
local function fastReadBytes(buffer, byteCount)
	if byteCount <= 4 then
		return string.pack("<I" .. byteCount, buffer:readUnit(byteCount * 8))
	else
		local alignmentBytes = math.floor(3 - (buffer.i / 8 - 1) % 4)
		local remainingBytes = (byteCount - alignmentBytes) % 4
		local byteStringTable = table.create((byteCount - alignmentBytes) / 4 + remainingBytes, nil)
		local count = 1
		if alignmentBytes > 0 then
			byteStringTable[count] = string.pack("<I" .. alignmentBytes, buffer:readUnit(alignmentBytes * 8))
			count = count + 1
		end
		local fullWordCount = math.floor((byteCount - alignmentBytes) / 4)
		local bufferWordIndex = bit32.rshift(buffer.i, 5) + 1
		for i2 = 0, fullWordCount - 1 do
			local bufferWord = buffer.buf[bufferWordIndex + i2]
			if bufferWord then
				byteStringTable[count] = string.pack("<I4", bufferWord)
			else
				byteStringTable[count] = "\0\0\0\0"
			end
			count = count + 1
		end
		buffer.i = buffer.i + fullWordCount * 32
		if buffer.len < count then
			buffer.len = count
		end
		if remainingBytes > 0 then
			byteStringTable[count] = string.pack("<I" .. remainingBytes, buffer:readUnit(remainingBytes * 8))
		end
		return table.concat(byteStringTable)
	end
end
local function ReadBytes(buffer, byteCount)
	assert(type(byteCount) == "number", "number expected")
	if byteCount == 0 then
		return ""
	elseif buffer.i % 8 == 0 then
		return fastReadBytes(buffer, byteCount)
	else
		local byteStringTable = table.create(byteCount, "")
		for i = 1, byteCount do
			byteStringTable[i] = string.char(buffer:readUnit(8))
		end
		return table.concat(byteStringTable)
	end
end
t2.__index.ReadBytes = ReadBytes
local function WriteUint(buffer, bitWidth, value)
	assert(type(bitWidth) == "number", "number expected")
	assert(type(value) == "number", "number expected")
	assert(if bitWidth >= 0 then bitWidth <= 53 else false, "size must be in range [0,53]")
	if bitWidth == 0 then
	elseif bitWidth <= 32 then
		buffer:writeUnit(bitWidth, value)
	else
		local lowBits = value % 2 ^ bitWidth
		buffer:writeUnit(32, lowBits)
		buffer:writeUnit(bitWidth - 32, (math.floor(lowBits / 4294967296)))
	end
end
t2.__index.WriteUint = WriteUint
local function ReadUint(buffer, bitWidth)
	assert(type(bitWidth) == "number", "number expected")
	assert(if bitWidth >= 0 then bitWidth <= 53 else false, "size must be in range [0,53]")
	if bitWidth == 0 then
		return 0
	elseif bitWidth <= 32 then
		return buffer:readUnit(bitWidth)
	else
		return buffer:readUnit(32) + buffer:readUnit(bitWidth - 32) * 4294967296
	end
end
t2.__index.ReadUint = ReadUint
local function WriteBool(buffer, isTrue)
	if isTrue then
		buffer:writeUnit(1, 1)
	else
		buffer:writeUnit(1, 0)
	end
end
t2.__index.WriteBool = WriteBool
local function ReadBool(buffer)
	return buffer:readUnit(1) == 1
end
t2.__index.ReadBool = ReadBool
local function WriteByte(buffer, byteValue)
	assert(type(byteValue) == "number", "number expected")
	buffer:writeUnit(8, byteValue)
end
t2.__index.WriteByte = WriteByte
local function ReadByte(buffer)
	return buffer:readUnit(8)
end
t2.__index.ReadByte = ReadByte
local function WriteInt(buffer, bitWidth, value)
	assert(type(bitWidth) == "number", "number expected")
	assert(type(value) == "number", "number expected")
	assert(if bitWidth >= 0 then bitWidth <= 53 else false, "size must be in range [0,53]")
	if bitWidth == 0 then
		return
	end
	local wrappedValue = value % 2 ^ bitWidth
	if bitWidth <= 32 then
		buffer:writeUnit(bitWidth, wrappedValue)
	else
		buffer:writeUnit(32, wrappedValue)
		buffer:writeUnit(bitWidth - 32, (math.floor(wrappedValue / 4294967296)))
	end
end
t2.__index.WriteInt = WriteInt
local function ReadInt(buffer, bitWidth)
	assert(type(bitWidth) == "number", "number expected")
	assert(if bitWidth >= 0 then bitWidth <= 53 else false, "size must be in range [0,53]")
	if bitWidth == 0 then
		return 0
	else
		local moduloBase = 2 ^ bitWidth
		local readValue = if bitWidth <= 32 then buffer:readUnit(bitWidth) else buffer:readUnit(32) + buffer:readUnit(bitWidth - 32) * 4294967296 % moduloBase
		if moduloBase / 2 <= readValue then
			return readValue - moduloBase
		else
			return readValue
		end
	end
end
t2.__index.ReadInt = ReadInt
local function WriteFloat(buffer, bitWidth, floatValue)
	assert(type(bitWidth) == "number", "number expected")
	assert(type(floatValue) == "number", "number expected")
	assert(bitWidth == 32 or bitWidth == 64, "size must be 32 or 64")
	if bitWidth == 32 then
		buffer:WriteBytes(string.pack("<f", floatValue))
	else
		buffer:WriteBytes(string.pack("<d", floatValue))
	end
end
t2.__index.WriteFloat = WriteFloat
local function ReadFloat(buffer, bitWidth)
	assert(type(bitWidth) == "number", "number expected")
	assert(bitWidth == 32 or bitWidth == 64, "size must be 32 or 64")
	local byteString = buffer:ReadBytes(bitWidth / 8)
	if bitWidth == 32 then
		return string.unpack("<f", byteString)
	else
		return string.unpack("<d", byteString)
	end
end
t2.__index.ReadFloat = ReadFloat
local function WriteUfixed(buffer, intBits, fracBits, floatValue)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	assert(type(floatValue) == "number", "number expected")
	buffer:WriteUint(intBits + fracBits, math.floor(floatValue * 2 ^ fracBits) % 2 ^ (intBits + fracBits))
end
t2.__index.WriteUfixed = WriteUfixed
local function ReadUfixed(buffer, intBits, fracBits)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	return math.floor(buffer:ReadUint(intBits + fracBits) % 2 ^ (intBits + fracBits)) * 2 ^ (-fracBits)
end
t2.__index.ReadUfixed = ReadUfixed
local function WriteFixed(buffer, intBits, fracBits, floatValue)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	assert(type(floatValue) == "number", "number expected")
	local moduloBase = 2 ^ (intBits + fracBits)
	local scaledValue = math.floor(floatValue * 2 ^ fracBits) % moduloBase
	buffer:WriteInt(intBits + fracBits, if moduloBase / 2 <= scaledValue then scaledValue - moduloBase else scaledValue)
end
t2.__index.WriteFixed = WriteFixed
local function ReadFixed(buffer, intBits, fracBits)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	local moduloBase = 2 ^ (intBits + fracBits)
	local wrappedValue = buffer:ReadInt(intBits + fracBits) % moduloBase
	return math.floor(if moduloBase / 2 <= wrappedValue then wrappedValue - moduloBase else wrappedValue) * 2 ^ (-fracBits)
end
t2.__index.ReadFixed = ReadFixed
function t.isBuffer(instance)
	return getmetatable(instance) == t2
end
return t
