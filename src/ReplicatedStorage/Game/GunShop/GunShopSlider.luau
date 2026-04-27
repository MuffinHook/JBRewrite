local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local GunShop = ReplicatedStorage.Resource.GunShop
local GunShopSlider = {}
GunShopSlider.__index = GunShopSlider
function GunShopSlider.new()
	local instance = {}
	setmetatable(instance, GunShopSlider)
	instance._maid = Maid.new()
	local Slider = GunShop.PresetSlider:Clone()
	Slider.Name = "Slider"
	instance._sliderFrame = Slider
	instance._maid:GiveTask(Slider)
	local UIListLayout = Slider.UIListLayout
	instance._maid:GiveTask(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Slider.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + 20, 1, 0)
	end))
	instance._listItem = {}
	return instance
end
function GunShopSlider.AddItem(self, itemFrame)
	itemFrame:SetLayoutOrder(if #self._listItem > 0 then self._listItem[#self._listItem]:GetLayoutOrder() else 0 + 1)
	itemFrame:SetParent(self._sliderFrame)
	table.insert(self._listItem, itemFrame)
end
function GunShopSlider.SetParent(self, parentFrame)
	self._sliderFrame.Parent = parentFrame
end
function GunShopSlider.Destroy(self)
	for i, itemFrame in ipairs(self._listItem) do
		itemFrame:Destroy()
	end
	self._maid:Destroy()
	self._maid = nil
end
return GunShopSlider
