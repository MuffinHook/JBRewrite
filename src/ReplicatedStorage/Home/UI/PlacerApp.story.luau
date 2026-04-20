local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    local homeStore_upvr = require(ReplicatedStorage_upvr.Home.homeStore)
    local PlacerApp_upvr = require(ReplicatedStorage_upvr.Home.UI.PlacerApp)
    function any_extend_result1.render(arg1_3) -- Line 11
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = homeStore_upvr;
        }, {Roact_upvr.createElement(PlacerApp_upvr, {
            aspectRatio = 5;
            verticalPaddingRatio = 25.6;
            showPlace = true;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 25
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end