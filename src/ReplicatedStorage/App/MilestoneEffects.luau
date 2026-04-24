-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local Format = require(ReplicatedStorage.Module.Format)
local module = {}
local v1 = nil
local v2 = nil
local function getMilestoneId(p1)
	if p1 >= 1000000 then
		return math.floor(p1 / 1000000)
	elseif p1 >= 500000 then
		return 0.5
	elseif p1 >= 100000 then
		return 0.1
	else
		return 0
	end
end
function module.init(p1)
	v2 = p1
end
local function playEffect(p1)
	if v2 then
		task.spawn(v2, 12)
	end
	Notification.new({
		Text = string.format("You reached %s\nCongratulations!", (Format.Currency(p1 * 1000000))),
		Style = "Gift"
	})
end
function module.cashUpdate(p1)
	if v1 == nil then
		v1 = if p1 >= 1000000 then math.floor(p1 / 1000000) elseif p1 >= 500000 then 0.5 elseif p1 >= 100000 then 0.1 else 0
	else
		local v2 = if p1 >= 1000000 then math.floor(p1 / 1000000) elseif p1 >= 500000 then 0.5 elseif p1 >= 100000 then 0.1 else 0
		if v1 < v2 then
			v1 = v2
			playEffect(v2)
		end
	end
end
return module