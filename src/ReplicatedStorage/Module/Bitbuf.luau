-- Reviewed by Claude
local t = {}
local function int_from_uint(p1, p2)
	local v1 = 2 ^ p1
	local table2 = p2 % v1
	if v1 / 2 <= table2 then
		return table2 - v1
	else
		return table2
	end
end
local function int_to_uint(p1, p2)
	return p2 % 2 ^ p1
end
local function float32_to_uint(p1)
	return string.unpack("<I4", string.pack("<f", p1))
end
local function float32_from_uint(p1)
	return string.unpack("<f", string.pack("<I4", p1))
end
local function float64_to_uint(p1)
	return string.unpack("<I8", string.pack("<d", p1))
end
local function float64_from_uint(p1)
	return string.unpack("<d", string.pack("<I8", p1))
end
local function float_to_fixed(p1, p2, p3)
	local v1 = 2 ^ (p1 + p2)
	local table2 = math.floor(p3 * 2 ^ p2) % v1
	if v1 / 2 <= table2 then
		return table2 - v1
	else
		return table2
	end
end
local function float_from_fixed(p1, p2, p3)
	local v1 = 2 ^ (p1 + p2)
	local table2 = p3 % v1
	return math.floor(if v1 / 2 <= table2 then table2 - v1 else table2) * 2 ^ (-p2)
end
local function float_to_ufixed(p1, p2, p3)
	return math.floor(p3 * 2 ^ p2) % 2 ^ (p1 + p2)
end
local function float_from_ufixed(p1, p2, p3)
	return math.floor(p3 % 2 ^ (p1 + p2)) * 2 ^ (-p2)
end
local t2 = {
	__index = {}
}
function t.new(p1)
	assert(p1 == nil or type(p1) == "number", "number expected")
	local table2 = p1 or 0
	return setmetatable({
		buf = table.create(math.ceil(table2 / 32), 0),
		len = table2,
		i = 0
	}, t2)
end
function t.fromString(p1)
	assert(type(p1) == "string", "string expected")
	local table2 = math.ceil(#p1 / 4)
	local t = {
		buf = table.create(table2, 0),
		len = #p1 * 8,
		i = 0
	}
	for i = 0, math.floor(#p1 / 4) - 1 do
		local table3, var4, var5, var6 = string.byte(p1, i * 4 + 1, i * 4 + 4)
		t.buf[i + 1] = bit32.bor(table3, var4 * 256, var5 * 65536, var6 * 16777216)
	end
	for j = 0, #p1 % 4 - 1 do
		t.buf[table2] = bit32.bor(t.buf[table2], string.byte(p1, (table2 - 1) * 4 + j + 1) * 256 ^ j)
	end
	return setmetatable(t, t2)
end
local function String(p1)
	local table2 = math.ceil(p1.len / 32)
	local table3 = table.create(table2, "")
	for i in ipairs(table3) do
		local var4 = p1.buf[i]
		if var4 then
			table3[i] = string.pack("<I4", var4)
		else
			table3[i] = "\0\0\0\0"
		end
	end
	local var5 = p1.len % 32
	if var5 > 0 then
		local var8 = bit32.band(p1.buf[table2] or 0, bit32.lshift(1, var5) - 1)
		table3[table2] = string.pack("<I" .. math.floor((p1.len - 1) / 8) % 4 + 1, var8)
	end
	return table.concat(table3)
end
t2.__index.String = String
local function writeUnit(p1, p2, p3)
	assert(if p2 >= 0 then p2 <= 32 else false, "size must be in range [0,32]")
	if p2 ~= 0 then
		local table2 = bit32.rshift(p1.i, 5) + 1
		local table3 = p1.i % 32
		if table3 == 0 and p2 == 32 then
			p1.buf[table2] = bit32.band(p3, 4294967295)
		else
			local var4 = 32 - table3
			local var5 = p2 - var4
			if var5 <= 0 then
				p1.buf[table2] = bit32.replace(p1.buf[table2] or 0, p3, table3, p2)
			else
				p1.buf[table2] = bit32.replace(p1.buf[table2] or 0, bit32.extract(p3, 0, var4), table3, var4)
				p1.buf[table2 + 1] = bit32.replace(p1.buf[table2 + 1] or 0, bit32.extract(p3, var4, var5), 0, var5)
			end
		end
		p1.i = p1.i + p2
		if p1.i > p1.len then
			p1.len = p1.i
		end
	end
end
t2.__index.writeUnit = writeUnit
local function readUnit(p1, p2)
	assert(if p2 >= 0 then p2 <= 32 else false, "size must be in range [0,32]")
	if p2 == 0 then
		return 0
	else
		local table2 = bit32.rshift(p1.i, 5) + 1
		local table3 = p1.i % 32
		p1.i = p1.i + p2
		if p1.i > p1.len then
			p1.len = p1.i
		end
		if table3 == 0 and p2 == 32 then
			return p1.buf[table2] or 0
		else
			local var4 = 32 - table3
			local var5 = var4 - p2
			if var5 >= 0 then
				return bit32.extract(p1.buf[table2] or 0, table3, p2)
			else
				return bit32.bor(bit32.extract(p1.buf[table2] or 0, table3, var4), (bit32.lshift(bit32.extract(p1.buf[table2 + 1] or 0, 0, -var5), var4)))
			end
		end
	end
end
t2.__index.readUnit = readUnit
local function Len(p1)
	return p1.len
end
t2.__index.Len = Len
local function SetLen(p1, p2)
	if p2 < 0 then
		p2 = 0
	end
	if p2 < p1.len then
		local v1 = math.floor(p2 / 32) + 1
		if p2 % 32 == 0 then
			p1.buf[v1] = nil
		else
			p1.buf[v1] = bit32.band(p1.buf[v1], 2 ^ (p2 % 32) - 1)
		end
		for i = v1 + 1, math.floor((p1.len - 1) / 32) + 1 do
			p1.buf[i] = nil
		end
	end
	p1.len = p2
	if p2 < p1.i then
		p1.i = p2
	end
end
t2.__index.SetLen = SetLen
local function Index(p1)
	return p1.i
end
t2.__index.Index = Index
local function SetIndex(p1, p2)
	if p2 < 0 then
		p2 = 0
	end
	p1.i = p2
	if p1.len < p2 then
		p1.len = p2
	end
end
t2.__index.SetIndex = SetIndex
local function Fits(p1, p2)
	assert(type(p2) == "number", "number expected")
	return p2 <= p1.len - p1.i
end
t2.__index.Fits = Fits
local function readPad(p1, p2)
	p1.i = p1.i + p2
	if p1.i > p1.len then
		p1.len = p1.i
	end
end
local function writePad(p1, p2)
	for i = 1, math.floor(p2 / 32) do
		p1:writeUnit(32, 0)
	end
	p1:writeUnit(p2 % 32, 0)
end
local function WritePad(p1, p2)
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 0) then
		writePad(p1, p2)
	end
end
t2.__index.WritePad = WritePad
local function ReadPad(p1, p2)
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 0) then
		p1.i = p1.i + p2
		if p1.i > p1.len then
			p1.len = p1.i
		end
	end
