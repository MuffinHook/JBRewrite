local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    local JoinOrCreate_upvr = require(script.Parent.JoinOrCreate)
    function any_extend_result1.render(arg1_3) -- Line 11
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(JoinOrCreate_upvr, {
            aspectRatio = 1.7777777777777777;
            verticalPaddingRatio = 128;
        }, {
            AspectRatioConstraint = Roact_upvr.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1.7777777777777777;
            });
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 27
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end