local module = {}
local Bitbuf = require(script.Parent.Bitbuf)
local Base85 = require(script.Parent.Base85)
local function isAxisAligned(cframe)
	local components = { cframe:GetComponents() }
	local zeroCount = 0
	local oneCount = 0
	for i = 4, 12 do
		local componentValue = math.abs(components[i])
		if componentValue == 1 then
			oneCount = oneCount + 1
		elseif componentValue == 0 then
			zeroCount = zeroCount + 1
		end
	end
	return if zeroCount == 6 then oneCount == 3 else false
end
local function toNormalId(vector)
	for i, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
		if Vector3.FromNormalId(normalId):Dot(vector) == 1 then
			return normalId.Value
		end
	end
	return -1
end
local function isLegalOrientId(orientationId)
	return math.floor(orientationId / 6) % 3 ~= orientationId % 3
end
local function getOrientId(cframe)
	if isAxisAligned(cframe) then
		local orientId = 6 * toNormalId(cframe.RightVector) + toNormalId(cframe.UpVector)
		if math.floor(orientId / 6) % 3 ~= orientId % 3 then
			return orientId
		else
			return -1
		end
	else
		return -1
	end
end
local function encodeMatrix(cframe)
	local m11, m12, m21, m22, m31, m32, m13, m23, m33 = select(4, cframe:GetComponents())
	local trace = m11 + m31 + m33
	local two = 2
	local qx, qy, qz, qw
	if trace > 0 then
		local sqrtTrace = two * math.sqrt(1 + trace)
		qx = (m23 - m32) / sqrtTrace
		qy = (m21 - m13) / sqrtTrace
		qz = (m12 - m21) / sqrtTrace
		qw = sqrtTrace / 4
	elseif m31 < m11 and m33 < m11 then
		local sqrtTrace = two * math.sqrt(1 + m11 - m31 - m33)
		qx = sqrtTrace / 4
		qy = (m12 + m21) / sqrtTrace
		qz = (m21 + m13) / sqrtTrace
		qw = (m23 - m32) / sqrtTrace
	elseif m33 < m31 then
		local sqrtTrace = two * math.sqrt(1 - m11 + m31 - m33)
		qx = (m12 + m21) / sqrtTrace
		qy = sqrtTrace / 4
		qz = (m23 + m32) / sqrtTrace
		qw = (m21 - m13) / sqrtTrace
	else
		local sqrtTrace = two * math.sqrt(1 - m11 - m31 + m33)
		qx = (m21 + m13) / sqrtTrace
		qy = (m23 + m32) / sqrtTrace
		qz = sqrtTrace / 4
		qw = (m12 - m21) / sqrtTrace
	end
	return { qx, qy, qz, qw }
end
function module.encode(cframe)
	local bitBuffer = Bitbuf.new()
	local Position = cframe.Position
	bitBuffer:WriteFloat(32, Position.X)
	bitBuffer:WriteFloat(32, Position.Y)
	bitBuffer:WriteFloat(32, Position.Z)
	local orientationId
	if isAxisAligned(cframe) then
		local orientId = 6 * toNormalId(cframe.RightVector) + toNormalId(cframe.UpVector)
		orientationId = if math.floor(orientId / 6) % 3 ~= orientId % 3 then orientId else -1
	else
		orientationId = -1
	end
	bitBuffer:WriteByte(orientationId + 1)
	if orientationId < 0 then
		local quaternion = encodeMatrix(cframe)
		bitBuffer:WriteByte(#quaternion)
		for i, quaternionValue in ipairs(quaternion) do
			bitBuffer:WriteFloat(32, quaternionValue)
		end
	end
	return Base85.encode((bitBuffer:String()))
end
function module.decode(encodedData)
	local success, decodedString = Base85.decode(encodedData)
	if success then
		assert(success)
	end
	local bitBuffer = Bitbuf.fromString(decodedString)
	local posX = bitBuffer:ReadFloat(32)
	local posY = bitBuffer:ReadFloat(32)
	local posZ = bitBuffer:ReadFloat(32)
	local orientId = bitBuffer:ReadByte()
	if orientId > 0 then
		local normalIdValue = orientId - 1
		if math.floor(normalIdValue / 6) % 3 ~= normalIdValue % 3 then
			local position = Vector3.new(posX, posY, posZ)
			local rightVector = Vector3.FromNormalId(normalIdValue / 6)
			return CFrame.fromMatrix(position, rightVector, (Vector3.FromNormalId(normalIdValue % 6)))
		else
			return CFrame.new(posX, posY, posZ)
		end
	else
		local componentCount = bitBuffer:ReadByte()
		local quaternionComponents = table.create(componentCount)
		for i = 1, componentCount do
			quaternionComponents[i] = bitBuffer:ReadFloat(32)
		end
		return CFrame.new(posX, posY, posZ, unpack(quaternionComponents))
	end
end
return module
