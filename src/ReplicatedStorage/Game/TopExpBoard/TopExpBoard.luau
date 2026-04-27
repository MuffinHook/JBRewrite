game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local TopExpBoard = {}
TopExpBoard.__index = TopExpBoard
function TopExpBoard.new(parentNode)
	local instance = {}
	setmetatable(instance, TopExpBoard)
	instance._maid = Maid.new()
	instance._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(parentNode, "BoardGui", function(boardGui, maidTask)
		local Container = boardGui:WaitForChild("Container")
		local UIListLayout = Container:WaitForChild("UIListLayout")
		local function resize()
			Container.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y)
		end
		Container.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y)
		maidTask:GiveTask(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize))
		local function scrollY(scrollAmount)
			Container.Position = UDim2.new(0, 0, 0, -scrollAmount)
		end
		local currentIndex = 0
		Interval.every(5):Connect(function()
			local Y = boardGui.AbsoluteSize.Y
			local Y_2 = Container.AbsoluteSize.Y
			local itemHeight = Y_2 / (#Container:GetChildren() - 1)
			local maxPages = math.ceil(Y_2 / Y)
			Container.Position = UDim2.new(0, 0, 0, -math.min(math.floor(currentIndex * Y / itemHeight) * itemHeight, Y_2 - Y))
			currentIndex = (currentIndex + 1) % maxPages
		end)
	end))
	return instance
end
function TopExpBoard.Destroy(instance)
	instance._maid:Destroy()
	setmetatable(instance, nil)
end
return TopExpBoard
