-- Reviewed by Claude
game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "BoardGui", function(p1, p2)
		local Container = p1:WaitForChild("Container")
		local UIListLayout = Container:WaitForChild("UIListLayout")
		local function resize()
			Container.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y)
		end
		Container.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y)
		p2:GiveTask(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize))
		local function scrollY(p1)
			Container.Position = UDim2.new(0, 0, 0, -p1)
		end
		local v1 = 0
		Interval.every(5):Connect(function()
			local Y = p1.AbsoluteSize.Y
			local Y_2 = Container.AbsoluteSize.Y
			local v12 = Y_2 / (#Container:GetChildren() - 1)
			local v2 = math.ceil(Y_2 / Y)
			Container.Position = UDim2.new(0, 0, 0, -math.min(math.floor(v1 * Y / v12) * v12, Y_2 - Y))
			v1 = (v1 + 1) % v2
		end)
	end))
	return t2
end
function t.Destroy(p1)
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return t
