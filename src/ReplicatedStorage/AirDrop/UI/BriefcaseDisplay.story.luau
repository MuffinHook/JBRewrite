local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local EnumRarity_upvr = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local BriefcaseDisplay_upvr = require(script.Parent.BriefcaseDisplay)
    function any_extend_result1.render(arg1_2) -- Line 8
        return Roact_upvr.createElement(BriefcaseDisplay_upvr, {
            probs = {
                [EnumRarity_upvr.Common] = 75;
                [EnumRarity_upvr.Rare] = 20;
                [EnumRarity_upvr.UltraRare] = 5;
                [EnumRarity_upvr.Epic] = 0;
                [EnumRarity_upvr.Legendary] = 0;
            };
        })
    end
    function any_extend_result1.willUnmount(arg1_3) -- Line 19
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 22
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end