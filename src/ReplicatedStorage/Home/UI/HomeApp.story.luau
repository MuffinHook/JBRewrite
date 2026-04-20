local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local homeStore_upvr = require(ReplicatedStorage_upvr.Home.homeStore)
    function any_extend_result1.init(arg1_2) -- Line 9
        homeStore_upvr:dispatch({
            type = "setVisible";
            value = true;
        })
    end
    local HomeApp_upvr = require(ReplicatedStorage_upvr.Home.UI.HomeApp)
    function any_extend_result1.render(arg1_3) -- Line 21
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = homeStore_upvr;
        }, {Roact_upvr.createElement(HomeApp_upvr, {
            aspectRatio = 3;
            verticalPaddingRatio = 128;
            attemptPlaceItem = function(...) -- Line 29, Named "attemptPlaceItem"
                print("attemptPlaceItem", ...)
            end;
            attemptPurchaseItem = function(...) -- Line 32, Named "attemptPurchaseItem"
                print("attemptPurchaseItem", ...)
            end;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 40
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end