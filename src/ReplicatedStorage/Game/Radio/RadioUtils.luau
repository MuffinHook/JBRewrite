local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local t = {
	HasSteroGamepass = function() --[[ Name: HasSteroGamepass | Line: 7 | Upvalues: GamepassSystem (copy), GamepassUtils (copy) ]]
		return GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.Stereo)
	end
}
function t.CheckOrPromptStereoGamepass() --[[ Line: 10 | Upvalues: t (copy), GamepassUtils (copy), Settings (copy) ]]
	local v1 = t.HasSteroGamepass()
	if not v1 then
		GamepassUtils.PromptPurchase(Settings.Gamepass.Stereo)
	end
	return v1
end
return t