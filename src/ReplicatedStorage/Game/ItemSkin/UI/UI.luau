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
local function comma(numberString)
	local firstPart, middlePart, lastPart = string.match(numberString, "^([^%d]*%d)(%d*)(.-)$")
	return firstPart .. middlePart:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. lastPart
end
local function SelectIfGamepad(element)
	EzUtils.selectIfGamepad(element)
end
local function setChildrenAnchored(instance, shouldBeAnchored)
	local nextFunction = next
	local children, iteratorState = instance:GetChildren()
	for index, child in nextFunction, children, iteratorState do
		if child:IsA("BasePart") then
			child.Anchored = shouldBeAnchored
		end
		setChildrenAnchored(child, shouldBeAnchored)
	end
end
local function ItemFrameGen(itemData, displayContainer)
	local Frame = displayContainer.Frame
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Size = UDim2.new(1, 0, 0, 20)
	TextLabel.Position = UDim2.new(0, 0, 0, 5)
	TextLabel.Text = itemData.Name
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	TextLabel.Font = Enum.Font.SourceSansBold
	TextLabel.TextSize = 20
	TextLabel.Parent = Frame
	if itemData.Price then
		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Size = UDim2.new(1, 0, 0.2, 0)
		TextLabel_2.Position = UDim2.new(0, 0, 0.75, 0)
		local pricePart1, pricePart2, pricePart3 = string.match(itemData.Price, "^([^%d]*%d)(%d*)(.-)$")
		TextLabel_2.Text = ("$%s"):format(pricePart1 .. pricePart2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. pricePart3)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.TextColor3 = Color3.new(0/255, 255/255, 0/255)
		TextLabel_2.TextStrokeTransparency = 0.5
		TextLabel_2.TextStrokeColor3 = Color3.fromRGB(11, 111, 0)
		TextLabel_2.Font = Enum.Font.SourceSansBold
		TextLabel_2.TextScaled = true
		TextLabel_2.Parent = Frame
		displayContainer.TextLabelPrice = TextLabel_2
		local TextButton = Instance.new("TextButton")
		TextButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		TextButton.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		TextButton.Size = UDim2.new(0.8, 0, 0.2, 0)
		TextButton.Position = UDim2.new(0.1, 0, 0.75, 0)
		local buttonPricePart1, buttonPricePart2, buttonPricePart3 = string.match(itemData.Price, "^([^%d]*%d)(%d*)(.-)$")
		TextButton.Text = ("Buy $%s"):format(buttonPricePart1 .. buttonPricePart2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. buttonPricePart3)
		TextButton.BorderSizePixel = 0
		TextButton.Font = Enum.Font.SourceSansBold
		TextButton.TextScaled = true
		TextButton.Visible = false
		TextButton.Parent = Frame
		displayContainer.TextButtonBuy = TextButton
	end
end
local function UpdateItemFrame(itemData, displayContainer)
	local isOwned = ItemSkin.DoesPlayerOwn(itemData.Name)
	displayContainer.Owned = isOwned
	if isOwned then
		local TextLabelPrice = displayContainer.TextLabelPrice
		TextLabelPrice.Text = "OWNED"
		TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelPrice.TextStrokeTransparency = 1
		TextLabelPrice.Font = Enum.Font.SourceSansBold
	end
end
local function GetInstance(itemData)
	local equippedItem = ItemSystem.GetLocalEquipped()
	if equippedItem == nil then
		error("Player has no item equipped.")
	end
	return ItemSkinUIUtils.getModel(itemData.Name, equippedItem.__ClassName)
