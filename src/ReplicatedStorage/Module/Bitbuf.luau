local t = {}
local function int_from_uint(p1, p2) --[[ Line: 10 ]]
	local v1 = 2 ^ p1
	local v2 = p2 % v1
	if v1 / 2 <= v2 then
		return v2 - v1
	else
		return v2
	end
end
local function int_to_uint(p1, p2) --[[ Line: 19 ]]
	return p2 % 2 ^ p1
end
local function float32_to_uint(p1) --[[ Line: 23 ]]
	return string.unpack("<I4", string.pack("<f", p1))
end
local function float32_from_uint(p1) --[[ Line: 27 ]]
	return string.unpack("<f", string.pack("<I4", p1))
end
local function float64_to_uint(p1) --[[ Line: 31 ]]
	return string.unpack("<I8", string.pack("<d", p1))
end
local function float64_from_uint(p1) --[[ Line: 35 ]]
	return string.unpack("<d", string.pack("<I8", p1))
end
local function float_to_fixed(p1, p2, p3) --[[ Line: 39 ]]
	local v1 = 2 ^ (p1 + p2)
	local v2 = math.floor(p3 * 2 ^ p2) % v1
	if v1 / 2 <= v2 then
		return v2 - v1
	else
		return v2
	end
end
local function float_from_fixed(p1, p2, p3) --[[ Line: 43 ]]
	local v1 = 2 ^ (p1 + p2)
	local v2 = p3 % v1
	return math.floor(if v1 / 2 <= v2 then v2 - v1 else v2) * 2 ^ (-p2)
end
local function float_to_ufixed(p1, p2, p3) --[[ Line: 47 ]]
	return math.floor(p3 * 2 ^ p2) % 2 ^ (p1 + p2)
end
local function float_from_ufixed(p1, p2, p3) --[[ Line: 51 ]]
	return math.floor(p3 % 2 ^ (p1 + p2)) * 2 ^ (-p2)
end
local t2 = {
	__index = {}
}
function t.new(p1) --[[ Line: 72 | Upvalues: t2 (copy) ]]
	assert(p1 == nil or type(p1) == "number", "number expected")
	local v2 = p1 or 0
	return setmetatable({
		buf = table.create(math.ceil(v2 / 32), 0),
		len = v2,
		i = 0
	}, t2)
