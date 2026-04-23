local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BountyBoardService = require(ReplicatedStorage.Bounty.BountyBoardService)
require(ReplicatedStorage.CCTV.CCTVService)
local Basic = require(script.Parent.Basic)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.9, 0.6, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local t2 = {
	__ClassName = "CCTV"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3) --[[ Line: 27 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1:DefaultDisableCamLock()
	if v1.Local then
		v1:_showGui()
	end
	return v1
end
function t2._showGui(p1) --[[ Line: 39 | Upvalues: Players (copy), BountyBoardService (copy) ]]
	local BountyBoard = Instance.new("ScreenGui")
	BountyBoard.Name = "BountyBoard"
	BountyBoard.Parent = Players.LocalPlayer:FindFirstChild("PlayerGui")
	BountyBoard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	BountyBoard.DisplayOrder = 5
	BountyBoard.IgnoreGuiInset = true
	BountyBoard.Enabled = true
	local Container = Instance.new("Frame")
	Container.BackgroundTransparency = 0.75
	Container.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	Container.BorderSizePixel = 0
	Container.Name = "Container"
	Container.Size = UDim2.fromScale(0.5, 0.4)
	Container.Position = UDim2.fromScale(0.5, 0.5)
	Container.AnchorPoint = Vector2.new(0.5, 0.5)
	Container.Parent = BountyBoard
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = Container
	local UIStroke = Instance.new("UIStroke")
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Color = Color3.new(0.3, 0.3, 0.3)
	UIStroke.Thickness = 2
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Container
	local UIPadding = Instance.new("UIPadding")
	UIPadding.PaddingTop = UDim.new(0, 10)
	UIPadding.PaddingBottom = UDim.new(0, 10)
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.PaddingRight = UDim.new(0, 10)
	UIPadding.Parent = Container
	local v1 = BountyBoardService.getTopBounties(6)
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 0.15, 0)
	Title.Position = UDim2.new(0.5, 0, 0, 0)
	Title.AnchorPoint = Vector2.new(0.5, 0)
	Title.Text = if #v1 == 0 then "No criminals have a bounty" else "Bounty board. Arrest to collect!"
	Title.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Title.Font = Enum.Font.Bangers
	Title.TextScaled = true
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Center
	Title.TextYAlignment = Enum.TextYAlignment.Center
	Title.Parent = Container
	local ContentFrame = Instance.new("Frame")
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Name = "ContentFrame"
	ContentFrame.Size = UDim2.new(1, 0, 0.8, 0)
	ContentFrame.Position = UDim2.new(0, 0, 0.2, 0)
	ContentFrame.Parent = Container
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Name = "UIListLayout"
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Wraps = true
	UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Parent = ContentFrame
	BountyBoardService.updateGui(ContentFrame, v1)
	p1.maid:GiveTask(BountyBoard)
end
function t2.GetLeftArmPosition(p1) --[[ Line: 121 ]]
	return nil
end
function t2.InputBegan(p1, p2, p3) --[[ Line: 124 | Upvalues: Basic (copy) ]]
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1) --[[ Line: 127 ]] end
return t2