end
local function ViewportUpdate(modelInstance, skeletonInfo)
	local currentTime = tick()
	modelInstance.CFrame = CFrame.Angles(0, currentTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(currentTime * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, skeletonInfo.Skeleton.BoundingBox.Size.Magnitude * 0.8)
end
local UIModule = {
	OnSkinClick = Signal.new(),
	OnSkinBuyClick = Signal.new(),
	OnClosed = Signal.new(),
	IsOpen = false,
	Init = function()  end
}
function UIModule.Open()
	if UIModule.IsOpen == true then
		error("Already open!")
	end
	UIModule.IsOpen = true
	UIModule.Maid = Maid.new()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = LocalPlayer.PlayerGui
	UIModule.Maid:GiveTask(ScreenGui)
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.02, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.Parent = ScreenGui
	local visibleItems = {}
	for i, itemSkin in ipairs(ItemSkinList) do
		local isVisible
		isVisible = not itemSkin.Hidden or ItemSkin.DoesPlayerOwn(itemSkin.Name)
		if isVisible then
			table.insert(visibleItems, {
				Name = itemSkin.Name,
				Price = itemSkin.Price
			})
		end
	end
	local selectedViewport = nil
	local function ClearSelection()
		if selectedViewport then
			selectedViewport.TextButtonBuy.Visible = false
			selectedViewport = nil
		end
	end
	local viewportSlider = ViewportSlider.new(visibleItems, ItemFrameGen, GetInstance, ViewportUpdate)
	viewportSlider:SetParent(ScreenGui)
	UIModule.mViewportSlider = viewportSlider
	UIModule.Maid:GiveTask(UIModule.mViewportSlider)
	for i = 1, #viewportSlider.ListItem do
		local itemDataEntry = viewportSlider.ListItem[i]
		local viewportDisplay = viewportSlider.Viewports[i]
		local function OnClick()
			if selectedViewport then
				selectedViewport.TextButtonBuy.Visible = false
				selectedViewport = nil
			end
			UIModule.OnSkinBuyClick:Fire(itemDataEntry)
		end
		UIModule.Maid:GiveTask(viewportDisplay.TextButtonBuy.MouseButton1Down:Connect(OnClick))
		local itemIsOwned = ItemSkin.DoesPlayerOwn(itemDataEntry.Name)
		viewportDisplay.Owned = itemIsOwned
		if itemIsOwned then
			local TextLabelPrice = viewportDisplay.TextLabelPrice
			TextLabelPrice.Text = "OWNED"
			TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabelPrice.TextStrokeTransparency = 1
			TextLabelPrice.Font = Enum.Font.SourceSansBold
		end
		if i == 1 then
			spawn(function()
				EzUtils.selectIfGamepad(viewportDisplay.Frame)
			end)
		end
	end
	UIModule.Maid:GiveTask(viewportSlider.OnMouseClick:Connect(function(itemIndex, viewportData)
		if selectedViewport then
			selectedViewport.TextButtonBuy.Visible = false
			selectedViewport = nil
		end
		if not viewportData.Owned then
			viewportData.TextButtonBuy.Visible = true
		end
		UIModule.OnSkinClick:Fire(itemIndex)
		EzUtils.selectIfGamepad(viewportData.TextButtonBuy)
		selectedViewport = viewportData
	end))
	UIModule.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		UIModule.Heartbeat()
	end))
end
function UIModule.Heartbeat()
	UIModule.mViewportSlider:Update()
end
function UIModule.UpdateOwned()
	local mViewportSlider = UIModule.mViewportSlider
	if mViewportSlider == nil then
		return false
	end
	for i = 1, #mViewportSlider.ListItem do
		local viewportDisplay = mViewportSlider.Viewports[i]
		local itemIsOwned = ItemSkin.DoesPlayerOwn(mViewportSlider.ListItem[i].Name)
		viewportDisplay.Owned = itemIsOwned
		if itemIsOwned then
			local TextLabelPrice = viewportDisplay.TextLabelPrice
			TextLabelPrice.Text = "OWNED"
			TextLabelPrice.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabelPrice.TextStrokeTransparency = 1
			TextLabelPrice.Font = Enum.Font.SourceSansBold
		end
	end
end
function UIModule.Close()
	if UIModule.IsOpen ~= true then
		error("Not open!")
	end
	UIModule.IsOpen = false
	UIModule.Maid:Destroy()
	UIModule.Maid = nil
	UIModule.OnClosed:Fire()
end
return UIModule
