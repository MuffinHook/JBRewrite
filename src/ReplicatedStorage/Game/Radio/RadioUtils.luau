local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local RadioUtils = {
	HasSteroGamepass = function()
		return GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.Stereo)
	end
}
function RadioUtils.CheckOrPromptStereoGamepass()
	local hasStereoGamepass = RadioUtils.HasSteroGamepass()
	if not hasStereoGamepass then
		GamepassUtils.PromptPurchase(Settings.Gamepass.Stereo)
	end
	return hasStereoGamepass
end
return RadioUtils
