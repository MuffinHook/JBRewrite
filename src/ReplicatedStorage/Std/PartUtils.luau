local PartUtils = {}
function PartUtils.setAnchored(rootPart, isAnchored)
	return PartUtils.setProperty(rootPart, "Anchored", isAnchored)
end
function PartUtils.setCanCollide(rootPart, canCollide)
	return PartUtils.setProperty(rootPart, "CanCollide", canCollide)
end
function PartUtils.setCanQuery(rootPart, canQuery)
	return PartUtils.setProperty(rootPart, "CanQuery", canQuery)
end
function PartUtils.setCanTouch(rootPart, canTouch)
	return PartUtils.setProperty(rootPart, "CanTouch", canTouch)
end
function PartUtils.setProperty(rootPart, propertyName, propertyValue)
	assert(rootPart ~= nil, "missing root")
	if rootPart:IsA("BasePart") then
		rootPart[propertyName] = propertyValue
	end
	for i, descendantPart in ipairs(rootPart:GetDescendants()) do
		if descendantPart:IsA("BasePart") then
			descendantPart[propertyName] = propertyValue
		end
	end
end
local UNSET_SENTINEL = {}
function PartUtils.setPropertyWithRollback(rootPart, propertyName, propertyValue)
	local rollbackTable = {}
	if rootPart:IsA("BasePart") then
		rollbackTable[rootPart] = if rootPart[propertyName] == nil then UNSET_SENTINEL else rootPart[propertyName]
		rootPart[propertyName] = propertyValue
	end
	for i, descendantPart in ipairs(rootPart:GetDescendants()) do
		local previousValue
		if descendantPart:IsA("BasePart") then
			previousValue = if descendantPart[propertyName] == nil then UNSET_SENTINEL else descendantPart[propertyName]
			rollbackTable[descendantPart] = previousValue
			descendantPart[propertyName] = propertyValue
		end
	end
	return function()
		for part, previousValue in rollbackTable do
			if previousValue == UNSET_SENTINEL then
				part[propertyName] = nil
			else
				part[propertyName] = previousValue
			end
		end
	end
end
return PartUtils
