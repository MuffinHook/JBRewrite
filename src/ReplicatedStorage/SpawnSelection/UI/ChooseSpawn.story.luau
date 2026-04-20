local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    store_upvr:dispatch({
        type = "setSpawnSelectionOfferVisible";
        visible = true;
    })
    store_upvr:dispatch({
        type = "setLastDiedAt";
        lastDiedAt = workspace:GetServerTimeNow();
    })
    local ChooseSpawn_upvr = require(script.Parent.ChooseSpawn)
    function any_extend_result1.render(arg1_3) -- Line 18
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(ChooseSpawn_upvr, {})})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 25
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 28
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end