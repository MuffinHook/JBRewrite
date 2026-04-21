local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils_upvr = require(ReplicatedStorage.EzUi.EzUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local ItemSkin_upvr = require(ReplicatedStorage.Game.ItemSkin.ItemSkin)
local function _(arg1) -- Line 15, Named "comma"
    local string_match_result1, string_match_result2_2, string_match_result3_3 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_3
end
local function _(arg1) -- Line 20, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local function Anchor_upvr(arg1, arg2) -- Line 24, Named "Anchor"
    for _, v in next, arg1:GetChildren() do
        if v:IsA("BasePart") then
            v.Anchored = arg2
        end
        Anchor_upvr(v, arg2)
    end
end
local function ItemFrameGen_upvr(arg1, arg2) -- Line 32, Named "ItemFrameGen"
    local Frame = arg2.Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 0, 20)
    TextLabel.Position = UDim2.new(0, 0, 0, 5)
    TextLabel.Text = arg1.Name
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextSize = 20
    TextLabel.Parent = Frame
    if arg1.Price then
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.new(1, 0, 0.2, 0)
        TextLabel_2.Position = UDim2.new(0, 0, 0.75, 0)
        local string_match_result1_3, string_match_result2, string_match_result3_2 = string.match(arg1.Price, "^([^%d]*%d)(%d*)(.-)$")
        TextLabel_2.Text = string.format("$%s", string_match_result1_3..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.TextColor3 = Color3.new(0, 1, 0)
        TextLabel_2.TextStrokeTransparency = 0.5
        TextLabel_2.TextStrokeColor3 = Color3.fromRGB(11, 111, 0)
        TextLabel_2.Font = Enum.Font.SourceSansBold
        TextLabel_2.TextScaled = true
        TextLabel_2.Parent = Frame
        arg2.TextLabelPrice = TextLabel_2
        local TextButton = Instance.new("TextButton")
        TextButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        TextButton.TextColor3 = Color3.new(1, 1, 1)
        TextButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        TextButton.Position = UDim2.new(0.1, 0, 0.75, 0)
        local string_match_result1_2, string_match_result2_3, string_match_result3 = string.match(arg1.Price, "^([^%d]*%d)(%d*)(.-)$")
        TextButton.Text = string.format("Buy $%s", string_match_result1_2..string_match_result2_3:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3)
        TextButton.BorderSizePixel = 0
        TextButton.Font = Enum.Font.SourceSansBold
        TextButton.TextScaled = true
        TextButton.Visible = false
        TextButton.Parent = Frame
        arg2.TextButtonBuy = TextButton
    end
end
local function _(arg1, arg2) -- Line 81, Named "UpdateItemFrame"
    local any_DoesPlayerOwn_result1_3 = ItemSkin_upvr.DoesPlayerOwn(arg1.Name)
    arg2.Owned = any_DoesPlayerOwn_result1_3
    if any_DoesPlayerOwn_result1_3 then
        local TextLabelPrice_2 = arg2.TextLabelPrice
        TextLabelPrice_2.Text = "OWNED"
        TextLabelPrice_2.TextColor3 = Color3.fromRGB(230, 230, 230)
        TextLabelPrice_2.TextStrokeTransparency = 1
        TextLabelPrice_2.Font = Enum.Font.SourceSansBold
    end
end
local ItemSystem_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local ItemSkinUIUtils_upvr = require(script.Parent.ItemSkinUIUtils)
local function GetInstance_upvr(arg1) -- Line 96, Named "GetInstance"
    local any_GetLocalEquipped_result1 = ItemSystem_upvr.GetLocalEquipped()
    if any_GetLocalEquipped_result1 == nil then
        error("Player has no item equipped.")
    end
    return ItemSkinUIUtils_upvr.getModel(arg1.Name, any_GetLocalEquipped_result1.__ClassName)
end
local function ViewportUpdate_upvr(arg1, arg2) -- Line 105, Named "ViewportUpdate"
    local tick_result1 = tick()
    arg1.CFrame = CFrame.Angles(0, tick_result1 % (-math.pi*2), 0) * CFrame.Angles(math.sin(tick_result1 * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.Skeleton.BoundingBox.Size.Magnitude * 0.8)
end
local module_upvr = {
    OnSkinClick = Signal.new();
    OnSkinBuyClick = Signal.new();
    OnClosed = Signal.new();
    IsOpen = false;
    Init = function() -- Line 117, Named "Init"
    end;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ItemSkinList_upvr = require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)
local ViewportSlider_upvr = require(ReplicatedStorage.Game.Garage.GarageUI.ViewportSlider)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Open() -- Line 122
    if module_upvr.IsOpen == true then
        error("Already open!")
    end
    module_upvr.IsOpen = true
    module_upvr.Maid = Maid_upvr.new()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.Maid:GiveTask(ScreenGui)
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0.02, 0)
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.Parent = ScreenGui
    for _, v_2 in ipairs(ItemSkinList_upvr) do
        local var45
        if v_2.Hidden and not ItemSkin_upvr.DoesPlayerOwn(v_2.Name) then
            var45 = false
        end
        if var45 then
            table.insert({}, {
                Name = v_2.Name;
                Price = v_2.Price;
            })
        end
    end
    local var47_upvw
    local function _() -- Line 158, Named "ClearSelection"
        if var47_upvw then
            var47_upvw.TextButtonBuy.Visible = false
            var47_upvw = nil
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local any_new_result1 = ViewportSlider_upvr.new({}, ItemFrameGen_upvr, GetInstance_upvr, ViewportUpdate_upvr)
    any_new_result1:SetParent(ScreenGui)
    module_upvr.mViewportSlider = any_new_result1
    module_upvr.Maid:GiveTask(module_upvr.mViewportSlider)
    for i_3 = 1, #any_new_result1.ListItem do
        local var49_upvr = any_new_result1.ListItem[i_3]
        local var55_upvr = any_new_result1.Viewports[i_3]
        module_upvr.Maid:GiveTask(var55_upvr.TextButtonBuy.MouseButton1Down:Connect(function() -- Line 175, Named "OnClick"
            if var47_upvw then
                var47_upvw.TextButtonBuy.Visible = false
                var47_upvw = nil
            end
            module_upvr.OnSkinBuyClick:Fire(var49_upvr)
        end))
        local any_DoesPlayerOwn_result1 = ItemSkin_upvr.DoesPlayerOwn(var49_upvr.Name)
        var55_upvr.Owned = any_DoesPlayerOwn_result1
        if any_DoesPlayerOwn_result1 then
            local TextLabelPrice_3 = var55_upvr.TextLabelPrice
            TextLabelPrice_3.Text = "OWNED"
            TextLabelPrice_3.TextColor3 = Color3.fromRGB(230, 230, 230)
            TextLabelPrice_3.TextStrokeTransparency = 1
            TextLabelPrice_3.Font = Enum.Font.SourceSansBold
        end
        if i_3 == 1 then
            spawn(function() -- Line 184
                EzUtils_upvr.selectIfGamepad(var55_upvr.Frame)
            end)
        end
    end
    function var55_upvr(arg1, arg2) -- Line 190
        if var47_upvw then
            var47_upvw.TextButtonBuy.Visible = false
            var47_upvw = nil
        end
        if not arg2.Owned then
            arg2.TextButtonBuy.Visible = true
        end
        module_upvr.OnSkinClick:Fire(arg1)
        EzUtils_upvr.selectIfGamepad(arg2.TextButtonBuy)
        var47_upvw = arg2
    end
    module_upvr.Maid:GiveTask(any_new_result1.OnMouseClick:Connect(var55_upvr))
    function var55_upvr() -- Line 201
        module_upvr.Heartbeat()
    end
    module_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(var55_upvr))
end
function module_upvr.Heartbeat() -- Line 205
    module_upvr.mViewportSlider:Update()
end
function module_upvr.UpdateOwned() -- Line 208
    local mViewportSlider = module_upvr.mViewportSlider
    if mViewportSlider == nil then
        return false
    end
    for i_4 = 1, #mViewportSlider.ListItem do
        local var58 = mViewportSlider.Viewports[i_4]
        local any_DoesPlayerOwn_result1_2 = ItemSkin_upvr.DoesPlayerOwn(mViewportSlider.ListItem[i_4].Name)
        var58.Owned = any_DoesPlayerOwn_result1_2
        if any_DoesPlayerOwn_result1_2 then
            local TextLabelPrice = var58.TextLabelPrice
            TextLabelPrice.Text = "OWNED"
            TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
            TextLabelPrice.TextStrokeTransparency = 1
            TextLabelPrice.Font = Enum.Font.SourceSansBold
        end
    end
end
function module_upvr.Close() -- Line 219
    if module_upvr.IsOpen ~= true then
        error("Not open!")
    end
    module_upvr.IsOpen = false
    module_upvr.Maid:Destroy()
    module_upvr.Maid = nil
    module_upvr.OnClosed:Fire()
end
return module_upvr