local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local module_upvr = {}
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
function module_upvr.HasSteroGamepass() -- Line 7
    return GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.Stereo)
end
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module_upvr.CheckOrPromptStereoGamepass() -- Line 10
    local any_HasSteroGamepass_result1 = module_upvr.HasSteroGamepass()
    if not any_HasSteroGamepass_result1 then
        GamepassUtils_upvr.PromptPurchase(Settings_upvr.Gamepass.Stereo)
    end
    return any_HasSteroGamepass_result1
end
return module_upvr