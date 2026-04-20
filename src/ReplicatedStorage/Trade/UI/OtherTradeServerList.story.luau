local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local OtherTradeServerUIData_upvr = require(ReplicatedStorage_upvr.Trade.Test.OtherTradeServerUIData)
    function any_extend_result1.init(arg1_2) -- Line 11
        arg1_2.aspectRatio = 1.5
        arg1_2.otherTradeServerInfo = OtherTradeServerUIData_upvr.otherTradeServerInfo
    end
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    local OtherTradeServerList_upvr = require(script.Parent.OtherTradeServerList)
    function any_extend_result1.render(arg1_3) -- Line 16
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement("Frame", {
            Size = UDim2.fromScale(1, 1);
        }, {
            x = Roact_upvr.createElement(OtherTradeServerList_upvr, {
                otherTradeServerInfo = arg1_3.otherTradeServerInfo;
                onJoinOtherTradeServer = function(arg1_4) -- Line 25, Named "onJoinOtherTradeServer"
                    print("CLICK.. join server id", arg1_4)
                end;
                aspectRatio = arg1_3.aspectRatio;
                visible = true;
                size = UDim2.fromScale(1, 1);
                position = UDim2.fromScale(0.5, 0.5);
            });
            Aspect = Roact_upvr.createElement("UIAspectRatioConstraint", {
                AspectRatio = arg1_3.aspectRatio;
            });
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 41
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end