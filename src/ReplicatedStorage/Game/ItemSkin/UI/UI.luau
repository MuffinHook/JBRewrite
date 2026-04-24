-- Reviewed by Claude
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemSkinUIUtils = require(script.Parent.ItemSkinUIUtils)
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local ViewportSlider = require(ReplicatedStorage.Game.Garage.GarageUI.ViewportSlider)
local ItemSkin = require(ReplicatedStorage.Game.ItemSkin.ItemSkin)
require(ReplicatedStorage.Game.ItemSkin.ItemSkinIds)
local ItemSkinList = require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local function comma(p1)
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
local function SelectIfGamepad(p1)
	EzUtils.selectIfGamepad(p1)
end
local function v1(p1, p2)
	local v12 = next
	local v2, v3 = p1:GetChildren()
	for v4, v5 in v12, v2, v3 do
		if v5:IsA("BasePart") then
			v5.Anchored = p2
		end
		v1(v5, p2)
	end
end
local function ItemFrameGen(p1, p2)
	local Frame = p2.Frame
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Size = UDim2.new(1, 0, 0, 20)
	TextLabel.Position = UDim2.new(0, 0, 0, 5)
	TextLabel.Text = p1.Name
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	TextLabel.Font = Enum.Font.SourceSansBold
	TextLabel.TextSize = 20
	TextLabel.Parent = Frame
	if p1.Price then
		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Size = UDim2.new(1, 0, 0.2, 0)
		TextLabel_2.Position = UDim2.new(0, 0, 0.75, 0)
		local v1, v2, v3 = string.match(p1.Price, "^([^%d]*%d)(%d*)(.-)$")
		TextLabel_2.Text = ("$%s"):format(v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.TextColor3 = Color3.new(0/255, 255/255, 0/255)
		TextLabel_2.TextStrokeTransparency = 0.5
		TextLabel_2.TextStrokeColor3 = Color3.fromRGB(11, 111, 0)
		TextLabel_2.Font = Enum.Font.SourceSansBold
		TextLabel_2.TextScaled = true
		TextLabel_2.Parent = Frame
		p2.TextLabelPrice = TextLabel_2
		local TextButton = Instance.new("TextButton")
		TextButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		TextButton.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		TextButton.Size = UDim2.new(0.8, 0, 0.2, 0)
		TextButton.Position = UDim2.new(0.1, 0, 0.75, 0)
		local v4, v5, v6 = string.match(p1.Price, "^([^%d]*%d)(%d*)(.-)$")
		TextButton.Text = ("Buy $%s"):format(v4 .. v5:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v6)
		TextButton.BorderSizePixel = 0
		TextButton.Font = Enum.Font.SourceSansBold
		TextButton.TextScaled = true
		TextButton.Visible = false
		TextButton.Parent = Frame
		p2.TextButtonBuy = TextButton
	end
end
local function UpdateItemFrame(p1, p2)
	local v1 = ItemSkin.DoesPlayerOwn(p1.Name)
	p2.Owned = v1
	if v1 then
		local TextLabelPrice = p2.TextLabelPrice
		TextLabelPrice.Text = "OWNED"
		TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelPrice.TextStrokeTransparency = 1
		TextLabelPrice.Font = Enum.Font.SourceSansBold
	end
end
local function GetInstance(p1)
	local v1 = ItemSystem.GetLocalEquipped()
	if v1 == nil then
		error("Player has no item equipped.")
	end
	return ItemSkinUIUtils.getModel(p1.Name, v1.__ClassName)
end
local function ViewportUpdate(p1, p2)
	local v1 = tick()
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1 * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, p2.Skeleton.BoundingBox.Size.Magnitude * 0.8)
end
local t = {
	OnSkinClick = Signal.new(),
	OnSkinBuyClick = Signal.new(),
	OnClosed = Signal.new(),
	IsOpen = false,
	Init = function()  end
}
function t.Open()
	if t.IsOpen == true then
		error("Already open!")
	end
	t.IsOpen = true
	t.Maid = Maid.new()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = LocalPlayer.PlayerGui
	t.Maid:GiveTask(ScreenGui)
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.02, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.Parent = ScreenGui
	local t2 = {}
	for i, v in ipairs(ItemSkinList) do
		local v1
		v1 = not v.Hidden or ItemSkin.DoesPlayerOwn(v.Name)
		if v1 then
			table.insert(t2, {
				Name = v.Name,
				Price = v.Price
			})
		end
	end
	local v2 = nil
	local function ClearSelection()
		if v2 then
			v2.TextButtonBuy.Visible = false
			v2 = nil
		end
	end
	local v3 = ViewportSlider.new(t2, ItemFrameGen, GetInstance, ViewportUpdate)
	v3:SetParent(ScreenGui)
	t.mViewportSlider = v3
	t.Maid:GiveTask(t.mViewportSlider)
	for i = 1, #v3.ListItem do
		local v4 = v3.ListItem[i]
		local v5 = v3.Viewports[i]
		local function OnClick()
			if v2 then
				v2.TextButtonBuy.Visible = false
				v2 = nil
			end
			t.OnSkinBuyClick:Fire(v4)
		end
		t.Maid:GiveTask(v5.TextButtonBuy.MouseButton1Down:Connect(OnClick))
		local v6 = ItemSkin.DoesPlayerOwn(v4.Name)
		v5.Owned = v6
		if v6 then
			local TextLabelPrice = v5.TextLabelPrice
			TextLabelPrice.Text = "OWNED"
			TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabelPrice.TextStrokeTransparency = 1
			TextLabelPrice.Font = Enum.Font.SourceSansBold
		end
		if i == 1 then
			spawn(function()
				EzUtils.selectIfGamepad(v5.Frame)
			end)
		end
	end
	t.Maid:GiveTask(v3.OnMouseClick:Connect(function(p1, p2)
		if v2 then
			v2.TextButtonBuy.Visible = false
			v2 = nil
		end
		if not p2.Owned then
			p2.TextButtonBuy.Visible = true
		end
		t.OnSkinClick:Fire(p1)
		EzUtils.selectIfGamepad(p2.TextButtonBuy)
		v2 = p2
	end))
	t.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		t.Heartbeat()
	end))
end
function t.Heartbeat()
	t.mViewportSlider:Update()
end
function t.UpdateOwned()
	local mViewportSlider = t.mViewportSlider
	if mViewportSlider == nil then
		return false
	end
	for i = 1, #mViewportSlider.ListItem do
		local v2 = mViewportSlider.Viewports[i]
		local v3 = ItemSkin.DoesPlayerOwn(mViewportSlider.ListItem[i].Name)
		v2.Owned = v3
		if v3 then
			local TextLabelPrice = v2.TextLabelPrice
			TextLabelPrice.Text = "OWNED"
			TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabelPrice.TextStrokeTransparency = 1
			TextLabelPrice.Font = Enum.Font.SourceSansBold
		end
	end
end
function t.Close()
	if t.IsOpen ~= true then
		error("Not open!")
	end
	t.IsOpen = false
	t.Maid:Destroy()
	t.Maid = nil
	t.OnClosed:Fire()
end
return t
