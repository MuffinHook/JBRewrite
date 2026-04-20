local AdoptionStandConsts_upvr = require(script.Parent.AdoptionStandConsts)
local module_upvr = {}
local var3_upvw
local waitForChild_upvr = require(game:GetService("ReplicatedStorage").Std.waitForChild)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.init() -- Line 10
    var3_upvw = require(script.Parent.AdoptionStandBinder)
    var3_upvw:Start()
    waitForChild_upvr(LocalPlayer_upvr.PlayerGui, AdoptionStandConsts_upvr.DOGS_OWNED_VALUE_NAME):andThen(function(arg1) -- Line 15
        module_upvr._dogsOwnedValue = arg1
    end):catch(warn)
end
function module_upvr.getDogName(arg1) -- Line 25
    if not module_upvr._dogsOwnedValue then return end
    local SOME = module_upvr._dogsOwnedValue:FindFirstChild(arg1)
    if not SOME then return end
    return SOME:FindFirstChild(AdoptionStandConsts_upvr.DOG_NAME_VALUE_NAME).Value
end
function module_upvr.doesOwn(arg1) -- Line 36
    local var8
    if not var8 then return end
    if module_upvr._dogsOwnedValue:FindFirstChild(arg1) == nil then
        var8 = false
    else
        var8 = true
    end
    return var8
end
return module_upvr