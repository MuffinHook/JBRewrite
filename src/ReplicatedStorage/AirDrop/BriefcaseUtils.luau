local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BriefcaseConsts = require(ReplicatedStorage.AirDrop.BriefcaseConsts)
local function getQuatBtwn(p1, p2, p3) --[[ Line: 7 ]]
	local v1 = p1:Dot(p2)
	local v2 = p1:Cross(p2)
	if v1 < -0.99999 then
		return CFrame.fromAxisAngle(p3, math.pi)
	else
		return CFrame.new(0, 0, 0, v2.x, v2.y, v2.z, 1 + v1)
	end
end
local t = {
	getOrigin = function(p1) --[[ Name: getOrigin | Line: 16 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.ORIGIN_ATTR_NAME)
	end,
	setOrigin = function(p1, p2) --[[ Name: setOrigin | Line: 19 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.ORIGIN_ATTR_NAME, p2)
	end,
	getTarget = function(p1) --[[ Name: getTarget | Line: 22 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.TARGET_ATTR_NAME)
	end,
	setTarget = function(p1, p2) --[[ Name: setTarget | Line: 25 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.TARGET_ATTR_NAME, p2)
	end,
	getTargetNormal = function(p1) --[[ Name: getTargetNormal | Line: 28 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.TARGET_NORMAL_ATTR_NAME)
	end,
	setTargetNormal = function(p1, p2) --[[ Name: setTargetNormal | Line: 31 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.TARGET_NORMAL_ATTR_NAME, p2)
	end,
	getCollected = function(p1) --[[ Name: getCollected | Line: 34 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.COLLECTED_ATTR_NAME)
	end,
	setCollected = function(p1, p2) --[[ Name: setCollected | Line: 37 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.COLLECTED_ATTR_NAME, p2)
	end,
	getCollectedChangedSignal = function(p1) --[[ Name: getCollectedChangedSignal | Line: 40 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttributeChangedSignal(BriefcaseConsts.COLLECTED_ATTR_NAME)
	end,
	getBornAt = function(p1) --[[ Name: getBornAt | Line: 43 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.BORN_AT_ATTR_NAME)
	end,
	setBornAt = function(p1, p2) --[[ Name: setBornAt | Line: 46 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.BORN_AT_ATTR_NAME, p2)
	end,
	getSpeed = function(p1) --[[ Name: getSpeed | Line: 49 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.SPEED_ATTR_NAME)
	end,
	setSpeed = function(p1, p2) --[[ Name: setSpeed | Line: 52 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.SPEED_ATTR_NAME, p2)
	end,
	getLanded = function(p1) --[[ Name: getLanded | Line: 55 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.LANDED_ATTR_NAME)
	end,
	setLanded = function(p1, p2) --[[ Name: setLanded | Line: 58 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.LANDED_ATTR_NAME, p2)
	end,
	getLandedTime = function(p1) --[[ Name: getLandedTime | Line: 61 | Upvalues: BriefcaseConsts (copy) ]]
		return p1:GetAttribute(BriefcaseConsts.BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME)
	end,
	setLandedTime = function(p1, p2) --[[ Name: setLandedTime | Line: 64 | Upvalues: BriefcaseConsts (copy) ]]
		p1:SetAttribute(BriefcaseConsts.BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME, p2)
	end,
	getRarityProbabilities = function(p1) --[[ Name: getRarityProbabilities | Line: 67 | Upvalues: BriefcaseConsts (copy) ]]
		local v1 = p1:FindFirstChild(BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME)
		assert(v1, "No rarity folder found")
		local t = {}
		for v2, v3 in v1:GetChildren() do
			t[v3.Name] = v3.Value
		end
		return t
	end
}
function t.getTimeSinceBriefcaseLanded(p1) --[[ Line: 78 | Upvalues: t (copy) ]]
	local v1 = t.getLandedTime(p1)
	assert(v1, "Briefcase hasn\'t landed yet but trying to collect reward")
	return workspace:GetServerTimeNow() - v1
end
function t.setBriefcaseActiveDurationStart(p1, p2) --[[ Line: 83 | Upvalues: BriefcaseConsts (copy) ]]
	p1:SetAttribute(BriefcaseConsts.BRIEFCASE_ACTIVE_DURATION_START, p2)
end
function t.getBriefcaseActiveDurationStart(p1) --[[ Line: 86 | Upvalues: BriefcaseConsts (copy) ]]
	return p1:GetAttribute(BriefcaseConsts.BRIEFCASE_ACTIVE_DURATION_START)
end
function t.getBriefcaseActiveDuration(p1) --[[ Line: 89 | Upvalues: t (copy) ]]
	if t.getBriefcaseActiveDurationStart(p1) then
		return workspace:GetServerTimeNow() - t.getBriefcaseActiveDurationStart(p1)
	else
		return nil
	end
end
function t.setRarityProbabilities(p1, p2) --[[ Line: 95 | Upvalues: BriefcaseConsts (copy) ]]
	if typeof(p2) ~= "table" then
		print(p2)
		error("Invalid rarityProbs given")
	end
	local v1 = p1:FindFirstChild(BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME)
	if not v1 then
		local v2 = Instance.new("Folder")
		v2.Name = BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME
		v2.Parent = p1
		v1 = v2
	end
	for v3, v4 in p2 do
		local v5 = v1:FindFirstChild(v3)
		if not v5 then
			local v6 = Instance.new("NumberValue")
			v6.Name = v3
			v6.Parent = v1
			v5 = v6
		end
		v5.Value = v4
	end
	for v7, v8 in v1:GetChildren() do
		if not p2[tonumber(v8.Name)] then
			v8:Destroy()
		end
	end
	return true
end
function t.getLandedChangedSignal(p1) --[[ Line: 127 | Upvalues: BriefcaseConsts (copy) ]]
	return p1:GetAttributeChangedSignal(BriefcaseConsts.LANDED_ATTR_NAME)
end
function t.getOpenDuration(p1) --[[ Line: 130 | Upvalues: BriefcaseConsts (copy) ]]
	return p1:GetAttribute(BriefcaseConsts.OPEN_DURATION_ATTRIBUTE_NAME)
end
function t.setOpenDuration(p1, p2) --[[ Line: 133 | Upvalues: BriefcaseConsts (copy) ]]
	p1:SetAttribute(BriefcaseConsts.OPEN_DURATION_ATTRIBUTE_NAME, p2)
	return true
end
function t.getPositionAt(p1, p2, p3, p4) --[[ Line: 137 ]]
	if p4 < p1 then
		p1 = p4
	end
	return p2 + (p3 - p2) * (p1 / p4)
end
function t.getCFrameAt(p1, p2, p3, p4, p5) --[[ Line: 146 | Upvalues: getQuatBtwn (copy) ]]
	if p5 < p1 then
		p1 = p5
	end
	local v2 = p1 % 6.283185307179586
	local v3 = if p5 - 1 < p1 then (p1 - p5) / 1 + 1 else 0
	local v4 = v3 * v3
	return getQuatBtwn(Vector3.new(0, 1, 0), (Vector3.new(0, 1, 0)):lerp(p4, v4), Vector3.new(0, 0, 1)) * CFrame.Angles(math.cos(v2) * 0.2 * (1 - v4), v2, math.sin(v2) * 0.2 * (1 - v4)) + p2 + (p3 - p2) * (p1 / p5)
end
function t.setLastEPress(p1, p2) --[[ Line: 171 | Upvalues: BriefcaseConsts (copy) ]]
	p1:SetAttribute(BriefcaseConsts.LAST_E_PRESS_ATTR_NAME, p2)
	return true
end
function t.getLastEPress(p1) --[[ Line: 175 | Upvalues: BriefcaseConsts (copy) ]]
	return p1:GetAttribute(BriefcaseConsts.LAST_E_PRESS_ATTR_NAME)
end
function t.setIsCurrentlyEPressed(p1, p2) --[[ Line: 178 | Upvalues: BriefcaseConsts (copy) ]]
	p1:SetAttribute(BriefcaseConsts.IS_CURRENTLY_E_PRESSED_ATTR_NAME, p2)
	return true
end
function t.getIsCurrentlyEPressed(p1) --[[ Line: 182 | Upvalues: BriefcaseConsts (copy) ]]
	return p1:GetAttribute(BriefcaseConsts.IS_CURRENTLY_E_PRESSED_ATTR_NAME)
end
return t