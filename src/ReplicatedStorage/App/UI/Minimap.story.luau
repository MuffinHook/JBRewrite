local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(container)
	local AppComponent = Roact.Component:extend("App")
	require(ReplicatedStorage.App.store)
	local Minimap = require(script.Parent.Minimap)
	function AppComponent.init(self)
		self:setState({
			waypoint = Vector3.new(0, 0, 0)
		})
		local worldPositionBinding, updateWorldPosition = Roact.createBinding(Vector3.new(567, 0, 89))
		self.worldPosition = worldPositionBinding
		self.updateWorldPosition = updateWorldPosition
		local worldDirectionBinding, updateWorldDirection = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
		self.worldDirection = worldDirectionBinding
		self.updateWorldDirection = updateWorldDirection
		self.points = {
			{
				name = "badcc",
				part = workspace.Teams.Police_Military,
				flash = false,
				color = Color3.new(255/255, 0/255, 0/255)
			},
			{
				name = "x",
				position = Vector3.new(0, 0, 0),
				worldRadius = 4000
			}
		}
	end
	local waypointLabels = {
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
	local battlePositionBinding, _ = Roact.createBinding(Vector3.new(900, 0, 900))
	local battleRadiusBinding, _2 = Roact.createBinding(2048)
	local circleMarkers = {
		{
			name = "battleRoyale",
			worldPositionBinding = battlePositionBinding,
			worldRadiusBinding = battleRadiusBinding,
			color = Color3.fromRGB(155, 31, 232),
			transparency = 0.3
		}
	}
	function AppComponent.render(self)
		return Roact.createElement(Minimap, {
			mapImageId = 86921803889926,
			mapWorldWidth = 9984,
			mapWorldHeight = 9984,
			mapWorldCenterX = 169,
			mapWorldCenterY = -1550,
			mapImageWidth = 1024,
			mapImageHeight = 1024,
			worldPosition = self.worldPosition,
			worldDirection = self.worldDirection,
			points = self.points,
			numPoints = #self.points,
			labels = waypointLabels,
			circles = circleMarkers,
			waypoint = self.state.waypoint,
			color = Color3.new(255/255, 0/255, 0/255),
			onSetWaypoint = function(waypointPosition)
				self:setState({
					waypoint = waypointPosition
				})
			end
		})
	end
	function AppComponent.willUnmount(self)end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), container)
	return function()
		Roact.unmount(mountedComponent)
	end
end