-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local GunShop = ReplicatedStorage.Resource.GunShop
local t = {}
t.__index = t
function t.new()
	local instance = {}
	setmetatable(instance, t)
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
function t.AddItem(self, p2)
	p2:SetLayoutOrder(if #self._listItem > 0 then self._listItem[#self._listItem]:GetLayoutOrder() else 0 + 1)
	p2:SetParent(self._sliderFrame)
	table.insert(self._listItem, p2)
end
function t.SetParent(self, p2)
	self._sliderFrame.Parent = p2
end
function t.Destroy(self)
	for i, v in ipairs(self._listItem) do
		v:Destroy()
	end
	self._maid:Destroy()
	self._maid = nil
end
return t
