-- Reviewed by Claude
-- variables reassigned
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
	waitForChild(ReplicatedStorage, MinimapConsts.ADD_WAYPOINT_REMOTE_NAME):andThen(function(p1)
		p1.OnClientEvent:Connect(module.addWaypoint)
		module._addWaypointRemote = p1
	end)
	waitForChild(ReplicatedStorage, MinimapConsts.REMOVE_WAYPOINT_REMOTE_NAME):andThen(function(p1)
		p1.OnClientEvent:Connect(module.removeWaypointByName)
	end)
end
function module.add(p1)
	assert(p1.name ~= nil, "minimap point missing unique name")
	store:dispatch({
		type = "addMinimapPoint",
		point = p1
	})
	return function()
		store:dispatch({
			type = "removeMinimapPoint",
			name = p1.name
		})
	end
end
function module.addCircle(p1)
	assert(p1.name ~= nil, "minimap circle missing unique name")
	store:dispatch({
		type = "addMinimapCircle",
		circle = p1
	})
	return function()
		store:dispatch({
			type = "removeMinimapCircle",
			name = p1.name
		})
	end
end
function module.addWaypoint(p1)
	store:dispatch(Dictionary.merge({
		type = "addWaypoint"
	}, p1))
	return function()
		return module.removeWaypointByName(p1.name)
	end
end
function module.removeWaypointByName(p1)
	store:dispatch({
		type = "removeWaypointByName",
		name = p1
	})
end
return module
