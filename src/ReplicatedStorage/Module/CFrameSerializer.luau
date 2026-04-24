-- Reviewed by Claude
local t = {}
local Bitbuf = require(script.Parent.Bitbuf)
local Base85 = require(script.Parent.Base85)
local function isAxisAligned(p1)
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
local function toNormalId(p1)
	for i, v in ipairs(Enum.NormalId:GetEnumItems()) do
		if Vector3.FromNormalId(v):Dot(p1) == 1 then
			return v.Value
		end
	end
	return -1
end
local function isLegalOrientId(p1)
	return math.floor(p1 / 6) % 3 ~= p1 % 3
end
local function getOrientId(p1)
	if isAxisAligned(p1) then
		local instance = 6 * toNormalId(p1.RightVector) + toNormalId(p1.UpVector)
		if math.floor(instance / 6) % 3 ~= instance % 3 then
			return instance
		else
			return -1
		end
	else
		return -1
	end
end
local function encodeMatrix(p1)
	local instance, v2, var3, var4, var5, var6, var7, var8, v9 = select(4, p1:GetComponents())
	local var10 = instance + var5 + v9
	local var11 = 2
	local v12, var13, table14, v15
	if var10 > 0 then
		local var16 = var11 * math.sqrt(1 + var10)
		v12 = (var8 - var6) / var16
		var13 = (var3 - var7) / var16
		table14 = (var4 - v2) / var16
		v15 = var16 / 4
	elseif var5 < instance and v9 < instance then
		local var17 = var11 * math.sqrt(1 + instance - var5 - v9)
		v12 = var17 / 4
		var13 = (var4 + v2) / var17
		table14 = (var3 + var7) / var17
		v15 = (var8 - var6) / var17
	elseif v9 < var5 then
		local var18 = var11 * math.sqrt(1 - instance + var5 - v9)
		v12 = (var4 + v2) / var18
		var13 = var18 / 4
		table14 = (var8 + var6) / var18
		v15 = (var3 - var7) / var18
	else
		local var19 = var11 * math.sqrt(1 - instance - var5 + v9)
		v12 = (var3 + var7) / var19
		var13 = (var8 + var6) / var19
		table14 = var19 / 4
		v15 = (var4 - v2) / var19
	end
	return { v12, var13, table14, v15 }
end
function t.encode(p1)
	local instance = Bitbuf.new()
	local Position = p1.Position
	instance:WriteFloat(32, Position.X)
	instance:WriteFloat(32, Position.Y)
	instance:WriteFloat(32, Position.Z)
	local v2
	if isAxisAligned(p1) then
		local var3 = 6 * toNormalId(p1.RightVector) + toNormalId(p1.UpVector)
		v2 = if math.floor(var3 / 6) % 3 ~= var3 % 3 then var3 else -1
	else
		v2 = -1
	end
	instance:WriteByte(v2 + 1)
	if v2 < 0 then
		local var5 = encodeMatrix(p1)
		instance:WriteByte(#var5)
		for i, v in ipairs(var5) do
			instance:WriteFloat(32, v)
		end
	end
	return Base85.encode((instance:String()))
end
function t.decode(p1)
	local instance, v2 = Base85.decode(p1)
	if instance then
		assert(instance)
	end
	local var3 = Bitbuf.fromString(v2)
	local var4 = var3:ReadFloat(32)
	local var5 = var3:ReadFloat(32)
	local var6 = var3:ReadFloat(32)
	local var7 = var3:ReadByte()
	if var7 > 0 then
		local var8 = var7 - 1
		if math.floor(var8 / 6) % 3 ~= var8 % 3 then
			local var10 = Vector3.new(var4, var5, var6)
			local var11 = Vector3.FromNormalId(var8 / 6)
			return CFrame.fromMatrix(var10, var11, (Vector3.FromNormalId(var8 % 6)))
		else
			return CFrame.new(var4, var5, var6)
		end
	else
		local var13 = var3:ReadByte()
		local table14 = table.create(var13)
		for i = 1, var13 do
			table14[i] = var3:ReadFloat(32)
		end
		return CFrame.new(var4, var5, var6, unpack(table14))
	end
end
return t
