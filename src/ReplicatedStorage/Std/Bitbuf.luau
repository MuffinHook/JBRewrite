local Bitbuf = {}
local function int_from_uint(bitCount, unsignedValue)
	local range = 2 ^ bitCount
	local result = unsignedValue % range
	if range / 2 <= result then
		return result - range
	else
		return result
	end
end
local function int_to_uint(bitCount, signedValue)
	return signedValue % 2 ^ bitCount
end
local function float32_to_uint(floatValue)
	return string.unpack("<I4", string.pack("<f", floatValue))
end
local function float32_from_uint(uintValue)
	return string.unpack("<f", string.pack("<I4", uintValue))
end
local function float64_to_uint(doubleValue)
	return string.unpack("<I8", string.pack("<d", doubleValue))
end
local function float64_from_uint(uintValue)
	return string.unpack("<d", string.pack("<I8", uintValue))
end
local function float_to_fixed(intBits, fracBits, floatValue)
	local range = 2 ^ (intBits + fracBits)
	local fixedValue = math.floor(floatValue * 2 ^ fracBits) % range
	if range / 2 <= fixedValue then
		return fixedValue - range
	else
		return fixedValue
	end
end
local function float_from_fixed(intBits, fracBits, fixedValue)
	local range = 2 ^ (intBits + fracBits)
	local result = fixedValue % range
	return math.floor(if range / 2 <= result then result - range else result) * 2 ^ (-fracBits)
end
local function float_to_ufixed(intBits, fracBits, floatValue)
	return math.floor(floatValue * 2 ^ fracBits) % 2 ^ (intBits + fracBits)
end
local function float_from_ufixed(intBits, fracBits, fixedValue)
	return math.floor(fixedValue % 2 ^ (intBits + fracBits)) * 2 ^ (-fracBits)
end
local BitbufMeta = {
	__index = {}
}
function Bitbuf.new(bitCapacity)
	assert(bitCapacity == nil or type(bitCapacity) == "number", "number expected")
	local capacity = bitCapacity or 0
	return setmetatable({
		buf = table.create(math.ceil(capacity / 32), 0),
		len = capacity,
		i = 0
	}, BitbufMeta)
