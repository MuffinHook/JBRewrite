local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(container)
	local AppComponent = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local BigMinimap = require(script.Parent.BigMinimap)
	function AppComponent.init(component)
		local worldPositionValue, updateWorldPosition = Roact.createBinding(Vector3.new(2567, 0, 89))
		component.worldPosition = worldPositionValue
		component.updateWorldPosition = updateWorldPosition
		local worldDirectionValue, updateWorldDirection = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
		component.worldDirection = worldDirectionValue
		component.updateWorldDirection = updateWorldDirection
		component.points = {
			{
				name = "badcc",
				part = workspace.Teams.Police_Military,
				flash = false,
				color = Color3.new(255/255, 0/255, 0/255)
			}
		}
	end
	local waypointLocations = {
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
	function AppComponent.render(component)
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
				worldPosition = component.worldPosition,
				worldDirection = component.worldDirection,
				points = component.points,
				numPoints = #component.points,
				labels = waypointLocations,
				size = UDim2.new(1, 0, 0.75, 0),
				color = Color3.new(255/255, 0/255, 0/255),
				onSetWaypoint = function(waypoint)
					component:setState({
						waypoint = waypoint
					})
				end
			}) })
	end
	function AppComponent.willUnmount(component)end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), container)
	return function()
		Roact.unmount(mountedComponent)
	end
end