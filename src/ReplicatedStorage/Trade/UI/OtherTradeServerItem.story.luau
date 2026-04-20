local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local OtherTradeServerUIData_upvr = require(ReplicatedStorage.Trade.Test.OtherTradeServerUIData)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
    end
    local OtherTradeServerItem_upvr = require(script.Parent.OtherTradeServerItem)
    function any_extend_result1.render(arg1_3) -- Line 9
        local _1 = OtherTradeServerUIData_upvr.otherTradeServerInfo[1]
        _1.size = UDim2.fromScale(0.8, 0.1)
        _1.verticalPaddingRatio = 128
        _1.aspectRatio = 1.7777777777777777
        return Roact_upvr.createElement(OtherTradeServerItem_upvr, _1, {
            Aspect = Roact_upvr.createElement("UIAspectRatioConstraint", {
                AspectRatio = 8;
            });
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 20
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 23
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end