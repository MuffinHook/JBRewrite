local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.89999, 0.60000, -1.5);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local module_upvr = {
    __ClassName = "CCTV";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 27
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:DefaultDisableCamLock()
    if any_new_result1.Local then
        any_new_result1:_showGui()
    end
    return any_new_result1
end
local Players_upvr = game:GetService("Players")
local BountyBoardService_upvr = require(game:GetService("ReplicatedStorage").Bounty.BountyBoardService)
function module_upvr._showGui(arg1) -- Line 39
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BountyBoard"
    ScreenGui.Parent = Players_upvr.LocalPlayer:FindFirstChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 5
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Enabled = true
    local Frame_2 = Instance.new("Frame")
    Frame_2.BackgroundTransparency = 0.75
    Frame_2.BackgroundColor3 = Color3.new(0, 0, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Name = "Container"
    Frame_2.Size = UDim2.fromScale(0.5, 0.4)
    Frame_2.Position = UDim2.fromScale(0.5, 0.5)
    Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_2.Parent = ScreenGui
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Frame_2
    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.new(0.3, 0.3, 0.3)
    UIStroke.Thickness = 2
    UIStroke.Transparency = 0.5
    UIStroke.Parent = Frame_2
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 10)
    UIPadding.PaddingBottom = UDim.new(0, 10)
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.Parent = Frame_2
    local any_getTopBounties_result1 = BountyBoardService_upvr.getTopBounties(6)
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Title"
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 0.15, 0)
    TextLabel.Position = UDim2.new(0.5, 0, 0, 0)
    local vector2 = Vector2.new(0.5, 0)
    TextLabel.AnchorPoint = vector2
    if #any_getTopBounties_result1 == 0 then
        vector2 = "No criminals have a bounty"
    else
        vector2 = "Bounty board. Arrest to collect!"
    end
    TextLabel.Text = vector2
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.Font = Enum.Font.Bangers
    TextLabel.TextScaled = true
    TextLabel.TextWrapped = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    TextLabel.Parent = Frame_2
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Name = "ContentFrame"
    Frame.Size = UDim2.new(1, 0, 0.8, 0)
    Frame.Position = UDim2.new(0, 0, 0.2, 0)
    Frame.Parent = Frame_2
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "UIListLayout"
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Wraps = true
    UIListLayout.Padding = UDim.new(0.05, 0)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Parent = Frame
    BountyBoardService_upvr.updateGui(Frame, any_getTopBounties_result1)
    arg1.maid:GiveTask(ScreenGui)
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 121
    return nil
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 124
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 127
end
return module_upvr