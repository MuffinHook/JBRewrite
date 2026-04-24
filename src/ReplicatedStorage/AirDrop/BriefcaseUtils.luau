-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BriefcaseConsts = require(ReplicatedStorage.AirDrop.BriefcaseConsts)
local function getQuaternionBetween(upVector, targetVector, refVector)
	local dotProduct = upVector:Dot(targetVector)
	local crossProduct = upVector:Cross(targetVector)
	if dotProduct < -0.99999 then
		return CFrame.fromAxisAngle(refVector, math.pi)
	else
		return CFrame.new(0, 0, 0, crossProduct.x, crossProduct.y, crossProduct.z, 1 + dotProduct)
	end
end
local BriefcaseUtilsModule = {
	getOrigin = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.ORIGIN_ATTR_NAME)
	end,
	setOrigin = function(briefcase, origin)
		briefcase:SetAttribute(BriefcaseConsts.ORIGIN_ATTR_NAME, origin)
	end,
	getTarget = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.TARGET_ATTR_NAME)
	end,
	setTarget = function(briefcase, target)
		briefcase:SetAttribute(BriefcaseConsts.TARGET_ATTR_NAME, target)
	end,
	getTargetNormal = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.TARGET_NORMAL_ATTR_NAME)
	end,
	setTargetNormal = function(briefcase, targetNormal)
		briefcase:SetAttribute(BriefcaseConsts.TARGET_NORMAL_ATTR_NAME, targetNormal)
	end,
	getCollected = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.COLLECTED_ATTR_NAME)
	end,
	setCollected = function(briefcase, collected)
		briefcase:SetAttribute(BriefcaseConsts.COLLECTED_ATTR_NAME, collected)
	end,
	getCollectedChangedSignal = function(briefcase)
		return briefcase:GetAttributeChangedSignal(BriefcaseConsts.COLLECTED_ATTR_NAME)
	end,
	getBornAt = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.BORN_AT_ATTR_NAME)
	end,
	setBornAt = function(briefcase, bornAt)
		briefcase:SetAttribute(BriefcaseConsts.BORN_AT_ATTR_NAME, bornAt)
	end,
	getSpeed = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.SPEED_ATTR_NAME)
	end,
	setSpeed = function(briefcase, speed)
		briefcase:SetAttribute(BriefcaseConsts.SPEED_ATTR_NAME, speed)
	end,
	getLanded = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.LANDED_ATTR_NAME)
	end,
	setLanded = function(briefcase, landed)
		briefcase:SetAttribute(BriefcaseConsts.LANDED_ATTR_NAME, landed)
	end,
	getLandedTime = function(briefcase)
		return briefcase:GetAttribute(BriefcaseConsts.BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME)
	end,
	setLandedTime = function(briefcase, landedTime)
		briefcase:SetAttribute(BriefcaseConsts.BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME, landedTime)
	end,
	getRarityProbabilities = function(briefcase)
		local rarityFolder = briefcase:FindFirstChild(BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME)
		assert(rarityFolder, "No rarity folder found")
		local rarityProbs = {}
		for index, rarityValue in rarityFolder:GetChildren() do
			rarityProbs[rarityValue.Name] = rarityValue.Value
		end
		return rarityProbs
	end
}
function BriefcaseUtilsModule.getTimeSinceBriefcaseLanded(briefcase)
	local landedTime = BriefcaseUtilsModule.getLandedTime(briefcase)
	assert(landedTime, "Briefcase hasn't landed yet but trying to collect reward")
	return workspace:GetServerTimeNow() - landedTime
end
function BriefcaseUtilsModule.setBriefcaseActiveDurationStart(briefcase, startTime)
	briefcase:SetAttribute(BriefcaseConsts.BRIEFCASE_ACTIVE_DURATION_START, startTime)
end
function BriefcaseUtilsModule.getBriefcaseActiveDurationStart(briefcase)
	return briefcase:GetAttribute(BriefcaseConsts.BRIEFCASE_ACTIVE_DURATION_START)
