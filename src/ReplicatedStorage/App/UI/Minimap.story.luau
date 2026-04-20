local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
        arg1_2:setState({
            waypoint = Vector3.new(0, 0, 0);
        })
        local any_createBinding_result1_3, any_createBinding_result2 = Roact_upvr.createBinding(Vector3.new(567, 0, 89))
        arg1_2.worldPosition = any_createBinding_result1_3
        arg1_2.updateWorldPosition = any_createBinding_result2
        local any_createBinding_result1, any_createBinding_result2_3 = Roact_upvr.createBinding(Vector3.new(1, 0, 1).Unit)
        arg1_2.worldDirection = any_createBinding_result1
        arg1_2.updateWorldDirection = any_createBinding_result2_3
        arg1_2.points = {{
            name = "badcc";
            part = workspace.Teams.Police_Military;
            flash = false;
            color = Color3.new(1, 0, 0);
        }, {
            name = 'x';
            position = Vector3.new(0, 0, 0);
            worldRadius = 4000;
        }}
    end
    local tbl_upvr = {{
        title = "CITY";
        position = Vector3.new(20.8199, 17.4200, 1063.76);
    }, {
        title = "Bank";
        imageId = 4643749317;
        position = Vector3.new(500, 0, -250);
        markerColor = Color3.new(1, 0, 0);
    }}
    local any_createBinding_result1_2, any_createBinding_result2_2 = Roact_upvr.createBinding(Vector3.new(900, 0, 900))
    local any_createBinding_result1_4, _ = Roact_upvr.createBinding(2048)
    local tbl_2_upvr = {{
        name = "battleRoyale";
        worldPositionBinding = any_createBinding_result1_2;
        worldRadiusBinding = any_createBinding_result1_4;
        color = Color3.fromRGB(155, 31, 232);
        transparency = 0.3;
    }}
    local Minimap_upvr = require(script.Parent.Minimap)
    function any_extend_result1.render(arg1_3) -- Line 54
        return Roact_upvr.createElement(Minimap_upvr, {
            mapImageId = 86921803889926;
            mapWorldWidth = 9984;
            mapWorldHeight = 9984;
            mapWorldCenterX = 169;
            mapWorldCenterY = -1550;
            mapImageWidth = 1024;
            mapImageHeight = 1024;
            worldPosition = arg1_3.worldPosition;
            worldDirection = arg1_3.worldDirection;
            points = arg1_3.points;
            numPoints = #arg1_3.points;
            labels = tbl_upvr;
            circles = tbl_2_upvr;
            waypoint = arg1_3.state.waypoint;
            color = Color3.new(1, 0, 0);
            onSetWaypoint = function(arg1_4) -- Line 75, Named "onSetWaypoint"
                local tbl = {}
                tbl.waypoint = arg1_4
                arg1_3:setState(tbl)
            end;
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 82
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 85
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end