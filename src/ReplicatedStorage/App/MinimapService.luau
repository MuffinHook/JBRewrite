local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage_upvr.Roact)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local module_upvr = {}
local any_createBinding_result1, any_createBinding_result2_2 = Roact.createBinding(Color3.new(1, 1, 1))
module_upvr.mapImageColor3 = any_createBinding_result1
module_upvr.updateMapImageColor3 = any_createBinding_result2_2
local any_createBinding_result1_2, any_createBinding_result2 = Roact.createBinding(Vector3.new(0, 0, 0))
module_upvr.mapWorldPosition = any_createBinding_result1_2
module_upvr.mapUpdateWorldPosition = any_createBinding_result2
local any_createBinding_result1_3, any_createBinding_result2_3 = Roact.createBinding(Vector3.new(1, 0, 1).Unit)
module_upvr.mapWorldDirection = any_createBinding_result1_3
module_upvr.mapUpdateWorldDirection = any_createBinding_result2_3
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local MinimapConsts_upvr = require(ReplicatedStorage_upvr.App.MinimapConsts)
function module_upvr.init() -- Line 15
    waitForChild_upvr(ReplicatedStorage_upvr, MinimapConsts_upvr.ADD_WAYPOINT_REMOTE_NAME):andThen(function(arg1) -- Line 16
        arg1.OnClientEvent:Connect(module_upvr.addWaypoint)
        module_upvr._addWaypointRemote = arg1
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, MinimapConsts_upvr.REMOVE_WAYPOINT_REMOTE_NAME):andThen(function(arg1) -- Line 20
        arg1.OnClientEvent:Connect(module_upvr.removeWaypointByName)
    end)
end
function module_upvr.add(arg1) -- Line 24
    local var15
    if arg1.name == nil then
        var15 = false
    else
        var15 = true
    end
    assert(var15, "minimap point missing unique name")
    local tbl_3 = {
        type = "addMinimapPoint";
    }
    tbl_3.point = arg1
    store_upvr:dispatch(tbl_3)
    return function() -- Line 30
        store_upvr:dispatch({
            type = "removeMinimapPoint";
            name = arg1.name;
        })
    end
end
function module_upvr.addCircle(arg1) -- Line 38
    local var19
    if arg1.name == nil then
        var19 = false
    else
        var19 = true
    end
    assert(var19, "minimap circle missing unique name")
    local tbl_2 = {
        type = "addMinimapCircle";
    }
    tbl_2.circle = arg1
    store_upvr:dispatch(tbl_2)
    return function() -- Line 44
        store_upvr:dispatch({
            type = "removeMinimapCircle";
            name = arg1.name;
        })
    end
end
local Dictionary_upvr = require(ReplicatedStorage_upvr.Std.Dictionary)
function module_upvr.addWaypoint(arg1) -- Line 51
    store_upvr:dispatch(Dictionary_upvr.merge({
        type = "addWaypoint";
    }, arg1))
    return function() -- Line 56
        return module_upvr.removeWaypointByName(arg1.name)
    end
end
function module_upvr.removeWaypointByName(arg1) -- Line 60
    local tbl = {
        type = "removeWaypointByName";
    }
    tbl.name = arg1
    store_upvr:dispatch(tbl)
end
return module_upvr