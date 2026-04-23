-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local GunShop = ReplicatedStorage.Resource.GunShop
local t = {}
t.__index = t
function t.new()
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	local Slider = GunShop.PresetSlider:Clone()
	Slider.Name = "Slider"
	t2._sliderFrame = Slider
	t2._maid:GiveTask(Slider)
	local UIListLayout = Slider.UIListLayout
	t2._maid:GiveTask(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Slider.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + 20, 1, 0)
	end))
	t2._listItem = {}
	return t2
end
function t.AddItem(p1, p2)
	p2:SetLayoutOrder(if #p1._listItem > 0 then p1._listItem[#p1._listItem]:GetLayoutOrder() else 0 + 1)
	p2:SetParent(p1._sliderFrame)
	table.insert(p1._listItem, p2)
end
function t.SetParent(p1, p2)
	p1._sliderFrame.Parent = p2
end
function t.Destroy(p1)
	for i, v in ipairs(p1._listItem) do
		v:Destroy()
	end
	p1._maid:Destroy()
	p1._maid = nil
end
return t