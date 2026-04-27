local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(parent)
	local consoleRef = Roact.createRef()
	local settingsRef = Roact.createRef()
	local gamemodesRef = Roact.createRef()
	local AppComponent = Roact.PureComponent:extend("App")
	function AppComponent.init(self)
		self:setState({
			currentPage = nil
		})
	end
	function AppComponent.render(self)
		return Roact.createElement(require(script.Parent), {
			visible = true,
			size = UDim2.new(0.95, 0, 0.95, 0),
			anchorPoint = Vector2.new(0.5, 0.5),
			position = UDim2.new(0.5, 0, 0.5, 0),
			pages = {
				{
					title = "CONSOLE",
					layoutOrder = 1,
					backgroundTransparency = 0.5,
					[Roact.Ref] = consoleRef
				},
				{
					title = "SETTINGS",
					layoutOrder = 2,
					[Roact.Ref] = settingsRef
				},
				{
					title = "GAMEMODES",
					tabColor = Color3.new(0/255, 0/255, 255/255),
					layoutOrder = 3,
					[Roact.Ref] = gamemodesRef
				}
			},
			color = Color3.fromRGB(252, 40, 47),
			currentPage = self.state.currentPage,
			updatePage = function(selectedPage)
				self:setState({
					currentPage = selectedPage
				})
			end
		})
	end
	local mountedHandle = Roact.mount(Roact.createElement(AppComponent), parent)
	return function()
		Roact.unmount(mountedHandle)
	end
end