end
t2.__index.ReadPad = ReadPad
local function WriteAlign(p1, p2)
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 1) and p1.i % p2 ~= 0 then
		writePad(p1, (math.floor(math.ceil(p1.i / p2) * p2 - p1.i)))
	end
end
t2.__index.WriteAlign = WriteAlign
local function ReadAlign(p1, p2)
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 1) and p1.i % p2 ~= 0 then
		p1.i = p1.i + math.floor(math.ceil(p1.i / p2) * p2 - p1.i)
		if p1.i > p1.len then
			p1.len = p1.i
		end
	end
end
t2.__index.ReadAlign = ReadAlign
local function Reset(p1)
	p1.i = 0
	p1.len = 0
	table.clear(p1.buf)
end
t2.__index.Reset = Reset
local function fastWriteBytes(p1, p2)
	if #p2 <= 4 then
		p1:writeUnit(#p2 * 8, (string.unpack("<I" .. #p2, p2)))
	else
		local table2 = math.floor(3 - (p1.i / 8 - 1) % 4)
		if table2 > 0 then
			p1:writeUnit(table2 * 8, (string.unpack("<I" .. table2, p2)))
		end
		local table3 = math.floor((#p2 - table2) / 4)
		local var4 = bit32.rshift(p1.i, 5) + 1
		for i2 = 0, table3 - 1 do
			p1.buf[var4 + i2] = string.unpack("<I4", p2, table2 + i2 * 4 + 1)
		end
		p1.i = p1.i + table3 * 32
		if p1.i > p1.len then
			p1.len = p1.i
		end
		local var5 = (#p2 - table2) % 4
		if var5 > 0 then
			p1:writeUnit(var5 * 8, string.unpack("<I" .. var5, p2, #p2 - var5 + 1))
		end
	end
end
local function WriteBytes(p1, p2)
	assert(type(p2) == "string", "string expected")
	if p2 ~= "" then
		if p1.i % 8 == 0 then
			fastWriteBytes(p1, p2)
			return
		end
		for i = 1, #p2 do
			p1:writeUnit(8, string.byte(p2, i))
		end
	end
end
t2.__index.WriteBytes = WriteBytes
local function fastReadBytes(p1, p2)
	if p2 <= 4 then
		return string.pack("<I" .. p2, p1:readUnit(p2 * 8))
	else
		local table2 = math.floor(3 - (p1.i / 8 - 1) % 4)
		local table3 = (p2 - table2) % 4
		local var4 = table.create((p2 - table2) / 4 + table3, nil)
		local count = 1
		if table2 > 0 then
			var4[count] = string.pack("<I" .. table2, p1:readUnit(table2 * 8))
			count = count + 1
		end
		local var5 = math.floor((p2 - table2) / 4)
		local var6 = bit32.rshift(p1.i, 5) + 1
		for i2 = 0, var5 - 1 do
			local var7 = p1.buf[var6 + i2]
			if var7 then
				var4[count] = string.pack("<I4", var7)
			else
				var4[count] = "\0\0\0\0"
			end
			count = count + 1
		end
		p1.i = p1.i + var5 * 32
		if p1.len < count then
			p1.len = count
		end
		if table3 > 0 then
			var4[count] = string.pack("<I" .. table3, p1:readUnit(table3 * 8))
		end
		return table.concat(var4)
	end
end
local function ReadBytes(p1, p2)
	assert(type(p2) == "number", "number expected")
	if p2 == 0 then
		return ""
	elseif p1.i % 8 == 0 then
		return fastReadBytes(p1, p2)
	else
		local table2 = table.create(p2, "")
		for i = 1, p2 do
			table2[i] = string.char(p1:readUnit(8))
		end
		return table.concat(table2)
	end
end
t2.__index.ReadBytes = ReadBytes
local function WriteUint(p1, p2, p3)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
	elseif p2 <= 32 then
		p1:writeUnit(p2, p3)
	else
		local var4 = p3 % 2 ^ p2
		p1:writeUnit(32, var4)
		p1:writeUnit(p2 - 32, (math.floor(var4 / 4294967296)))
	end
end
t2.__index.WriteUint = WriteUint
local function ReadUint(p1, p2)
	assert(type(p2) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
		return 0
	elseif p2 <= 32 then
		return p1:readUnit(p2)
	else
		return p1:readUnit(32) + p1:readUnit(p2 - 32) * 4294967296
	end
end
t2.__index.ReadUint = ReadUint
local function WriteBool(p1, p2)
	if p2 then
		p1:writeUnit(1, 1)
	else
		p1:writeUnit(1, 0)
	end
end
t2.__index.WriteBool = WriteBool
local function ReadBool(p1)
	return p1:readUnit(1) == 1
end
t2.__index.ReadBool = ReadBool
local function WriteByte(p1, p2)
	assert(type(p2) == "number", "number expected")
	p1:writeUnit(8, p2)
end
t2.__index.WriteByte = WriteByte
local function ReadByte(p1)
	return p1:readUnit(8)
end
t2.__index.ReadByte = ReadByte
local function WriteInt(p1, p2, p3)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
		return
	end
	local var4 = p3 % 2 ^ p2
	if p2 <= 32 then
		p1:writeUnit(p2, var4)
	else
		p1:writeUnit(32, var4)
		p1:writeUnit(p2 - 32, (math.floor(var4 / 4294967296)))
	end
end
t2.__index.WriteInt = WriteInt
local function ReadInt(p1, p2)
	assert(type(p2) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
		return 0
	else
		local var5 = 2 ^ p2
		local var6 = if p2 <= 32 then p1:readUnit(p2) else p1:readUnit(32) + p1:readUnit(p2 - 32) * 4294967296 % var5
		if var5 / 2 <= var6 then
			return var6 - var5
		else
			return var6
		end
	end
end
t2.__index.ReadInt = ReadInt
local function WriteFloat(p1, p2, p3)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 == 32 or p2 == 64, "size must be 32 or 64")
	if p2 == 32 then
		p1:WriteBytes(string.pack("<f", p3))
	else
		p1:WriteBytes(string.pack("<d", p3))
	end
end
t2.__index.WriteFloat = WriteFloat
local function ReadFloat(p1, p2)
	assert(type(p2) == "number", "number expected")
	assert(p2 == 32 or p2 == 64, "size must be 32 or 64")
	local table3 = p1:ReadBytes(p2 / 8)
	if p2 == 32 then
		return string.unpack("<f", table3)
	else
		return string.unpack("<d", table3)
	end
end
t2.__index.ReadFloat = ReadFloat
local function WriteUfixed(p1, p2, p3, p4)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	assert(type(p4) == "number", "number expected")
	p1:WriteUint(p2 + p3, math.floor(p4 * 2 ^ p3) % 2 ^ (p2 + p3))
end
t2.__index.WriteUfixed = WriteUfixed
local function ReadUfixed(p1, p2, p3)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	return math.floor(p1:ReadUint(p2 + p3) % 2 ^ (p2 + p3)) * 2 ^ (-p3)
end
t2.__index.ReadUfixed = ReadUfixed
local function WriteFixed(p1, p2, p3, p4)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	assert(type(p4) == "number", "number expected")
	local var8 = 2 ^ (p2 + p3)
	local var9 = math.floor(p4 * 2 ^ p3) % var8
	p1:WriteInt(p2 + p3, if var8 / 2 <= var9 then var9 - var8 else var9)
end
t2.__index.WriteFixed = WriteFixed
local function ReadFixed(p1, p2, p3)
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	local var6 = 2 ^ (p2 + p3)
	local var7 = p1:ReadInt(p2 + p3) % var6
	return math.floor(if var6 / 2 <= var7 then var7 - var6 else var7) * 2 ^ (-p3)
end
t2.__index.ReadFixed = ReadFixed
function t.isBuffer(p1)
	return getmetatable(p1) == t2
end
return t