end
function BriefcaseUtilsModule.getBriefcaseActiveDuration(briefcase)
	if BriefcaseUtilsModule.getBriefcaseActiveDurationStart(briefcase) then
		return workspace:GetServerTimeNow() - BriefcaseUtilsModule.getBriefcaseActiveDurationStart(briefcase)
	else
		return nil
	end
end
function BriefcaseUtilsModule.setRarityProbabilities(briefcase, rarityProbs)
	if typeof(rarityProbs) ~= "table" then
		print(rarityProbs)
		error("Invalid rarityProbs given")
	end
	local rarityFolder = briefcase:FindFirstChild(BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME)
	if not rarityFolder then
		local newFolder = Instance.new("Folder")
		newFolder.Name = BriefcaseConsts.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME
		newFolder.Parent = briefcase
		rarityFolder = newFolder
	end
	for rarityId, probability in rarityProbs do
		local rarityValue = rarityFolder:FindFirstChild(rarityId)
		if not rarityValue then
			local newRarityValue = Instance.new("NumberValue")
			newRarityValue.Name = rarityId
			newRarityValue.Parent = rarityFolder
			rarityValue = newRarityValue
		end
		rarityValue.Value = probability
	end
	for index, childValue in rarityFolder:GetChildren() do
		if not rarityProbs[tonumber(childValue.Name)] then
			childValue:Destroy()
		end
	end
	return true
end
function BriefcaseUtilsModule.getLandedChangedSignal(briefcase)
	return briefcase:GetAttributeChangedSignal(BriefcaseConsts.LANDED_ATTR_NAME)
end
function BriefcaseUtilsModule.getOpenDuration(briefcase)
	return briefcase:GetAttribute(BriefcaseConsts.OPEN_DURATION_ATTRIBUTE_NAME)
end
function BriefcaseUtilsModule.setOpenDuration(briefcase, duration)
	briefcase:SetAttribute(BriefcaseConsts.OPEN_DURATION_ATTRIBUTE_NAME, duration)
	return true
end
function BriefcaseUtilsModule.getPositionAt(elapsedTime, origin, target, totalDuration)
	if totalDuration < elapsedTime then
		elapsedTime = totalDuration
	end
	return origin + (target - origin) * (elapsedTime / totalDuration)
end
function BriefcaseUtilsModule.getCFrameAt(elapsedTime, origin, target, targetNormal, totalDuration)
	if totalDuration < elapsedTime then
		elapsedTime = totalDuration
	end
	local rotationPhase = elapsedTime % 6.283185307179586
	local landingProgress = if totalDuration - 1 < elapsedTime then (elapsedTime - totalDuration) / 1 + 1 else 0
	local landingProgressSquared = landingProgress * landingProgress
	return getQuaternionBetween(Vector3.new(0, 1, 0), (Vector3.new(0, 1, 0)):lerp(targetNormal, landingProgressSquared), Vector3.new(0, 0, 1)) * CFrame.Angles(math.cos(rotationPhase) * 0.2 * (1 - landingProgressSquared), rotationPhase, math.sin(rotationPhase) * 0.2 * (1 - landingProgressSquared)) + origin + (target - origin) * (elapsedTime / totalDuration)
end
function BriefcaseUtilsModule.setLastEPress(briefcase, pressTime)
	briefcase:SetAttribute(BriefcaseConsts.LAST_E_PRESS_ATTR_NAME, pressTime)
	return true
end
function BriefcaseUtilsModule.getLastEPress(briefcase)
	return briefcase:GetAttribute(BriefcaseConsts.LAST_E_PRESS_ATTR_NAME)
end
function BriefcaseUtilsModule.setIsCurrentlyEPressed(briefcase, isPressed)
	briefcase:SetAttribute(BriefcaseConsts.IS_CURRENTLY_E_PRESSED_ATTR_NAME, isPressed)
	return true
end
function BriefcaseUtilsModule.getIsCurrentlyEPressed(briefcase)
	return briefcase:GetAttribute(BriefcaseConsts.IS_CURRENTLY_E_PRESSED_ATTR_NAME)
end
return BriefcaseUtilsModule
