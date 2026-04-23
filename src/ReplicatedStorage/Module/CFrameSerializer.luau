local t = {}
local Bitbuf = require(script.Parent.Bitbuf)
local Base85 = require(script.Parent.Base85)
local function isAxisAligned(p1) --[[ Line: 14 ]]
	local t = { p1:GetComponents() }
	local count = 0
	local count_2 = 0
	for i = 4, 12 do
		local v2 = math.abs(t[i])
		if v2 == 1 then
			count_2 = count_2 + 1
		elseif v2 == 0 then
			count = count + 1
		end
	end
	return if count == 6 then count_2 == 3 else false
end
local function toNormalId(p1) --[[ Line: 32 ]]
	for i, v in ipairs(Enum.NormalId:GetEnumItems()) do
		if Vector3.FromNormalId(v):Dot(p1) == 1 then
			return v.Value
		end
	end
	return -1
end
local function isLegalOrientId(p1) --[[ Line: 45 ]]
	return math.floor(p1 / 6) % 3 ~= p1 % 3
end
local function getOrientId(p1) --[[ Line: 52 | Upvalues: isAxisAligned (copy), toNormalId (copy) ]]
	if isAxisAligned(p1) then
		local v1 = 6 * toNormalId(p1.RightVector) + toNormalId(p1.UpVector)
		if math.floor(v1 / 6) % 3 ~= v1 % 3 then
			return v1
		else
			return -1
		end
	else
		return -1
	end
end
local function encodeMatrix(p1) --[[ Line: 69 ]]
	local v1, v2, v3, v4, v5, v6, v7, v8, v9 = select(4, p1:GetComponents())
	local v10 = v1 + v5 + v9
	local v11 = 2
	local v12, v13, v14, v15
	if v10 > 0 then
		local v16 = v11 * math.sqrt(1 + v10)
		v12 = (v8 - v6) / v16
		v13 = (v3 - v7) / v16
		v14 = (v4 - v2) / v16
		v15 = v16 / 4
	elseif v5 < v1 and v9 < v1 then
		local v17 = v11 * math.sqrt(1 + v1 - v5 - v9)
		v12 = v17 / 4
		v13 = (v4 + v2) / v17
		v14 = (v3 + v7) / v17
		v15 = (v8 - v6) / v17
	elseif v9 < v5 then
		local v18 = v11 * math.sqrt(1 - v1 + v5 - v9)
		v12 = (v4 + v2) / v18
		v13 = v18 / 4
		v14 = (v8 + v6) / v18
		v15 = (v3 - v7) / v18
	else
		local v19 = v11 * math.sqrt(1 - v1 - v5 + v9)
		v12 = (v3 + v7) / v19
		v13 = (v8 + v6) / v19
		v14 = v19 / 4
		v15 = (v4 - v2) / v19
	end
	return { v12, v13, v14, v15 }
end
function t.encode(p1) --[[ Line: 109 | Upvalues: Bitbuf (copy), isAxisAligned (copy), toNormalId (copy), encodeMatrix (copy), Base85 (copy) ]]
	local v1 = Bitbuf.new()
	local Position = p1.Position
	v1:WriteFloat(32, Position.X)
	v1:WriteFloat(32, Position.Y)
	v1:WriteFloat(32, Position.Z)
	local v2
	if isAxisAligned(p1) then
		local v3 = 6 * toNormalId(p1.RightVector) + toNormalId(p1.UpVector)
		v2 = if math.floor(v3 / 6) % 3 ~= v3 % 3 then v3 else -1
	else
		v2 = -1
	end
	v1:WriteByte(v2 + 1)
	if v2 < 0 then
		local v5 = encodeMatrix(p1)
		v1:WriteByte(#v5)
		for i, v in ipairs(v5) do
			v1:WriteFloat(32, v)
		end
	end
	return Base85.encode((v1:String()))
end
function t.decode(p1) --[[ Line: 133 | Upvalues: Base85 (copy), Bitbuf (copy) ]]
	local v1, v2 = Base85.decode(p1)
	if v1 then
		assert(v1)
	end
	local v3 = Bitbuf.fromString(v2)
	local v4 = v3:ReadFloat(32)
	local v5 = v3:ReadFloat(32)
	local v6 = v3:ReadFloat(32)
	local v7 = v3:ReadByte()
	if v7 > 0 then
		local v8 = v7 - 1
		if math.floor(v8 / 6) % 3 ~= v8 % 3 then
			local v10 = Vector3.new(v4, v5, v6)
			local v11 = Vector3.FromNormalId(v8 / 6)
			return CFrame.fromMatrix(v10, v11, (Vector3.FromNormalId(v8 % 6)))
		else
			return CFrame.new(v4, v5, v6)
		end
	else
		local v13 = v3:ReadByte()
		local v14 = table.create(v13)
		for i = 1, v13 do
			v14[i] = v3:ReadFloat(32)
		end
		return CFrame.new(v4, v5, v6, unpack(v14))
	end
end
return t