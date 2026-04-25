-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BountyBoardService = require(ReplicatedStorage.Bounty.BountyBoardService)
require(ReplicatedStorage.CCTV.CCTVService)
local Basic = require(script.Parent.Basic)
local motionConfig = {
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
local CCTVClass = {
	__ClassName = "CCTV"
}
CCTVClass.__index = CCTVClass
setmetatable(CCTVClass, Basic)
function CCTVClass.new(p1, p2, p3)
	local instance = Basic.new(p1, p2, motionConfig, p3)
	setmetatable(instance, CCTVClass)
	instance:DefaultDisableCamLock()
	if instance.Local then
		instance:_showGui()
	end
	return instance
end
function CCTVClass._showGui(self)
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
	local bounties = BountyBoardService.getTopBounties(6)
	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 0.15, 0)
	Title.Position = UDim2.new(0.5, 0, 0, 0)
	Title.AnchorPoint = Vector2.new(0.5, 0)
	Title.Text = if #bounties == 0 then "No criminals have a bounty" else "Bounty board. Arrest to collect!"
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
	BountyBoardService.updateGui(ContentFrame, bounties)
	self.maid:GiveTask(BountyBoard)
end
function CCTVClass.GetLeftArmPosition(self)
	return nil
end
function CCTVClass.InputBegan(self, p2, p3)
	Basic.InputBegan(self, p2, p3)
end
function CCTVClass.InputEnded(self) end
return CCTVClass