end
function t.fromString(p1) --[[ Line: 87 | Upvalues: t2 (copy) ]]
	assert(type(p1) == "string", "string expected")
	local v2 = math.ceil(#p1 / 4)
	local t = {
		buf = table.create(v2, 0),
		len = #p1 * 8,
		i = 0
	}
	for i = 0, math.floor(#p1 / 4) - 1 do
		local v3, v4, v5, v6 = string.byte(p1, i * 4 + 1, i * 4 + 4)
		t.buf[i + 1] = bit32.bor(v3, v4 * 256, v5 * 65536, v6 * 16777216)
	end
	for j = 0, #p1 % 4 - 1 do
		t.buf[v2] = bit32.bor(t.buf[v2], string.byte(p1, (v2 - 1) * 4 + j + 1) * 256 ^ j)
	end
	return setmetatable(t, t2)
end
local function String(p1) --[[ Line: 109 ]]
	local v2 = math.ceil(p1.len / 32)
	local v3 = table.create(v2, "")
	for i in ipairs(v3) do
		local v4 = p1.buf[i]
		if v4 then
			v3[i] = string.pack("<I4", v4)
		else
			v3[i] = "\0\0\0\0"
		end
	end
	local v5 = p1.len % 32
	if v5 > 0 then
		local v8 = bit32.band(p1.buf[v2] or 0, bit32.lshift(1, v5) - 1)
		v3[v2] = string.pack("<I" .. math.floor((p1.len - 1) / 8) % 4 + 1, v8)
	end
	return table.concat(v3)
end
t2.__index.String = String
local function writeUnit(p1, p2, p3) --[[ Line: 137 ]]
	assert(if p2 >= 0 then p2 <= 32 else false, "size must be in range [0,32]")
	if p2 ~= 0 then
		local v2 = bit32.rshift(p1.i, 5) + 1
		local v3 = p1.i % 32
		if v3 == 0 and p2 == 32 then
			p1.buf[v2] = bit32.band(p3, 4294967295)
		else
			local v4 = 32 - v3
			local v5 = p2 - v4
			if v5 <= 0 then
				p1.buf[v2] = bit32.replace(p1.buf[v2] or 0, p3, v3, p2)
			else
				p1.buf[v2] = bit32.replace(p1.buf[v2] or 0, bit32.extract(p3, 0, v4), v3, v4)
				p1.buf[v2 + 1] = bit32.replace(p1.buf[v2 + 1] or 0, bit32.extract(p3, v4, v5), 0, v5)
			end
		end
		p1.i = p1.i + p2
		if p1.i > p1.len then
			p1.len = p1.i
		end
	end
end
t2.__index.writeUnit = writeUnit
local function readUnit(p1, p2) --[[ Line: 174 ]]
	assert(if p2 >= 0 then p2 <= 32 else false, "size must be in range [0,32]")
	if p2 == 0 then
		return 0
	else
		local v2 = bit32.rshift(p1.i, 5) + 1
		local v3 = p1.i % 32
		p1.i = p1.i + p2
		if p1.i > p1.len then
			p1.len = p1.i
		end
		if v3 == 0 and p2 == 32 then
			return p1.buf[v2] or 0
		else
			local v4 = 32 - v3
			local v5 = v4 - p2
			if v5 >= 0 then
				return bit32.extract(p1.buf[v2] or 0, v3, p2)
			else
				return bit32.bor(bit32.extract(p1.buf[v2] or 0, v3, v4), (bit32.lshift(bit32.extract(p1.buf[v2 + 1] or 0, 0, -v5), v4)))
			end
		end
	end
end
t2.__index.readUnit = readUnit
local function Len(p1) --[[ Line: 199 ]]
	return p1.len
end
t2.__index.Len = Len
local function SetLen(p1, p2) --[[ Line: 208 ]]
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
local function Index(p1) --[[ Line: 236 ]]
	return p1.i
end
t2.__index.Index = Index
local function SetIndex(p1, p2) --[[ Line: 244 ]]
	if p2 < 0 then
		p2 = 0
	end
	p1.i = p2
	if p1.len < p2 then
		p1.len = p2
	end
end
t2.__index.SetIndex = SetIndex
local function Fits(p1, p2) --[[ Line: 258 ]]
	assert(type(p2) == "number", "number expected")
	return p2 <= p1.len - p1.i
end
t2.__index.Fits = Fits
local function readPad(p1, p2) --[[ Line: 263 ]]
	p1.i = p1.i + p2
	if p1.i > p1.len then
		p1.len = p1.i
	end
end
local function writePad(p1, p2) --[[ Line: 270 ]]
	for i = 1, math.floor(p2 / 32) do
		p1:writeUnit(32, 0)
	end
	p1:writeUnit(p2 % 32, 0)
end
local function WritePad(p1, p2) --[[ Line: 281 | Upvalues: writePad (copy) ]]
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 0) then
		writePad(p1, p2)
	end
end
t2.__index.WritePad = WritePad
local function ReadPad(p1, p2) --[[ Line: 293 ]]
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 0) then
		p1.i = p1.i + p2
		if p1.i > p1.len then
			p1.len = p1.i
		end
	end
end
t2.__index.ReadPad = ReadPad
local function WriteAlign(p1, p2) --[[ Line: 306 | Upvalues: writePad (copy) ]]
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 1) and p1.i % p2 ~= 0 then
		writePad(p1, (math.floor(math.ceil(p1.i / p2) * p2 - p1.i)))
	end
