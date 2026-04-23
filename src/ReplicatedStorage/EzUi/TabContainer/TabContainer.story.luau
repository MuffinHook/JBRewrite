local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy) ]]
	local v1 = Roact.createRef()
	local v2 = Roact.createRef()
	local v3 = Roact.createRef()
	local v4 = Roact.PureComponent:extend("App")
	function v4.init(p1) --[[ Line: 10 ]]
		p1:setState({
			currentPage = nil
		})
	end
	function v4.render(p1) --[[ Line: 15 | Upvalues: Roact (ref), v1 (copy), v2 (copy), v3 (copy) ]]
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
					[Roact.Ref] = v1
				},
				{
					title = "SETTINGS",
					layoutOrder = 2,
					[Roact.Ref] = v2
				},
				{
					title = "GAMEMODES",
					tabColor = Color3.new(0/255, 0/255, 255/255),
					layoutOrder = 3,
					[Roact.Ref] = v3
				}
			},
			color = Color3.fromRGB(252, 40, 47),
			currentPage = p1.state.currentPage,
			updatePage = function(p12) --[[ Name: updatePage | Line: 42 | Upvalues: p1 (copy) ]]
				p1:setState({
					currentPage = p12
				})
			end
		})
	end
	local v5 = Roact.mount(Roact.createElement(v4), p1)
	return function() --[[ Line: 50 | Upvalues: Roact (ref), v5 (copy) ]]
		Roact.unmount(v5)
	end
end