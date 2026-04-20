local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    function any_extend_result1.init(arg1_2) -- Line 9
        store_upvr:dispatch({
            type = "tradeInitiationsSet";
            list = {{
                name = "badcc";
                userId = 1;
            }, {
                name = "asimo3089";
                userId = 2;
            }, {
                name = "TWENTYMOREMINUTES";
                userId = 3;
            }};
        })
    end
    local TradeInitiations_upvr = require(script.Parent.TradeInitiations)
    function any_extend_result1.render(arg1_3) -- Line 28
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(TradeInitiations_upvr, {
            onAccept = function(arg1_4) -- Line 33, Named "onAccept"
                print("accept", arg1_4)
            end;
            onDecline = function(arg1_5) -- Line 36, Named "onDecline"
                print("decline", arg1_5)
            end;
        })})
    end
    function any_extend_result1.willUnmount(arg1_6) -- Line 42
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 45
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end