local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
        local any_createBinding_result1_2, any_createBinding_result2 = Roact_upvr.createBinding(Vector3.new(2567, 0, 89))
        arg1_2.worldPosition = any_createBinding_result1_2
        arg1_2.updateWorldPosition = any_createBinding_result2
        local any_createBinding_result1, any_createBinding_result2_2 = Roact_upvr.createBinding(Vector3.new(1, 0, 1).Unit)
        arg1_2.worldDirection = any_createBinding_result1
        arg1_2.updateWorldDirection = any_createBinding_result2_2
        arg1_2.points = {{
            name = "badcc";
            part = workspace.Teams.Police_Military;
            flash = false;
            color = Color3.new(1, 0, 0);
        }}
    end
    local tbl_2_upvr = {{
        title = "CITY";
        position = Vector3.new(20.8199, 17.4200, 1063.76);
    }, {
        title = "Bank";
        imageId = 4643749317;
        position = Vector3.new(500, 0, -250);
        markerColor = Color3.new(1, 0, 0);
    }}
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    local BigMinimap_upvr = require(script.Parent.BigMinimap)
    function any_extend_result1.render(arg1_3) -- Line 34
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(BigMinimap_upvr, {
            mapImageId = 8795797298;
            mapWorldWidth = 7168;
            mapWorldHeight = 7168;
            mapWorldCenterX = -16;
            mapWorldCenterY = 1536;
            mapImageWidth = 1024;
            mapImageHeight = 1024;
            worldPosition = arg1_3.worldPosition;
            worldDirection = arg1_3.worldDirection;
            points = arg1_3.points;
            numPoints = #arg1_3.points;
            labels = tbl_2_upvr;
            size = UDim2.new(1, 0, 0.75, 0);
            color = Color3.new(1, 0, 0);
            onSetWaypoint = function(arg1_4) -- Line 56, Named "onSetWaypoint"
                local tbl = {}
                tbl.waypoint = arg1_4
                arg1_3:setState(tbl)
            end;
        })})
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 64
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 67
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end