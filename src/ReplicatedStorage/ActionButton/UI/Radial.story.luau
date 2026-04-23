-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local Radial = require(script.Parent.Radial)
	function v1.init(p1)
		p1:setState({
			countInner = 1,
			countOuter = 1
		})
		p1._maid = Maid.new()
		p1._maid:GiveTask(Interval.every(0.1):Connect(function()
			p1:setState({
				countOuter = p1.state.countOuter % 21 + 1
			})
		end))
		p1._maid:GiveTask(Interval.every(1):Connect(function()
			p1:setState({
				countInner = p1.state.countInner % 2 + 1
			})
		end))
	end
	function v1.render(p1)
		local _ = {
			{
				image = "rbxassetid://7858404863",
				onClick = function(p1)
					print("clicked jump")
				end
			}
		}
		return Roact.createElement(Radial, {
			position = UDim2.new(0.25, 0, 0.25, 0),
			size = UDim2.new(0.5, 0, 0.5, 0),
			countInner = p1.state.countInner,
			countOuter = p1.state.countOuter
		})
	end
	function v1.willUnmount(p1)
		p1._maid:Destroy()
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end