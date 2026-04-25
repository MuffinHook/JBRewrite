-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LevelSystem = require(ReplicatedStorage.Game.Level2.LevelSystem)
local LevelUtils = require(ReplicatedStorage.Game.Level2.LevelUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Format = require(ReplicatedStorage.Module.Format)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GunShop = ReplicatedStorage.Resource.GunShop
local t = {}
t.__index = t
t.__ClassName = "GunShopItem"
function t.new()
	local self = {}
	setmetatable(self, t)
	self._maid = Maid.new()
	self._itemFrame = GunShop.PresetItem:Clone()
	self._maid:GiveTask(self._itemFrame)
	self._layoutOrder = 0
	local TextButton = Instance.new("TextButton")
	TextButton.BackgroundTransparency = 1
	TextButton.Text = ""
	TextButton.Size = UDim2.fromScale(1, 1)
	TextButton.Parent = self._itemFrame
	self.onMouseButton1Down = TextButton.MouseButton1Click
	self._price = 0
	self._owned = false
	self._equipped = false
	self._level = nil
	self._itemName = nil
	self._maid:GiveTask(LevelSystem.getOnLevelChangedSignal():Connect(function(changedPlayer)
		if changedPlayer == LocalPlayer then
			self:UpdateLevel()
		end
	end))
	return self
end
function t.GetName(self)
	return self._itemName
end
function t.SetName(self, itemName, displayName)
	self._itemName = itemName
	self._itemFrame.Name = itemName
	self._itemFrame.Top.Title.Text = displayName:upper()
end
function t.SetImageId(self, imageId)
	if typeof(imageId) == "number" then
		imageId = ("rbxassetid://%d"):format(imageId)
	end
	self._itemFrame.Top.Icon.Image = imageId
end
function t.SetImageColor(self, color)
	self._itemFrame.Top.Icon.ImageColor3 = color
end
function t.SetPrice(self, price)
	self._price = price
	self:Update()
end
function t.SetLevel(self, level)
	self._level = level
	self:UpdateLevel()
end
function t.SetOwned(self, owned)
	if self._owned ~= owned then
		self._owned = owned
		self:Update()
		self:UpdateLevel()
	end
end
function t.GetEquipped(self)
	return self._equipped
end
function t.SetEquipped(self, equipped)
	if self._equipped ~= equipped then
		self._equipped = equipped
		self:Update()
	end
end
function t.UpdateLevel(self)
	local shouldShowLevel = if self._level == nil then false else not self._owned
	self._itemFrame.Bottom.Level.Visible = shouldShowLevel
	if shouldShowLevel then
		self._itemFrame.Bottom.Level.Text = ("LVL %d"):format(self._level)
		self._itemFrame.Bottom.Level.Lock.Visible = LevelUtils.yieldLevel(LocalPlayer) < self._level
	end
end
function t.AddRequiredGamepass(self, gamepassEnum)
	assert(gamepassEnum)
	local iconElement = GunShop.PresetRequiredIcon:Clone()
	iconElement.Parent = self._itemFrame.Bottom.RequiredContainer
	self._maid:GivePromise(GamepassSystem.promiseImageId(GamepassUtils.GetGamepassFromEnum(gamepassEnum).PassId):andThen(function(gamepassId)
		iconElement.Image = ("rbxassetid://%d"):format(gamepassId)
		iconElement.Visible = true
	end):catch(warn))
	self._maid:GiveTask(iconElement.MouseButton1Down:Connect(function()
		GamepassUtils.PromptGamepass(gamepassEnum)
	end))
end
function t.Update(self)
	if self._equipped then
		self._itemFrame.Bottom.Action.Text = "UNEQUIP"
		self._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(212, 39, 39)
	elseif self._owned then
		self._itemFrame.Bottom.Action.Text = "EQUIP"
		self._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(212, 39, 39)
	else
		if self._price == 0 then
			self._itemFrame.Bottom.Action.Text = "FREE"
		else
			self._itemFrame.Bottom.Action.Text = Format.Currency(self._price)
		end
		self._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(112, 212, 69)
	end
	if self._owned then
		self._itemFrame.Image = "rbxassetid://5834235796"
	else
		self._itemFrame.Image = "rbxassetid://5834236192"
	end
end
function t.GetLayoutOrder(self)
	return self._itemFrame.LayoutOrder
end
function t.SetLayoutOrder(self, layoutOrder)
	self._itemFrame.LayoutOrder = layoutOrder
end
function t.SetParent(self, parent)
	self._itemFrame.Parent = parent
end
function t.Destroy(self)
	self._maid:Destroy()
	self._maid = nil
end
return t
