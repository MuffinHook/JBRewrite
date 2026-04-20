local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    function any_extend_result1.init(arg1_2) -- Line 10
        local any_createBinding_result1, any_createBinding_result2_2 = Roact_upvr.createBinding(Vector3.new(0, 0, 0))
        arg1_2.worldPosition = any_createBinding_result1
        arg1_2.updateWorldPosition = any_createBinding_result2_2
        local any_createBinding_result1_2, any_createBinding_result2 = Roact_upvr.createBinding(Vector3.new(1, 0, 1).Unit)
        arg1_2.worldDirection = any_createBinding_result1_2
        arg1_2.updateWorldDirection = any_createBinding_result2
        local tbl_3 = {
            type = "minimapSetSpawns";
        }
        local tbl_6 = {}
        local tbl_2 = {
            name = "CrimePort";
            useParachute = true;
            position = Vector3.new(2428.20, 20.7509, -3775.4);
            backgroundColor = Color3.fromRGB(252, 40, 47);
        }
        local tbl_5 = {}
        local function map(arg1_3, arg2) -- Line 23
            return arg2(2)
        end
        tbl_5.map = map
        tbl_2.numEnemies = tbl_5
        local tbl = {
            name = "CrimBase";
            position = Vector3.new(-428.20, 20.7509, 1475.42);
            backgroundColor = Color3.fromRGB(252, 40, 47);
        }
        local tbl_4 = {}
        local function map(arg1_4, arg2) -- Line 33
            return arg2(2)
        end
        tbl_4.map = map
        tbl.numEnemies = tbl_4
        tbl_6[1] = tbl_2
        tbl_6[2] = tbl
        tbl_6[3] = {
            name = "Prison";
            locked = true;
            useParachute = true;
            markerColor = Color3.new(0, 0, 0);
            position = Vector3.new(-1315.3, 14.6840, -1675.2);
            backgroundColor = Color3.fromRGB(253, 123, 49);
            numEnemies = {
                map = function(arg1_5, arg2) -- Line 46, Named "map"
                    return arg2(2)
                end;
            };
        }
        tbl_3.spawns = tbl_6
        store_upvr:dispatch(tbl_3)
    end
    local SpawnSelection_upvr = require(script.Parent.SpawnSelection)
    function any_extend_result1.render(arg1_6) -- Line 55
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(SpawnSelection_upvr, {
            mapImageId = 11205536277;
            mapWorldWidth = 9984;
            mapWorldHeight = 9984;
            mapWorldCenterX = 169;
            mapWorldCenterY = -1550;
            mapImageWidth = 1024;
            mapImageHeight = 1024;
            worldPosition = arg1_6.worldPosition;
            worldDirection = arg1_6.worldDirection;
            size = UDim2.new(1, 0, 0.75, 0);
            color = Color3.new(1, 0, 0);
            square = true;
        })})
    end
    function any_extend_result1.willUnmount(arg1_7) -- Line 79
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 82
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end