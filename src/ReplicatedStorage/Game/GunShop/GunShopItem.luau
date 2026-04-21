local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunShop_upvr = ReplicatedStorage.Resource.GunShop
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "GunShopItem"
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local LevelSystem_upvr = require(ReplicatedStorage.Game.Level2.LevelSystem)
function module_upvr.new() -- Line 16
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._itemFrame = GunShop_upvr.PresetItem:Clone()
    module_upvr_2._maid:GiveTask(module_upvr_2._itemFrame)
    module_upvr_2._layoutOrder = 0
    local TextButton = Instance.new("TextButton")
    TextButton.BackgroundTransparency = 1
    TextButton.Text = ""
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.Parent = module_upvr_2._itemFrame
    module_upvr_2.onMouseButton1Down = TextButton.MouseButton1Click
    module_upvr_2._price = 0
    module_upvr_2._owned = false
    module_upvr_2._equipped = false
    module_upvr_2._level = nil
    module_upvr_2._itemName = nil
    module_upvr_2._maid:GiveTask(LevelSystem_upvr.getOnLevelChangedSignal():Connect(function(arg1) -- Line 45
        if arg1 ~= LocalPlayer_upvr then
        else
            module_upvr_2:UpdateLevel()
        end
    end))
    return module_upvr_2
end
function module_upvr.GetName(arg1) -- Line 54
    return arg1._itemName
end
function module_upvr.SetName(arg1, arg2, arg3) -- Line 57
    arg1._itemName = arg2
    arg1._itemFrame.Name = arg2
    arg1._itemFrame.Top.Title.Text = arg3:upper()
end
function module_upvr.SetImageId(arg1, arg2) -- Line 62
    local var10
    if typeof(arg2) == "number" then
        var10 = string.format("rbxassetid://%d", var10);
    end
    arg1._itemFrame.Top.Icon.Image = var10
end
function module_upvr.SetImageColor(arg1, arg2) -- Line 68
    arg1._itemFrame.Top.Icon.ImageColor3 = arg2
end
function module_upvr.SetPrice(arg1, arg2) -- Line 71
    arg1._price = arg2
    arg1:Update()
end
function module_upvr.SetLevel(arg1, arg2) -- Line 75
    arg1._level = arg2
    arg1:UpdateLevel()
end
function module_upvr.SetOwned(arg1, arg2) -- Line 79
    if arg1._owned ~= arg2 then
        arg1._owned = arg2
        arg1:Update()
        arg1:UpdateLevel()
    end
end
function module_upvr.GetEquipped(arg1) -- Line 86
    return arg1._equipped
end
function module_upvr.SetEquipped(arg1, arg2) -- Line 89
    if arg1._equipped ~= arg2 then
        arg1._equipped = arg2
        arg1:Update()
    end
end
local LevelUtils_upvr = require(ReplicatedStorage.Game.Level2.LevelUtils)
function module_upvr.UpdateLevel(arg1) -- Line 95
    local var12 = false
    if arg1._level ~= nil then
        var12 = not arg1._owned
    end
    arg1._itemFrame.Bottom.Level.Visible = var12
    local var13
    if var12 then
        arg1._itemFrame.Bottom.Level.Text = string.format("LVL %d", arg1._level)
        if LevelUtils_upvr.yieldLevel(LocalPlayer_upvr) >= arg1._level then
            var13 = false
        else
            var13 = true
        end
        arg1._itemFrame.Bottom.Level.Lock.Visible = var13
    end
end
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
function module_upvr.AddRequiredGamepass(arg1, arg2) -- Line 105
    assert(arg2)
    local clone_upvr = GunShop_upvr.PresetRequiredIcon:Clone()
    clone_upvr.Parent = arg1._itemFrame.Bottom.RequiredContainer
    arg1._maid:GivePromise(GamepassSystem_upvr.promiseImageId(GamepassUtils_upvr.GetGamepassFromEnum(arg2).PassId):andThen(function(arg1_2) -- Line 112
        clone_upvr.Image = string.format("rbxassetid://%d", arg1_2)
        clone_upvr.Visible = true
    end):catch(warn))
    arg1._maid:GiveTask(clone_upvr.MouseButton1Down:Connect(function() -- Line 118
        GamepassUtils_upvr.PromptGamepass(arg2)
    end))
end
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module_upvr.Update(arg1) -- Line 122
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1._equipped then
        arg1._itemFrame.Bottom.Action.Text = "UNEQUIP"
        arg1._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(212, 39, 39)
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1._owned then
        arg1._itemFrame.Bottom.Action.Text = "EQUIP"
        arg1._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(212, 39, 39)
    else
        if arg1._price == 0 then
            arg1._itemFrame.Bottom.Action.Text = "FREE"
        else
            arg1._itemFrame.Bottom.Action.Text = Format_upvr.Currency(arg1._price)
        end
        arg1._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(112, 212, 69)
    end
    if arg1._owned then
        arg1._itemFrame.Image = "rbxassetid://5834235796"
    else
        arg1._itemFrame.Image = "rbxassetid://5834236192"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
end
function module_upvr.GetLayoutOrder(arg1) -- Line 144
    return arg1._itemFrame.LayoutOrder
end
function module_upvr.SetLayoutOrder(arg1, arg2) -- Line 147
    arg1._itemFrame.LayoutOrder = arg2
end
function module_upvr.SetParent(arg1, arg2) -- Line 150
    arg1._itemFrame.Parent = arg2
end
function module_upvr.Destroy(arg1) -- Line 153
    arg1._maid:Destroy()
    arg1._maid = nil
end
return module_upvr