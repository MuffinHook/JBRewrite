local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local InventoryItemBinder_upvr = require(script.Parent.InventoryItemBinder)
local InventoryItemUtils_upvr = require(script.Parent.InventoryItemUtils)
local module_upvr = {
    onInventoryItemEquipped = Signal.new();
    onInventoryItemUnequipped = Signal.new();
    _equipConditions = {};
    _unequipConditions = {};
}
local InventoryItemOwnerBinder_upvr = require(script.Parent.InventoryItemOwnerBinder)
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr.init() -- Line 16
    InventoryItemBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 17, Named "handleInventoryItemAdded"
        local var10_upvw
        local function handleEquipped() -- Line 19
            local var11 = true
            if not arg1:GetOwner() then
                var11 = false
            end
            local any_getEquipped_result1 = InventoryItemUtils_upvr.getEquipped(arg1.obj)
            if not var11 then
            else
                if any_getEquipped_result1 == var10_upvw then return end
                var10_upvw = any_getEquipped_result1
                if any_getEquipped_result1 then
                    module_upvr.onInventoryItemEquipped:Fire(arg1)
                    return
                end
                module_upvr.onInventoryItemUnequipped:Fire(arg1)
            end
        end
        handleEquipped()
        arg1._maid:GiveTask(InventoryItemUtils_upvr.getEquippedSignal(arg1.obj):Connect(handleEquipped))
        if not arg1:GetOwner() then
            arg1._maid:GivePromise(arg1:PromiseOwner():andThen(handleEquipped))
        end
    end)
    InventoryItemBinder_upvr:GetClassRemovingSignal():Connect(function(arg1) -- Line 50, Named "handleInventoryItemRemoved"
        if InventoryItemUtils_upvr.getEquipped(arg1.obj) then
            module_upvr.onInventoryItemUnequipped:Fire(arg1)
        end
    end)
    InventoryItemBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 60
        arg1._maid:GiveTask(arg1.onAttemptSelect:Connect(function() -- Line 61
            if not module_upvr.unequipAll() then
            elseif not InventoryItemUtils_upvr.getEquipped(arg1.obj) then
                module_upvr.toggleEquip(arg1)
            end
        end))
    end)
    InventoryItemBinder_upvr:Start()
    InventoryItemOwnerBinder_upvr:Start()
    module_upvr.addUnequipCondition(function(arg1) -- Line 77
        if InventoryItemUtils_upvr.getLocked(arg1.obj) then
            return false
        end
        return true
    end)
    UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 84
        if arg2 then
        elseif arg1.UserInputType == Enum.UserInputType.Keyboard and arg1.KeyCode == Enum.KeyCode.Backspace then
            for _, v_6 in ipairs(module_upvr.getEquippedFor(Players_upvr.LocalPlayer)) do
                v_6:AttemptDrop()
            end
        end
    end)
end
function module_upvr.addEquipCondition(arg1) -- Line 98
    table.insert(module_upvr._equipConditions, arg1)
end
function module_upvr.addUnequipCondition(arg1) -- Line 101
    table.insert(module_upvr._unequipConditions, arg1)
end
function module_upvr.unequipAll() -- Line 104
    for _, v in ipairs(module_upvr.getInventoryItemsFor(Players_upvr.LocalPlayer)) do
        if InventoryItemUtils_upvr.getEquipped(v.obj) then
            for _, v_2 in ipairs(module_upvr._unequipConditions) do
                if not v_2(v) then
                    return false
                end
            end
            v:AttemptSetEquipped(false)
        end
    end
    return true
end
function module_upvr.toggleEquip(arg1) -- Line 119
    if not InventoryItemUtils_upvr.getEquipped(arg1.obj) then
        for _, v_3 in ipairs(module_upvr._equipConditions) do
            if not v_3(arg1) then return end
        end
        arg1:AttemptSetEquipped(true)
    else
        for _, v_4 in ipairs(module_upvr._unequipConditions) do
            if not v_4(arg1) then return end
        end
        arg1:AttemptSetEquipped(false)
    end
    return true
end
function module_upvr.getInventoryItemsFor(arg1) -- Line 139
    return TableUtils_upvr.filter(InventoryItemBinder_upvr:GetAll(), function(arg1_2) -- Line 140
        local var43
        if arg1_2:GetOwner() ~= arg1 then
            var43 = false
        else
            var43 = true
        end
        return var43
    end)
end
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
function module_upvr.getInventoryItemsOfInventoryValue(arg1) -- Line 144
    return BinderUtils_upvr.getChildren(InventoryItemBinder_upvr, arg1)
end
function module_upvr.getEquipped() -- Line 147
    return TableUtils_upvr.filter(InventoryItemBinder_upvr:GetAll(), function(arg1) -- Line 148
        return InventoryItemUtils_upvr.getEquipped(arg1.obj)
    end)
end
function module_upvr.getEquippedFor(arg1) -- Line 152
    return TableUtils_upvr.filter(module_upvr.getEquipped(), function(arg1_3) -- Line 153
        local var47
        if arg1_3:GetOwner() ~= arg1 then
            var47 = false
        else
            var47 = true
        end
        return var47
    end)
end
function module_upvr.playerHasItem(arg1, arg2) -- Line 157
    for _, v_5 in ipairs(module_upvr.getInventoryItemsFor(arg1)) do
        if v_5:GetName() == arg2 then
            return true
        end
    end
    return false
end
return module_upvr