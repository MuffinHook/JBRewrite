local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryItemConsts_upvr = require(script.Parent.InventoryItemConsts)
local InventoryItemUtils_upvr = require(script.Parent.InventoryItemUtils)
local InventoryItemOwnerBinder_upvr = require(script.Parent.InventoryItemOwnerBinder)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr_2.new(arg1) -- Line 14
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr.obj = arg1
    module_upvr._maid = Maid_upvr.new()
    module_upvr.onAttemptSelect = Signal_upvr.new()
    module_upvr._maid:GiveTask(module_upvr.onAttemptSelect)
    module_upvr.onAttemptDrop = Signal_upvr.new()
    module_upvr._maid:GiveTask(module_upvr.onAttemptDrop)
    module_upvr._maid:GiveTask(function() -- Line 25
        InventoryItemUtils_upvr.setEquipped(module_upvr.obj, false)
    end)
    module_upvr._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, InventoryItemConsts_upvr.EQUIP_REMOTE_NAME, function(arg1_2, arg2) -- Line 34
        arg2:GiveTask(arg1_2.OnClientEvent:Connect(function() -- Line 35
            module_upvr:AttemptSelect()
        end))
    end))
    module_upvr._maid:GiveTask(arg1:GetAttributeChangedSignal(InventoryItemConsts_upvr.EQUIPPED_ATTR_NAME):Connect(function() -- Line 42, Named "update"
        local var13 = arg1:GetAttribute(InventoryItemConsts_upvr.EQUIPPED_ATTR_NAME) or 0
        if (arg1:GetAttribute(InventoryItemConsts_upvr.EQUIPPED_LOCAL_ATTR_NAME) or 0) < var13 then
            arg1:SetAttribute(InventoryItemConsts_upvr.EQUIPPED_LOCAL_ATTR_NAME, var13)
        end
    end))
    local var14 = arg1:GetAttribute(InventoryItemConsts_upvr.EQUIPPED_ATTR_NAME) or 0
    if (arg1:GetAttribute(InventoryItemConsts_upvr.EQUIPPED_LOCAL_ATTR_NAME) or 0) < var14 then
        arg1:SetAttribute(InventoryItemConsts_upvr.EQUIPPED_LOCAL_ATTR_NAME, var14)
    end
    module_upvr._overriddenOwner = nil
    return module_upvr
end
function module_upvr_2.GetName(arg1) -- Line 56
    return InventoryItemUtils_upvr.getName(arg1.obj)
end
function module_upvr_2.GetOwner(arg1) -- Line 59
    local Parent = arg1.obj.Parent.Parent
    if not Parent then
    else
        local any_Get_result1 = InventoryItemOwnerBinder_upvr:Get(Parent)
        if any_Get_result1 then
            return any_Get_result1
        end
        if Parent.Parent == game:GetService("Players") then
            return Parent
        end
    end
end
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
function module_upvr_2.PromiseOwner(arg1) -- Line 74
    local Parent_2 = arg1.obj.Parent.Parent
    if not Parent_2 then return end
    if Parent_2.Parent == game:GetService("Players") then
        return Promise_upvr.resolve(Parent_2)
    end
    return InventoryItemOwnerBinder_upvr:Promise(Parent_2)
end
function module_upvr_2.GetAttr(arg1, ...) -- Line 84
    return InventoryItemUtils_upvr.getAttr(arg1.obj, ...)
end
function module_upvr_2.SetAttr(arg1, ...) -- Line 87
    InventoryItemUtils_upvr.setAttr(arg1.obj, ...)
end
function module_upvr_2.GetEquipped(arg1, ...) -- Line 90
    return InventoryItemUtils_upvr.getEquipped(arg1.obj, ...)
end
function module_upvr_2.SetEquipped(arg1, ...) -- Line 93
    InventoryItemUtils_upvr.setEquipped(arg1.obj, ...)
end
function module_upvr_2.GetEquippedSignal(arg1) -- Line 96
    return InventoryItemUtils_upvr.getEquippedSignal(arg1.obj)
end
function module_upvr_2.AttemptSetEquipped(arg1, arg2) -- Line 99
    if arg2 == nil then
    else
    end
    assert(true, "missing value")
    InventoryItemUtils_upvr.setEquipped(arg1.obj, arg2)
    arg1.obj:FindFirstChild(InventoryItemConsts_upvr.EQUIP_REMOTE_NAME):FireServer(arg2)
end
function module_upvr_2.AttemptSelect(arg1) -- Line 105
    arg1.onAttemptSelect:Fire()
end
function module_upvr_2.AttemptDrop(arg1) -- Line 108
    arg1.onAttemptDrop:Fire()
end
function module_upvr_2.Destroy(arg1) -- Line 111
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr_2