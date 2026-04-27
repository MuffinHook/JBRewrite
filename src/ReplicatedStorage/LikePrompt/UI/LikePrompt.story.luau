local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(storybook)
	local AppComponent = Roact.Component:extend("App")
	local LikePrompt = require(script.Parent.LikePrompt)
	function AppComponent.init(self)
		self:setState({
			visible = true
		})
	end
	function AppComponent.render(self)
		return createElement(LikePrompt, {
			visible = self.state.visible,
			countdownTil = workspace:GetServerTimeNow() + 20,
			onClickDone = function()
				print("clicked done..")
				self:setState({
					visible = false
				})
			end,
			onExpired = function()
				print("expired..")
				self:setState({
					visible = false
				})
			end
		})
	end
	function AppComponent.willUnmount(self) end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), storybook)
	return function()
		Roact.unmount(mountedComponent)
	end
end
