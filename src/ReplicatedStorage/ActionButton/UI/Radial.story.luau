local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
return function(storyContext)
	local AppComponent = Roact.Component:extend("App")
	local Radial = require(script.Parent.Radial)
	function AppComponent.init(self)
		self:setState({
			countInner = 1,
			countOuter = 1
		})
		self._maid = Maid.new()
		self._maid:GiveTask(Interval.every(0.1):Connect(function()
			self:setState({
				countOuter = self.state.countOuter % 21 + 1
			})
		end))
		self._maid:GiveTask(Interval.every(1):Connect(function()
			self:setState({
				countInner = self.state.countInner % 2 + 1
			})
		end))
	end
	function AppComponent.render(self)
		local _ = {
			{
				image = "rbxassetid://7858404863",
				onClick = function(button)
					print("clicked jump")
				end
			}
		}
		return Roact.createElement(Radial, {
			position = UDim2.new(0.25, 0, 0.25, 0),
			size = UDim2.new(0.5, 0, 0.5, 0),
			countInner = self.state.countInner,
			countOuter = self.state.countOuter
		})
	end
	function AppComponent.willUnmount(self)
		self._maid:Destroy()
	end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), storyContext)
	return function()
		Roact.unmount(mountedInstance)
	end
end