local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local TooltipData_upvr = require(script.Parent.TooltipData)
local store_upvr = require(ReplicatedStorage.App.store)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local TooltipConsts_upvr = require(script.Parent.TooltipConsts)
function module.init() -- Line 8
    local len_upvr = #TooltipData_upvr
    local randint_from_1_upvw = math.random(len_upvr)
    Interval_upvr.every(TooltipConsts_upvr.TOOLTIP_CYCLE_INTERVAL):Connect(function() -- Line 11, Named "setTooltipConfig"
        store_upvr:dispatch({
            type = "setTooltipText";
            value = TooltipData_upvr[randint_from_1_upvw];
        })
        randint_from_1_upvw = randint_from_1_upvw % len_upvr + 1
    end)
    store_upvr:dispatch({
        type = "setTooltipText";
        value = TooltipData_upvr[randint_from_1_upvw];
    })
    randint_from_1_upvw = randint_from_1_upvw % len_upvr + 1
end
return module