end
t2.__index.WriteAlign = WriteAlign
local function ReadAlign(p1, p2) --[[ Line: 319 ]]
	assert(type(p2) == "number", "number expected")
	if not (p2 <= 1) and p1.i % p2 ~= 0 then
		p1.i = p1.i + math.floor(math.ceil(p1.i / p2) * p2 - p1.i)
		if p1.i > p1.len then
			p1.len = p1.i
		end
	end
end
t2.__index.ReadAlign = ReadAlign
local function Reset(p1) --[[ Line: 331 ]]
	p1.i = 0
	p1.len = 0
	table.clear(p1.buf)
end
t2.__index.Reset = Reset
local function fastWriteBytes(p1, p2) --[[ Line: 340 ]]
	if #p2 <= 4 then
		p1:writeUnit(#p2 * 8, (string.unpack("<I" .. #p2, p2)))
	else
		local v2 = math.floor(3 - (p1.i / 8 - 1) % 4)
		if v2 > 0 then
			p1:writeUnit(v2 * 8, (string.unpack("<I" .. v2, p2)))
		end
		local v3 = math.floor((#p2 - v2) / 4)
		local v4 = bit32.rshift(p1.i, 5) + 1
		for i2 = 0, v3 - 1 do
			p1.buf[v4 + i2] = string.unpack("<I4", p2, v2 + i2 * 4 + 1)
		end
		p1.i = p1.i + v3 * 32
		if p1.i > p1.len then
			p1.len = p1.i
		end
		local v5 = (#p2 - v2) % 4
		if v5 > 0 then
			p1:writeUnit(v5 * 8, string.unpack("<I" .. v5, p2, #p2 - v5 + 1))
		end
	end
end
local function WriteBytes(p1, p2) --[[ Line: 373 | Upvalues: fastWriteBytes (copy) ]]
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
local function fastReadBytes(p1, p2) --[[ Line: 390 ]]
	if p2 <= 4 then
		return string.pack("<I" .. p2, p1:readUnit(p2 * 8))
	else
		local v2 = math.floor(3 - (p1.i / 8 - 1) % 4)
		local v3 = (p2 - v2) % 4
		local v4 = table.create((p2 - v2) / 4 + v3, nil)
		local count = 1
		if v2 > 0 then
			v4[count] = string.pack("<I" .. v2, p1:readUnit(v2 * 8))
			count = count + 1
		end
		local v5 = math.floor((p2 - v2) / 4)
		local v6 = bit32.rshift(p1.i, 5) + 1
		for i2 = 0, v5 - 1 do
			local v7 = p1.buf[v6 + i2]
			if v7 then
				v4[count] = string.pack("<I4", v7)
			else
				v4[count] = "\0\0\0\0"
			end
			count = count + 1
		end
		p1.i = p1.i + v5 * 32
		if p1.len < count then
			p1.len = count
		end
		if v3 > 0 then
			v4[count] = string.pack("<I" .. v3, p1:readUnit(v3 * 8))
		end
		return table.concat(v4)
	end
end
local function ReadBytes(p1, p2) --[[ Line: 434 | Upvalues: fastReadBytes (copy) ]]
	assert(type(p2) == "number", "number expected")
	if p2 == 0 then
		return ""
	elseif p1.i % 8 == 0 then
		return fastReadBytes(p1, p2)
	else
		local v2 = table.create(p2, "")
		for i = 1, p2 do
			v2[i] = string.char(p1:readUnit(8))
		end
		return table.concat(v2)
	end
end
t2.__index.ReadBytes = ReadBytes
local function WriteUint(p1, p2, p3) --[[ Line: 453 ]]
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
	elseif p2 <= 32 then
		p1:writeUnit(p2, p3)
	else
		local v4 = p3 % 2 ^ p2
		p1:writeUnit(32, v4)
		p1:writeUnit(p2 - 32, (math.floor(v4 / 4294967296)))
	end
end
t2.__index.WriteUint = WriteUint
local function ReadUint(p1, p2) --[[ Line: 472 ]]
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
local function WriteBool(p1, p2) --[[ Line: 486 ]]
	if p2 then
		p1:writeUnit(1, 1)
	else
		p1:writeUnit(1, 0)
	end
end
t2.__index.WriteBool = WriteBool
local function ReadBool(p1) --[[ Line: 498 ]]
	return p1:readUnit(1) == 1
end
t2.__index.ReadBool = ReadBool
local function WriteByte(p1, p2) --[[ Line: 505 ]]
	assert(type(p2) == "number", "number expected")
	p1:writeUnit(8, p2)
end
t2.__index.WriteByte = WriteByte
local function ReadByte(p1) --[[ Line: 513 ]]
	return p1:readUnit(8)
end
t2.__index.ReadByte = ReadByte
local function WriteInt(p1, p2, p3) --[[ Line: 521 ]]
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
		return
	end
	local v4 = p3 % 2 ^ p2
	if p2 <= 32 then
		p1:writeUnit(p2, v4)
	else
		p1:writeUnit(32, v4)
		p1:writeUnit(p2 - 32, (math.floor(v4 / 4294967296)))
	end
end
t2.__index.WriteInt = WriteInt
local function ReadInt(p1, p2) --[[ Line: 541 ]]
	assert(type(p2) == "number", "number expected")
	assert(if p2 >= 0 then p2 <= 53 else false, "size must be in range [0,53]")
	if p2 == 0 then
		return 0
	else
		local v5 = 2 ^ p2
		local v6 = if p2 <= 32 then p1:readUnit(p2) else p1:readUnit(32) + p1:readUnit(p2 - 32) * 4294967296 % v5
		if v5 / 2 <= v6 then
			return v6 - v5
		else
			return v6
		end
	end
end
t2.__index.ReadInt = ReadInt
local function WriteFloat(p1, p2, p3) --[[ Line: 563 ]]
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
local function ReadFloat(p1, p2) --[[ Line: 581 ]]
	assert(type(p2) == "number", "number expected")
	assert(p2 == 32 or p2 == 64, "size must be 32 or 64")
	local v3 = p1:ReadBytes(p2 / 8)
	if p2 == 32 then
		return string.unpack("<f", v3)
	else
		return string.unpack("<d", v3)
	end
end
t2.__index.ReadFloat = ReadFloat
local function WriteUfixed(p1, p2, p3, p4) --[[ Line: 598 ]]
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	assert(type(p4) == "number", "number expected")
	p1:WriteUint(p2 + p3, math.floor(p4 * 2 ^ p3) % 2 ^ (p2 + p3))
end
t2.__index.WriteUfixed = WriteUfixed
local function ReadUfixed(p1, p2, p3) --[[ Line: 613 ]]
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	return math.floor(p1:ReadUint(p2 + p3) % 2 ^ (p2 + p3)) * 2 ^ (-p3)
end
t2.__index.ReadUfixed = ReadUfixed
local function WriteFixed(p1, p2, p3, p4) --[[ Line: 627 ]]
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	assert(type(p4) == "number", "number expected")
	local v8 = 2 ^ (p2 + p3)
	local v9 = math.floor(p4 * 2 ^ p3) % v8
	p1:WriteInt(p2 + p3, if v8 / 2 <= v9 then v9 - v8 else v9)
end
t2.__index.WriteFixed = WriteFixed
local function ReadFixed(p1, p2, p3) --[[ Line: 642 ]]
	assert(type(p2) == "number", "number expected")
	assert(type(p3) == "number", "number expected")
	assert(p2 >= 0, "integer size must be >= 0")
	assert(p3 >= 0, "fractional size must be >= 0")
	assert(p2 + p3 <= 53, "combined size must be <= 53")
	local v6 = 2 ^ (p2 + p3)
	local v7 = p1:ReadInt(p2 + p3) % v6
	return math.floor(if v6 / 2 <= v7 then v7 - v6 else v7) * 2 ^ (-p3)
end
t2.__index.ReadFixed = ReadFixed
function t.isBuffer(p1) --[[ Line: 654 | Upvalues: t2 (copy) ]]
	return getmetatable(p1) == t2
end
return t