local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
module_upvr_2.__ClassName = "OwnedPart"
local OwnedPartConsts_upvr = require(script.Parent.OwnedPartConsts)
function module_upvr_2.new(arg1) -- Line 12
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr._maid = Maid_upvr.new()
    module_upvr._obj = arg1
    module_upvr._networkOwnerIdValue = arg1:WaitForChild(OwnedPartConsts_upvr.NETWORK_OWNER_ID_VALUE_NAME)
    module_upvr._maid:GiveTask(module_upvr._networkOwnerIdValue.Changed:Connect(function() -- Line 19
        module_upvr:_onOwnerChanged()
    end))
    module_upvr._onOwned = Signal_upvr.new()
    return module_upvr
end
function module_upvr_2.GetOnOwnedSignal(arg1) -- Line 26
    local _onOwned = arg1._onOwned
    if not _onOwned then
        _onOwned = Signal_upvr.new()
        arg1._onOwned = _onOwned
    end
    return _onOwned
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
function module_upvr_2._onOwnerChanged(arg1) -- Line 34
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1._onOwned:Fire(arg1._maid.ownerMaid)
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1._maid.ownerMaid = nil
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr_2.GetOwner(arg1) -- Line 45
    return Players_upvr:GetPlayerByUserId(arg1._networkOwnerIdValue.Value)
end
function module_upvr_2.Destroy(arg1) -- Line 50
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr_2