local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HomeItemConsts_upvr = require(script.Parent.HomeItemConsts)
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
module_2_upvr.__ClassName = "HomeItem"
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Fabricate_upvr = script.Parent.Fabricate
function module_2_upvr.new(arg1) -- Line 17
    local module = {}
    setmetatable(module, module_2_upvr)
    RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
    module._maid = Maid_upvr.new()
    module._obj = arg1
    module._placeRemote = arg1:WaitForChild(HomeItemConsts_upvr.PLACE_REMOTE_NAME)
    module._deleteRemote = arg1:WaitForChild(HomeItemConsts_upvr.DELETE_REMOTE_NAME)
    module._ownerIdValue = arg1:WaitForChild(HomeItemConsts_upvr.OWNER_ID_VALUE_NAME)
    module._upDotValue = arg1:WaitForChild(HomeItemConsts_upvr.UP_DOT_VALUE_NAME)
    module._isPlacedValue = arg1:WaitForChild(HomeItemConsts_upvr.IS_PLACED_VALUE_NAME)
    module._isGhostValue = arg1:WaitForChild(HomeItemConsts_upvr.IS_GHOST_VALUE_NAME)
    module._damageRemote = nil
    module._isBeingDragged = false
    module._offsetCF = CFrame.new(0, -arg1.PrimaryPart.Size.Y * 0.5, 0):Inverse()
    local SOME = Fabricate_upvr:FindFirstChild(module._obj.Name)
    if SOME then
        require(SOME).setup(module)
    end
    return module
end
local HomeBinder_upvr = require(script.Parent.Parent.HomeBinder)
function module_2_upvr.GetHome(arg1) -- Line 45
    return HomeBinder_upvr:Get(arg1._obj.Parent)
end
local Players_upvr = game:GetService("Players")
function module_2_upvr.GetOwner(arg1) -- Line 48
    return Players_upvr:GetPlayerByUserId(arg1._ownerIdValue.Value)
end
function module_2_upvr.GetObj(arg1) -- Line 53
    return arg1._obj
end
function module_2_upvr.TranslateCf(arg1, arg2) -- Line 56
    return arg2 * arg1._offsetCF
end
function module_2_upvr.UntranslateCf(arg1, arg2) -- Line 59
    return arg2 * arg1._offsetCF:Inverse()
end
function module_2_upvr.SetCFrame(arg1, arg2) -- Line 62
    arg1._obj:SetPrimaryPartCFrame(arg2)
end
function module_2_upvr.SetServerCFrame(arg1, arg2) -- Line 65
    arg1._placeRemote:FireServer(arg2)
end
function module_2_upvr.CacheSurfaces(arg1) -- Line 68
    local any_GetHome_result1 = arg1:GetHome()
    local var12
    if any_GetHome_result1 == nil then
        var12 = false
    else
        var12 = true
    end
    assert(var12)
    arg1._cacheSurfaces = any_GetHome_result1:GetSurfaces()
end
function module_2_upvr.ClearCacheSurfaces(arg1) -- Line 73
    arg1._cacheSurfaces = nil
end
local HomeItemUtils_upvr = require(script.Parent.HomeItemUtils)
function module_2_upvr.IsWithinBoundsCached(arg1, arg2) -- Line 76
    return HomeItemUtils_upvr.isWithinBounds(arg1._obj.PrimaryPart, arg2, arg1._cacheSurfaces)
end
function module_2_upvr.IsValidUpDot(arg1, arg2) -- Line 79
    local var14
    if math.abs(arg2 - arg1._upDotValue.Value) >= 0.1 then
        var14 = false
    else
        var14 = true
    end
    return var14
end
function module_2_upvr.AttemptDelete(arg1) -- Line 82
    arg1._deleteRemote:FireServer()
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_2_upvr.Damage(arg1) -- Line 85
    if not arg1._damageRemote then
        arg1._damageRemote = arg1._obj:FindFirstChild(HomeItemConsts_upvr.DAMAGE_REMOTE_NAME)
    end
    if arg1._damageRemote then
        arg1._damageRemote:FireServer()
        Audio_upvr.ObjectLocal(arg1._obj.PrimaryPart, 2837091387, {
            Volume = 1;
        })
    end
end
function module_2_upvr.SetBeingDragged(arg1, arg2) -- Line 94
    arg1._isBeingDragged = arg2
end
function module_2_upvr.IsBeingDragged(arg1) -- Line 97
    return arg1._isBeingDragged
end
function module_2_upvr.GetGhosted(arg1) -- Line 100
    return arg1._isGhostValue.Value
end
function module_2_upvr.IsPlaced(arg1) -- Line 103
    return arg1._isPlacedValue.Value
end
function module_2_upvr.Destroy(arg1) -- Line 106
    local _maid = arg1._maid
    local var18
    if _maid == nil then
        var18 = false
    else
        var18 = true
    end
    assert(var18)
    arg1._maid = nil
    _maid:Destroy()
end
return module_2_upvr