end
function Bitbuf.fromString(sourceString)
	assert(type(sourceString) == "string", "string expected")
	local bufferSize = math.ceil(#sourceString / 4)
	local t = {
		buf = table.create(bufferSize, 0),
		len = #sourceString * 8,
		i = 0
	}
	for i = 0, math.floor(#sourceString / 4) - 1 do
		local b1, b2, b3, b4 = string.byte(sourceString, i * 4 + 1, i * 4 + 4)
		t.buf[i + 1] = bit32.bor(b1, b2 * 256, b3 * 65536, b4 * 16777216)
	end
	for j = 0, #sourceString % 4 - 1 do
		t.buf[bufferSize] = bit32.bor(t.buf[bufferSize], string.byte(sourceString, (bufferSize - 1) * 4 + j + 1) * 256 ^ j)
	end
	return setmetatable(t, BitbufMeta)
end
local function String(buffer)
	local byteCount = math.ceil(buffer.len / 32)
	local byteParts = table.create(byteCount, "")
	for i in ipairs(byteParts) do
		local bufWord = buffer.buf[i]
		if bufWord then
			byteParts[i] = string.pack("<I4", bufWord)
		else
			byteParts[i] = "\0\0\0\0"
		end
	end
	local remainingBits = buffer.len % 32
	if remainingBits > 0 then
		local maskedValue = bit32.band(buffer.buf[byteCount] or 0, bit32.lshift(1, remainingBits) - 1)
		byteParts[byteCount] = string.pack("<I" .. math.floor((buffer.len - 1) / 8) % 4 + 1, maskedValue)
	end
	return table.concat(byteParts)
end
BitbufMeta.__index.String = String
local function writeUnit(buffer, bitSize, value)
	assert(if bitSize >= 0 then bitSize <= 32 else false, "size must be in range [0,32]")
	if bitSize ~= 0 then
		local bufferIndex = bit32.rshift(buffer.i, 5) + 1
		local bitOffset = buffer.i % 32
		if bitOffset == 0 and bitSize == 32 then
			buffer.buf[bufferIndex] = bit32.band(value, 4294967295)
		else
			local bitsUntilEnd = 32 - bitOffset
			local overflowBits = bitSize - bitsUntilEnd
			if overflowBits <= 0 then
				buffer.buf[bufferIndex] = bit32.replace(buffer.buf[bufferIndex] or 0, value, bitOffset, bitSize)
			else
				buffer.buf[bufferIndex] = bit32.replace(buffer.buf[bufferIndex] or 0, bit32.extract(value, 0, bitsUntilEnd), bitOffset, bitsUntilEnd)
				buffer.buf[bufferIndex + 1] = bit32.replace(buffer.buf[bufferIndex + 1] or 0, bit32.extract(value, bitsUntilEnd, overflowBits), 0, overflowBits)
			end
		end
		buffer.i = buffer.i + bitSize
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
	end
end
BitbufMeta.__index.writeUnit = writeUnit
local function readUnit(buffer, bitSize)
	assert(if bitSize >= 0 then bitSize <= 32 else false, "size must be in range [0,32]")
	if bitSize == 0 then
		return 0
	else
		local bufferIndex = bit32.rshift(buffer.i, 5) + 1
		local bitOffset = buffer.i % 32
		buffer.i = buffer.i + bitSize
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
		if bitOffset == 0 and bitSize == 32 then
			return buffer.buf[bufferIndex] or 0
		else
			local bitsUntilEnd = 32 - bitOffset
			local remainingBits = bitsUntilEnd - bitSize
			if remainingBits >= 0 then
				return bit32.extract(buffer.buf[bufferIndex] or 0, bitOffset, bitSize)
			else
				return bit32.bor(bit32.extract(buffer.buf[bufferIndex] or 0, bitOffset, bitsUntilEnd), (bit32.lshift(bit32.extract(buffer.buf[bufferIndex + 1] or 0, 0, -remainingBits), bitsUntilEnd)))
			end
		end
	end
end
BitbufMeta.__index.readUnit = readUnit
local function Len(buffer)
	return buffer.len
end
BitbufMeta.__index.Len = Len
local function SetLen(buffer, newLen)
	if newLen < 0 then
		newLen = 0
	end
	if newLen < buffer.len then
		local bufferIndex = math.floor(newLen / 32) + 1
		if newLen % 32 == 0 then
			buffer.buf[bufferIndex] = nil
		else
			buffer.buf[bufferIndex] = bit32.band(buffer.buf[bufferIndex], 2 ^ (newLen % 32) - 1)
		end
		for i = bufferIndex + 1, math.floor((buffer.len - 1) / 32) + 1 do
			buffer.buf[i] = nil
		end
	end
	buffer.len = newLen
	if newLen < buffer.i then
		buffer.i = newLen
	end
end
BitbufMeta.__index.SetLen = SetLen
local function Index(buffer)
	return buffer.i
end
BitbufMeta.__index.Index = Index
local function SetIndex(buffer, newIndex)
	if newIndex < 0 then
		newIndex = 0
	end
	buffer.i = newIndex
	if buffer.len < newIndex then
		buffer.len = newIndex
	end
end
BitbufMeta.__index.SetIndex = SetIndex
local function Fits(buffer, bitSize)
	assert(type(bitSize) == "number", "number expected")
	return bitSize <= buffer.len - buffer.i
end
BitbufMeta.__index.Fits = Fits
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
BitbufMeta.__index.WritePad = WritePad
local function ReadPad(buffer, bitCount)
	assert(type(bitCount) == "number", "number expected")
	if not (bitCount <= 0) then
		buffer.i = buffer.i + bitCount
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
	end
end
BitbufMeta.__index.ReadPad = ReadPad
local function WriteAlign(buffer, alignment)
	assert(type(alignment) == "number", "number expected")
	if not (alignment <= 1) and buffer.i % alignment ~= 0 then
		writePad(buffer, (math.floor(math.ceil(buffer.i / alignment) * alignment - buffer.i)))
	end
end
BitbufMeta.__index.WriteAlign = WriteAlign
local function ReadAlign(buffer, alignment)
	assert(type(alignment) == "number", "number expected")
	if not (alignment <= 1) and buffer.i % alignment ~= 0 then
		buffer.i = buffer.i + math.floor(math.ceil(buffer.i / alignment) * alignment - buffer.i)
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
	end
end
BitbufMeta.__index.ReadAlign = ReadAlign
local function Reset(buffer)
	buffer.i = 0
	buffer.len = 0
	table.clear(buffer.buf)
end
BitbufMeta.__index.Reset = Reset
local function fastWriteBytes(buffer, byteString)
	if #byteString <= 4 then
		buffer:writeUnit(#byteString * 8, (string.unpack("<I" .. #byteString, byteString)))
	else
		local initialBytes = math.floor(3 - (buffer.i / 8 - 1) % 4)
		if initialBytes > 0 then
			buffer:writeUnit(initialBytes * 8, (string.unpack("<I" .. initialBytes, byteString)))
		end
		local wholeWords = math.floor((#byteString - initialBytes) / 4)
		local bufferIndex = bit32.rshift(buffer.i, 5) + 1
		for i2 = 0, wholeWords - 1 do
			buffer.buf[bufferIndex + i2] = string.unpack("<I4", byteString, initialBytes + i2 * 4 + 1)
		end
		buffer.i = buffer.i + wholeWords * 32
		if buffer.i > buffer.len then
			buffer.len = buffer.i
		end
		local trailingBytes = (#byteString - initialBytes) % 4
		if trailingBytes > 0 then
			buffer:writeUnit(trailingBytes * 8, string.unpack("<I" .. trailingBytes, byteString, #byteString - trailingBytes + 1))
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
BitbufMeta.__index.WriteBytes = WriteBytes
local function fastReadBytes(buffer, byteCount)
	if byteCount <= 4 then
		return string.pack("<I" .. byteCount, buffer:readUnit(byteCount * 8))
	else
		local initialBytes = math.floor(3 - (buffer.i / 8 - 1) % 4)
		local trailingBytes = (byteCount - initialBytes) % 4
		local parts = table.create((byteCount - initialBytes) / 4 + trailingBytes, nil)
		local partCount = 1
		if initialBytes > 0 then
			parts[partCount] = string.pack("<I" .. initialBytes, buffer:readUnit(initialBytes * 8))
			partCount = partCount + 1
		end
		local wholeWords = math.floor((byteCount - initialBytes) / 4)
		local bufferIndex = bit32.rshift(buffer.i, 5) + 1
		for i2 = 0, wholeWords - 1 do
			local bufWord = buffer.buf[bufferIndex + i2]
			if bufWord then
				parts[partCount] = string.pack("<I4", bufWord)
			else
				parts[partCount] = "\0\0\0\0"
			end
			partCount = partCount + 1
		end
		buffer.i = buffer.i + wholeWords * 32
		if buffer.len < partCount then
			buffer.len = partCount
		end
		if trailingBytes > 0 then
			parts[partCount] = string.pack("<I" .. trailingBytes, buffer:readUnit(trailingBytes * 8))
		end
		return table.concat(parts)
	end
end
local function ReadBytes(buffer, byteCount)
	assert(type(byteCount) == "number", "number expected")
	if byteCount == 0 then
		return ""
	elseif buffer.i % 8 == 0 then
		return fastReadBytes(buffer, byteCount)
	else
		local parts = table.create(byteCount, "")
		for i = 1, byteCount do
			parts[i] = string.char(buffer:readUnit(8))
		end
		return table.concat(parts)
	end
end
BitbufMeta.__index.ReadBytes = ReadBytes
local function WriteUint(buffer, bitSize, value)
	assert(type(bitSize) == "number", "number expected")
	assert(type(value) == "number", "number expected")
	assert(if bitSize >= 0 then bitSize <= 53 else false, "size must be in range [0,53]")
	if bitSize == 0 then
	elseif bitSize <= 32 then
		buffer:writeUnit(bitSize, value)
	else
		local maskedValue = value % 2 ^ bitSize
		buffer:writeUnit(32, maskedValue)
		buffer:writeUnit(bitSize - 32, (math.floor(maskedValue / 4294967296)))
	end
end
BitbufMeta.__index.WriteUint = WriteUint
local function ReadUint(buffer, bitSize)
	assert(type(bitSize) == "number", "number expected")
	assert(if bitSize >= 0 then bitSize <= 53 else false, "size must be in range [0,53]")
	if bitSize == 0 then
		return 0
	elseif bitSize <= 32 then
		return buffer:readUnit(bitSize)
	else
		return buffer:readUnit(32) + buffer:readUnit(bitSize - 32) * 4294967296
	end
end
BitbufMeta.__index.ReadUint = ReadUint
local function WriteBool(buffer, boolValue)
	if boolValue then
		buffer:writeUnit(1, 1)
	else
		buffer:writeUnit(1, 0)
	end
end
BitbufMeta.__index.WriteBool = WriteBool
local function ReadBool(buffer)
	return buffer:readUnit(1) == 1
end
BitbufMeta.__index.ReadBool = ReadBool
local function WriteByte(buffer, byteValue)
	assert(type(byteValue) == "number", "number expected")
	buffer:writeUnit(8, byteValue)
end
BitbufMeta.__index.WriteByte = WriteByte
local function ReadByte(buffer)
	return buffer:readUnit(8)
end
BitbufMeta.__index.ReadByte = ReadByte
local function WriteInt(buffer, bitSize, value)
	assert(type(bitSize) == "number", "number expected")
	assert(type(value) == "number", "number expected")
	assert(if bitSize >= 0 then bitSize <= 53 else false, "size must be in range [0,53]")
	if bitSize == 0 then
		return
	end
	local maskedValue = value % 2 ^ bitSize
	if bitSize <= 32 then
		buffer:writeUnit(bitSize, maskedValue)
	else
		buffer:writeUnit(32, maskedValue)
		buffer:writeUnit(bitSize - 32, (math.floor(maskedValue / 4294967296)))
	end
end
BitbufMeta.__index.WriteInt = WriteInt
local function ReadInt(buffer, bitSize)
	assert(type(bitSize) == "number", "number expected")
	assert(if bitSize >= 0 then bitSize <= 53 else false, "size must be in range [0,53]")
	if bitSize == 0 then
		return 0
	else
		local range = 2 ^ bitSize
		local readValue = if bitSize <= 32 then buffer:readUnit(bitSize) else buffer:readUnit(32) + buffer:readUnit(bitSize - 32) * 4294967296 % range
		if range / 2 <= readValue then
			return readValue - range
		else
			return readValue
		end
	end
end
BitbufMeta.__index.ReadInt = ReadInt
local function WriteFloat(buffer, bitSize, floatValue)
	assert(type(bitSize) == "number", "number expected")
	assert(type(floatValue) == "number", "number expected")
	assert(bitSize == 32 or bitSize == 64, "size must be 32 or 64")
	if bitSize == 32 then
		buffer:WriteBytes(string.pack("<f", floatValue))
	else
		buffer:WriteBytes(string.pack("<d", floatValue))
	end
end
BitbufMeta.__index.WriteFloat = WriteFloat
local function ReadFloat(buffer, bitSize)
	assert(type(bitSize) == "number", "number expected")
	assert(bitSize == 32 or bitSize == 64, "size must be 32 or 64")
	local packedBytes = buffer:ReadBytes(bitSize / 8)
	if bitSize == 32 then
		return string.unpack("<f", packedBytes)
	else
		return string.unpack("<d", packedBytes)
	end
end
BitbufMeta.__index.ReadFloat = ReadFloat
local function WriteUfixed(buffer, intBits, fracBits, floatValue)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	assert(type(floatValue) == "number", "number expected")
	buffer:WriteUint(intBits + fracBits, math.floor(floatValue * 2 ^ fracBits) % 2 ^ (intBits + fracBits))
end
BitbufMeta.__index.WriteUfixed = WriteUfixed
local function ReadUfixed(buffer, intBits, fracBits)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	return math.floor(buffer:ReadUint(intBits + fracBits) % 2 ^ (intBits + fracBits)) * 2 ^ (-fracBits)
end
BitbufMeta.__index.ReadUfixed = ReadUfixed
local function WriteFixed(buffer, intBits, fracBits, floatValue)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	assert(type(floatValue) == "number", "number expected")
	local range = 2 ^ (intBits + fracBits)
	local scaledValue = math.floor(floatValue * 2 ^ fracBits) % range
	buffer:WriteInt(intBits + fracBits, if range / 2 <= scaledValue then scaledValue - range else scaledValue)
end
BitbufMeta.__index.WriteFixed = WriteFixed
local function ReadFixed(buffer, intBits, fracBits)
	assert(type(intBits) == "number", "number expected")
	assert(type(fracBits) == "number", "number expected")
	assert(intBits >= 0, "integer size must be >= 0")
	assert(fracBits >= 0, "fractional size must be >= 0")
	assert(intBits + fracBits <= 53, "combined size must be <= 53")
	local range = 2 ^ (intBits + fracBits)
	local readValue = buffer:ReadInt(intBits + fracBits) % range
	return math.floor(if range / 2 <= readValue then readValue - range else readValue) * 2 ^ (-fracBits)
end
BitbufMeta.__index.ReadFixed = ReadFixed
function Bitbuf.isBuffer(instance)
	return getmetatable(instance) == BitbufMeta
end
return Bitbuf
