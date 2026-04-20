local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local mansionRobberyStore_upvr = require(ReplicatedStorage_upvr.MansionRobbery.mansionRobberyStore)
    function any_extend_result1.init(arg1_2) -- Line 9
        mansionRobberyStore_upvr:dispatch({
            type = "setDialogueText";
            text = "hello, world!";
        })
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0.4)
        arg1_2.pctClosed = any_createBinding_result1
        arg1_2.updatePctClosed = any_createBinding_result2
    end
    local MansionRobberyApp_upvr = require(script.Parent.MansionRobberyApp)
    function any_extend_result1.render(arg1_3) -- Line 16
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = mansionRobberyStore_upvr;
        }, {Roact_upvr.createElement(MansionRobberyApp_upvr, {
            pctClosed = arg1_3.pctClosed;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 27
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end