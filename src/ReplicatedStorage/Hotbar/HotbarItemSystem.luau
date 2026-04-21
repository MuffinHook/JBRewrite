local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local HotbarItemBinder_upvr = require(script.Parent.HotbarItemBinder)
local HotbarItemUtils_upvr = require(script.Parent.HotbarItemUtils)
local module_upvr = {
    isDragging = false;
}
local Players_upvr = game:GetService("Players")
local HotbarItemConsts_upvr = require(script.Parent.HotbarItemConsts)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local UserInputService_upvr = game:GetService("UserInputService")
local InventoryItemBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem_upvr = require(ReplicatedStorage.Inventory.InventoryItemSystem)
function module_upvr.init() -- Line 16
    require(script.Parent.HotbarItemRes).init()
    local tbl_upvr = {Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.Five, Enum.KeyCode.Six, Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine, Enum.KeyCode.Zero}
    local function updateDisplayOrder_upvr() -- Line 32, Named "updateDisplayOrder"
        if module_upvr.isDragging then
        else
            local any_getSortedHotbarItemsFor_result1 = module_upvr.getSortedHotbarItemsFor(Players_upvr.LocalPlayer)
            for i = 1, #any_getSortedHotbarItemsFor_result1 do
                local var16 = any_getSortedHotbarItemsFor_result1[i]
                if tbl_upvr[i] then
                    var16:SetKeyCode(tbl_upvr[i])
                    var16:SetBindText(string.format("%d", i));
                else
                    var16:SetKeyCode(nil)
                    var16:SetBindText(nil)
                end
            end
        end
    end
    HotbarItemBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 50
        if arg1:GetOwner() ~= Players_upvr.LocalPlayer then
        else
            if not HotbarItemUtils_upvr.getDisplayOrder(arg1.obj) then
                HotbarItemUtils_upvr.setDisplayOrder(arg1.obj, math.max(unpack(TableUtils_upvr.map(module_upvr.getHotbarItemsFor(arg1:GetOwner()), function(arg1_2) -- Line 58
                    local var19 = HotbarItemUtils_upvr.getDisplayOrder(arg1_2.obj) or 0
                    if 50 < var19 then
                        var19 = 0
                    end
                    return var19
                end))) + 1)
            end
            updateDisplayOrder_upvr()
            arg1._maid:GiveTask(arg1.obj:GetAttributeChangedSignal(HotbarItemConsts_upvr.DISPLAY_ORDER_ATTR_NAME):Connect(updateDisplayOrder_upvr))
            arg1._maid:GiveTask(arg1.onDragStarted:Connect(function() -- Line 76
                assert(not module_upvr.isDragging, "somehow hotbar is already dragging")
                module_upvr.isDragging = true
                local any_new_result1 = Maid_upvr.new()
                any_new_result1:GiveTask(function() -- Line 80
                    module_upvr.isDragging = false
                end)
                arg1._maid._dragMaid = any_new_result1
                local any_getSortedHotbarItemsFor_result1_upvr = module_upvr.getSortedHotbarItemsFor(arg1:GetOwner())
                local len_upvr = #any_getSortedHotbarItemsFor_result1_upvr
                arg1:SetSize(1.2)
                any_new_result1:GiveTask(function() -- Line 89
                    arg1:SetSize(1)
                    arg1:Spin()
                end)
                local table_find_result1_upvw = table.find(any_getSortedHotbarItemsFor_result1_upvr, arg1)
                local X = arg1._frame.Parent.UIListLayout.AbsoluteContentSize.X
                local var29_upvr = arg1._frame.Parent.AbsolutePosition.X + arg1._frame.Parent.AbsoluteSize.X * 0.5 - X * 0.5
                local var30_upvr = X / len_upvr
                any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 103
                    table_find_result1_upvw = math.floor((UserInputService_upvr:GetMouseLocation().X - var29_upvr) / var30_upvr) + 1
                    if table_find_result1_upvw < 1 then
                        table_find_result1_upvw = 1
                    elseif len_upvr < table_find_result1_upvw then
                        table_find_result1_upvw = len_upvr
                    end
                    for i_2, v in ipairs(any_getSortedHotbarItemsFor_result1_upvr) do
                        HotbarItemUtils_upvr.setDisplayOrder(v.obj, HotbarItemUtils_upvr.calculateNewIndex(i_2, table_find_result1_upvw, table_find_result1_upvw))
                    end
                end))
                any_new_result1:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_3) -- Line 121
                    if arg1_3.UserInputType == Enum.UserInputType.MouseButton1 or arg1_3.UserInputType == Enum.UserInputType.Touch or arg1_3.UserInputType == Enum.UserInputType.Gamepad1 then
                        arg1._maid._dragMaid = nil
                        updateDisplayOrder_upvr()
                    end
                end))
            end))
            arg1._maid:GiveTask(arg1:GetInventoryItem():GetEquippedSignal():Connect(function() -- Line 137
                local any_GetInventoryItem_result1 = arg1:GetInventoryItem()
                local var39
                if any_GetInventoryItem_result1 and any_GetInventoryItem_result1:GetEquipped() then
                    var39 = true
                end
                arg1:SetDropVisible(var39)
            end))
            if arg1:GetInventoryItem():GetEquipped() then
                arg1:SetDropVisible(arg1:GetInventoryItem():GetEquipped())
            end
        end
    end)
    HotbarItemBinder_upvr:GetClassRemovingSignal():Connect(function(arg1) -- Line 153
        if arg1:GetOwner() ~= Players_upvr.LocalPlayer then
        else
            task.defer(updateDisplayOrder_upvr)
        end
    end)
    HotbarItemBinder_upvr:Start()
    UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 164
        if arg2 then
        elseif arg1.UserInputType == Enum.UserInputType.Keyboard then
            for _, v_2 in ipairs(module_upvr.getHotbarItemsFor(Players_upvr.LocalPlayer)) do
                if arg1.KeyCode == v_2.keyCode then
                    local any_Get_result1 = InventoryItemBinder_upvr:Get(v_2.obj)
                    assert(any_Get_result1, "hotbarItem is somehow not simultaneously inventoryItem")
                    any_Get_result1:AttemptSelect()
                end
            end
        end
    end)
    UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 181
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        do
            return false
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
end
function module_upvr.getHotbarItemsFor(arg1) -- Line 223
    return TableUtils_upvr.filter(HotbarItemBinder_upvr:GetAll(), function(arg1_4) -- Line 224
        local var50
        if arg1_4:GetOwner() ~= arg1 then
            var50 = false
        else
            var50 = true
        end
        return var50
    end)
end
function module_upvr.getSortedHotbarItemsFor(arg1) -- Line 228
    local any_getHotbarItemsFor_result1 = module_upvr.getHotbarItemsFor(arg1)
    table.sort(any_getHotbarItemsFor_result1, function(arg1_5, arg2) -- Line 230
        local var53
        if (HotbarItemUtils_upvr.getDisplayOrder(arg1_5.obj) or 0) >= (HotbarItemUtils_upvr.getDisplayOrder(arg2.obj) or 0) then
            var53 = false
        else
            var53 = true
        end
        return var53
    end)
    return any_getHotbarItemsFor_result1
end
return module_upvr