local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HotbarItemConsts_upvr = require(script.Parent.HotbarItemConsts)
local HotbarItemUtils_upvr = require(script.Parent.HotbarItemUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
function module_upvr.new(arg1) -- Line 17
    local module = {}
    setmetatable(module, module_upvr)
    module.obj = arg1
    module._maid = Maid_upvr.new()
    if module:GetOwner() == Players_upvr.LocalPlayer then
        module:_setupLocal()
    end
    module.lastDroppedAt = 0
    return module
end
function module_upvr.GetOwner(arg1) -- Line 34
    local Parent = arg1.obj.Parent.Parent
    local var10
    if Parent.Parent ~= game:GetService("Players") then
        var10 = false
    else
        var10 = true
    end
    assert(var10, "this hotbarItem is not a valid descendant of a player")
    return Parent
end
function module_upvr.SetKeyCode(arg1, arg2) -- Line 39
    arg1.keyCode = arg2
end
function module_upvr.SetBindText(arg1, arg2) -- Line 42
    local var11
    if arg2 == nil then
        var11 = false
    else
        var11 = true
    end
    arg1._frame.Index.Visible = var11
    if arg2 then
        arg1._frame.Index.Text = arg2
    end
end
function module_upvr.SetDropVisible(arg1, arg2) -- Line 48
    local var12
    if typeof(arg2) ~= "boolean" then
        var12 = false
    else
        var12 = true
    end
    assert(var12, "value must be a boolean")
    arg1._frame.Drop.Visible = arg2
end
local HotbarItemRes_upvr = require(script.Parent.HotbarItemRes)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
function module_upvr._setupLocal(arg1) -- Line 52
    local clone = HotbarItemRes_upvr.presetFrame:Clone()
    clone.Parent = HotbarItemRes_upvr.gui.Container
    arg1._frame = clone
    arg1._maid:GiveTask(arg1._frame)
    arg1:_setupDisplayOrder()
    arg1:_setupImageSrc()
    arg1:_setupDragging()
    arg1.onDragStarted = Signal_upvr.new()
    arg1._maid:GiveTask(arg1.onDragStarted)
    arg1.sizeSpring = Spring_upvr.new(1, 0, 0.5, 50)
    arg1.spinSpring = Spring_upvr.new(0, 0, 0.8, 20)
    local any_Connect_result1 = InventoryItemUtils_upvr.getEquippedSignal(arg1.obj):Connect(function() -- Line 67, Named "handleEquipped"
        local var18
        if InventoryItemUtils_upvr.getEquipped(arg1.obj) then
            var18 = 0.5
        else
            var18 = 0
        end
        arg1._frame.ImageTransparency = var18
    end)
    arg1._maid:GiveTask(any_Connect_result1)
    if InventoryItemUtils_upvr.getEquipped(arg1.obj) then
        any_Connect_result1 = 0.5
    else
        any_Connect_result1 = 0
    end
    arg1._frame.ImageTransparency = any_Connect_result1
    arg1._maid:GiveTask(clone.Drop.MouseButton1Down:Connect(function() -- Line 74
        arg1:GetInventoryItem():AttemptDrop()
        arg1.lastDroppedAt = os.clock()
    end))
end
function module_upvr._setupDisplayOrder(arg1) -- Line 79
    local function update() -- Line 80
        arg1._frame.LayoutOrder = HotbarItemUtils_upvr.getDisplayOrder(arg1.obj) or 0
    end
    arg1._frame.LayoutOrder = HotbarItemUtils_upvr.getDisplayOrder(arg1.obj) or 0
    arg1._maid:GiveTask(arg1.obj:GetAttributeChangedSignal(HotbarItemConsts_upvr.DISPLAY_ORDER_ATTR_NAME):Connect(update))
end
function module_upvr._setupImageSrc(arg1) -- Line 87
    arg1._frame.Icon.Image = HotbarItemUtils_upvr.getImageSrc(arg1.obj) or ""
    arg1._maid:GiveTask(arg1.obj:GetAttributeChangedSignal(HotbarItemConsts_upvr.IMAGE_SRC_ATTR_NAME):Connect(function() -- Line 88, Named "update"
        arg1._frame.Icon.Image = HotbarItemUtils_upvr.getImageSrc(arg1.obj) or ""
    end))
end
function module_upvr._setupDragging(arg1) -- Line 95
    arg1._maid:GiveTask(arg1._frame.MouseButton1Down:Connect(function() -- Line 96
        arg1:_onPressStarted()
    end))
    arg1._maid:GiveTask(arg1._frame.MouseButton1Up:Connect(function() -- Line 99
        arg1:_onPressEnded()
    end))
end
function module_upvr._onPressStarted(arg1) -- Line 103
    local var23_upvr = (arg1._pressCounter or 0) + 1
    arg1._pressCounter = var23_upvr
    arg1._pressCounterAtStart = arg1._pressCounter
    task.delay(HotbarItemConsts_upvr.MIN_DRAG_DURATION, function() -- Line 108
        if arg1._pressCounter ~= var23_upvr then
        else
            arg1._pressCounter += 1
            arg1.onDragStarted:Fire()
        end
    end)
end
function module_upvr._onPressEnded(arg1) -- Line 116
    if os.clock() - arg1.lastDroppedAt < 0.1 then
    else
        if arg1._pressCounter ~= arg1._pressCounterAtStart then return end
        arg1._pressCounter = (arg1._pressCounter or 0) + 1
        arg1:GetInventoryItem():AttemptSelect()
    end
end
local InventoryItemBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemBinder)
function module_upvr.GetInventoryItem(arg1) -- Line 128
    return InventoryItemBinder_upvr:Get(arg1.obj)
end
function module_upvr.SetSize(arg1, arg2) -- Line 131
    arg1.sizeSpring:SetTarget(arg2)
    arg1._maid.springHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 133
        local any_Update_result1, any_Update_result2 = arg1.sizeSpring:Update()
        local var29
        if math.abs(arg2 - any_Update_result1) < 0.001 and math.abs(any_Update_result2) < 0.001 then
            arg1._maid.springHeartbeat = nil
            var29 = arg2
        end
        arg1._frame.Size = UDim2.new(var29, 0, var29, 0)
    end)
end
function module_upvr.Spin(arg1) -- Line 142
    arg1.spinSpring:SetTarget(360)
    arg1.spinSpring.p = 0
    arg1._maid.spinHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 146
        local any_Update_result1_2, any_Update_result2_2 = arg1.spinSpring:Update()
        local var33
        if math.abs(360 - any_Update_result1_2) < 0.001 and math.abs(any_Update_result2_2) < 0.001 then
            arg1._maid.spinHeartbeat = nil
            var33 = 0
        end
        arg1._frame.Icon.Rotation = var33
    end)
end
function module_upvr.Destroy(arg1) -- Line 155
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr