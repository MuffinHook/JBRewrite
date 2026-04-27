local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local Format = require(ReplicatedStorage.Module.Format)
local module = {}
local previousMilestoneId = nil
local effectCallback = nil
local function getMilestoneId(cash)
	if cash >= 1000000 then
		return math.floor(cash / 1000000)
	elseif cash >= 500000 then
		return 0.5
	elseif cash >= 100000 then
		return 0.1
	else
		return 0
	end
end
function module.init(callback)
	effectCallback = callback
end
local function playEffect(milestoneValue)
	if effectCallback then
		task.spawn(effectCallback, 12)
	end
	Notification.new({
		Text = string.format("You reached %s\nCongratulations!", (Format.Currency(milestoneValue * 1000000))),
		Style = "Gift"
	})
end
function module.cashUpdate(cash)
	if previousMilestoneId == nil then
		previousMilestoneId = if cash >= 1000000 then math.floor(cash / 1000000) elseif cash >= 500000 then 0.5 elseif cash >= 100000 then 0.1 else 0
	else
		local currentMilestoneId = if cash >= 1000000 then math.floor(cash / 1000000) elseif cash >= 500000 then 0.5 elseif cash >= 100000 then 0.1 else 0
		if previousMilestoneId < currentMilestoneId then
			previousMilestoneId = currentMilestoneId
			playEffect(currentMilestoneId)
		end
	end
end
return module
