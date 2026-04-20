local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local GunShop_upvr = ReplicatedStorage.Resource.GunShop
function module_upvr.new() -- Line 8
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    local clone_upvr = GunShop_upvr.PresetSlider:Clone()
    clone_upvr.Name = "Slider"
    module._sliderFrame = clone_upvr
    module._maid:GiveTask(clone_upvr)
    local UIListLayout_upvr = clone_upvr.UIListLayout
    module._maid:GiveTask(UIListLayout_upvr:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line 22
        clone_upvr.CanvasSize = UDim2.new(0, UIListLayout_upvr.AbsoluteContentSize.X + 20, 1, 0)
    end))
    module._listItem = {}
    return module
end
function module_upvr.AddItem(arg1, arg2) -- Line 31
    local var9 = 0
    if 0 < #arg1._listItem then
        var9 = arg1._listItem[#arg1._listItem]:GetLayoutOrder()
    end
    arg2:SetLayoutOrder(var9 + 1)
    arg2:SetParent(arg1._sliderFrame)
    table.insert(arg1._listItem, arg2)
end
function module_upvr.SetParent(arg1, arg2) -- Line 40
    arg1._sliderFrame.Parent = arg2
end
function module_upvr.Destroy(arg1) -- Line 43
    for _, v in ipairs(arg1._listItem) do
        v:Destroy()
    end
    arg1._maid:Destroy()
    arg1._maid = nil
end
return module_upvr