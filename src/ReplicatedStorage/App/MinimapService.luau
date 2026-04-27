local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local MinimapConsts = require(ReplicatedStorage.App.MinimapConsts)
local store = require(ReplicatedStorage.App.store)
local module = {}
local mapImageColor3Binding, updateMapImageColor3 = Roact.createBinding(Color3.new(255/255, 255/255, 255/255))
module.mapImageColor3 = mapImageColor3Binding
module.updateMapImageColor3 = updateMapImageColor3
local mapWorldPositionBinding, updateMapWorldPosition = Roact.createBinding(Vector3.new(0, 0, 0))
module.mapWorldPosition = mapWorldPositionBinding
module.mapUpdateWorldPosition = updateMapWorldPosition
local mapWorldDirectionBinding, updateMapWorldDirection = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
module.mapWorldDirection = mapWorldDirectionBinding
module.mapUpdateWorldDirection = updateMapWorldDirection
function module.init()
	waitForChild(ReplicatedStorage, MinimapConsts.ADD_WAYPOINT_REMOTE_NAME):andThen(function(addWaypointRemote)
		addWaypointRemote.OnClientEvent:Connect(module.addWaypoint)
		module._addWaypointRemote = addWaypointRemote
	end)
	waitForChild(ReplicatedStorage, MinimapConsts.REMOVE_WAYPOINT_REMOTE_NAME):andThen(function(removeWaypointRemote)
		removeWaypointRemote.OnClientEvent:Connect(module.removeWaypointByName)
	end)
end
function module.add(point)
	assert(point.name ~= nil, "minimap point missing unique name")
	store:dispatch({
		type = "addMinimapPoint",
		point = point
	})
	return function()
		store:dispatch({
			type = "removeMinimapPoint",
			name = point.name
		})
	end
end
function module.addCircle(circle)
	assert(circle.name ~= nil, "minimap circle missing unique name")
	store:dispatch({
		type = "addMinimapCircle",
		circle = circle
	})
	return function()
		store:dispatch({
			type = "removeMinimapCircle",
			name = circle.name
		})
	end
end
function module.addWaypoint(waypoint)
	store:dispatch(Dictionary.merge({
		type = "addWaypoint"
	}, waypoint))
	return function()
		return module.removeWaypointByName(waypoint.name)
	end
end
function module.removeWaypointByName(name)
	store:dispatch({
		type = "removeWaypointByName",
		name = name
	})
end
return module
