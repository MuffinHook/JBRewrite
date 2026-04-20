local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.new(arg1) -- Line 11
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    module._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, "BoardGui", function(arg1_2, arg2) -- Line 16
        local Container_upvr = arg1_2:WaitForChild("Container")
        local UIListLayout_upvr = Container_upvr:WaitForChild("UIListLayout")
        Container_upvr.Size = UDim2.new(1, 0, 0, UIListLayout_upvr.AbsoluteContentSize.Y)
        arg2:GiveTask(UIListLayout_upvr:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line 19, Named "resize"
            Container_upvr.Size = UDim2.new(1, 0, 0, UIListLayout_upvr.AbsoluteContentSize.Y)
        end))
        local function _(arg1_3) -- Line 25, Named "scrollY"
            Container_upvr.Position = UDim2.new(0, 0, 0, -arg1_3)
        end
        local var11_upvw = 0
        Interval_upvr.every(5):Connect(function() -- Line 29
            local Y_2 = arg1_2.AbsoluteSize.Y
            local Y = Container_upvr.AbsoluteSize.Y
            local var14 = Y / (#Container_upvr:GetChildren() - 1)
            Container_upvr.Position = UDim2.new(0, 0, 0, -math.min(math.floor(var11_upvw * Y_2 / var14) * var14, Y - Y_2))
            var11_upvw = (var11_upvw + 1) % math.ceil(Y / Y_2)
        end)
    end))
    return module
end
function module_upvr.Destroy(arg1) -- Line 45
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr