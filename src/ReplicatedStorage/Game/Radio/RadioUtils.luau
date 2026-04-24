-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local t = {
	HasSteroGamepass = function()
		return GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.Stereo)
	end
}
function t.CheckOrPromptStereoGamepass()
	local v1 = t.HasSteroGamepass()
	if not v1 then
		GamepassUtils.PromptPurchase(Settings.Gamepass.Stereo)
	end
	return v1
end
return t
