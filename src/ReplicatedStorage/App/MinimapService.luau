local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local MinimapConsts = require(ReplicatedStorage.App.MinimapConsts)
local store = require(ReplicatedStorage.App.store)
local t = {}
local v1, v2 = Roact.createBinding(Color3.new(255/255, 255/255, 255/255))
t.mapImageColor3 = v1
t.updateMapImageColor3 = v2
local v3, v4 = Roact.createBinding(Vector3.new(0, 0, 0))
t.mapWorldPosition = v3
t.mapUpdateWorldPosition = v4
local v5, v6 = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
t.mapWorldDirection = v5
t.mapUpdateWorldDirection = v6
function t.init() --[[ Line: 15 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), MinimapConsts (copy), t (copy) ]]
	waitForChild(ReplicatedStorage, MinimapConsts.ADD_WAYPOINT_REMOTE_NAME):andThen(function(p1) --[[ Line: 16 | Upvalues: t (ref) ]]
		p1.OnClientEvent:Connect(t.addWaypoint)
		t._addWaypointRemote = p1
	end)
	waitForChild(ReplicatedStorage, MinimapConsts.REMOVE_WAYPOINT_REMOTE_NAME):andThen(function(p1) --[[ Line: 20 | Upvalues: t (ref) ]]
		p1.OnClientEvent:Connect(t.removeWaypointByName)
	end)
end
function t.add(p1) --[[ Line: 24 | Upvalues: store (copy) ]]
	assert(p1.name ~= nil, "minimap point missing unique name")
	store:dispatch({
		type = "addMinimapPoint",
		point = p1
	})
	return function() --[[ Line: 30 | Upvalues: store (ref), p1 (copy) ]]
		store:dispatch({
			type = "removeMinimapPoint",
			name = p1.name
		})
	end
end
function t.addCircle(p1) --[[ Line: 38 | Upvalues: store (copy) ]]
	assert(p1.name ~= nil, "minimap circle missing unique name")
	store:dispatch({
		type = "addMinimapCircle",
		circle = p1
	})
	return function() --[[ Line: 44 | Upvalues: store (ref), p1 (copy) ]]
		store:dispatch({
			type = "removeMinimapCircle",
			name = p1.name
		})
	end
end
function t.addWaypoint(p1) --[[ Line: 51 | Upvalues: store (copy), Dictionary (copy), t (copy) ]]
	store:dispatch(Dictionary.merge({
		type = "addWaypoint"
	}, p1))
	return function() --[[ Line: 56 | Upvalues: t (ref), p1 (copy) ]]
		return t.removeWaypointByName(p1.name)
	end
end
function t.removeWaypointByName(p1) --[[ Line: 60 | Upvalues: store (copy) ]]
	store:dispatch({
		type = "removeWaypointByName",
		name = p1
	})
end
return t