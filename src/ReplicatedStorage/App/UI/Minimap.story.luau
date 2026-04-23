local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy) ]]
	local v1 = Roact.Component:extend("App")
	require(ReplicatedStorage.App.store)
	local Minimap = require(script.Parent.Minimap)
	function v1.init(p1) --[[ Line: 9 | Upvalues: Roact (ref) ]]
		p1:setState({
			waypoint = Vector3.new(0, 0, 0)
		})
		local v1, v2 = Roact.createBinding(Vector3.new(567, 0, 89))
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
			},
			{
				name = "x",
				position = Vector3.new(0, 0, 0),
				worldRadius = 4000
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
	local v2, _ = Roact.createBinding(Vector3.new(900, 0, 900))
	local v3, _2 = Roact.createBinding(2048)
	local t2 = {
		{
			name = "battleRoyale",
			worldPositionBinding = v2,
			worldRadiusBinding = v3,
			color = Color3.fromRGB(155, 31, 232),
			transparency = 0.3
		}
	}
	function v1.render(p1) --[[ Line: 54 | Upvalues: Roact (ref), Minimap (copy), t (copy), t2 (copy) ]]
		return Roact.createElement(Minimap, {
			mapImageId = 86921803889926,
			mapWorldWidth = 9984,
			mapWorldHeight = 9984,
			mapWorldCenterX = 169,
			mapWorldCenterY = -1550,
			mapImageWidth = 1024,
			mapImageHeight = 1024,
			worldPosition = p1.worldPosition,
			worldDirection = p1.worldDirection,
			points = p1.points,
			numPoints = #p1.points,
			labels = t,
			circles = t2,
			waypoint = p1.state.waypoint,
			color = Color3.new(255/255, 0/255, 0/255),
			onSetWaypoint = function(p12) --[[ Name: onSetWaypoint | Line: 75 | Upvalues: p1 (copy) ]]
				p1:setState({
					waypoint = p12
				})
			end
		})
	end
	function v1.willUnmount(p1) --[[ Line: 82 ]] end
	local v4 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 85 | Upvalues: Roact (ref), v4 (copy) ]]
		Roact.unmount(v4)
	end
end