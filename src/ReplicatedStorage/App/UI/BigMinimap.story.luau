-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local BigMinimap = require(script.Parent.BigMinimap)
	function v1.init(p1)
		local v1, v2 = Roact.createBinding(Vector3.new(2567, 0, 89))
		p1.worldPosition = v1
		p1.updateWorldPosition = v2
		local v3, v4 = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
		p1.worldDirection = v3
		p1.updateWorldDirection = v4
		p1.points = {
			{
				name = "badcc",
				part = workspace.Teams.Police_Military,
				flash = false,
				color = Color3.new(255/255, 0/255, 0/255)
			}
		}
	end
	local t = {
		{
			title = "CITY",
			position = Vector3.new(20.82, 17.42, 1063.76)
		},
		{
			title = "Bank",
			imageId = 4643749317,
			position = Vector3.new(500, 0, -250),
			markerColor = Color3.new(255/255, 0/255, 0/255)
		}
	}
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(BigMinimap, {
				mapImageId = 8795797298,
				mapWorldWidth = 7168,
				mapWorldHeight = 7168,
				mapWorldCenterX = -16,
				mapWorldCenterY = 1536,
				mapImageWidth = 1024,
				mapImageHeight = 1024,
				worldPosition = p1.worldPosition,
				worldDirection = p1.worldDirection,
				points = p1.points,
				numPoints = #p1.points,
				labels = t,
				size = UDim2.new(1, 0, 0.75, 0),
				color = Color3.new(255/255, 0/255, 0/255),
				onSetWaypoint = function(p12)
					p1:setState({
						waypoint = p12
					})
				end
			}) })
	end
	function v1.willUnmount(p1)end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end