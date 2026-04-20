local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local EnumRarity_upvr = require(ReplicatedStorage_upvr.RewardSpinner.EnumRarity)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    local tbl_upvr = {}
    local var11_upvw = 0
    for _ = 1, 80 do
        local tbl = {}
        local var13 = "Cash"
        tbl.Type = var13
        if 0.5 < math.random() then
            var13 = 1000
        else
            var13 = 0
        end
        tbl.Amount = var13
        tbl.RarityId = EnumRarity_upvr.Epic
        table.insert(tbl_upvr, tbl)
    end
    function any_extend_result1.init(arg1_2) -- Line 19
        store_upvr:dispatch({
            type = "setRewardSpinnerConfig";
            items = tbl_upvr;
            duration = 5;
            winIndex = 77;
            extraText = "Spin num: "..tostring(var11_upvw);
        })
    end
    local RewardSpinner_upvr = require(script.Parent.RewardSpinner)
    function any_extend_result1.render(arg1_3) -- Line 28
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(RewardSpinner_upvr, {
            onFinished = function() -- Line 33, Named "onFinished"
                var11_upvw += 1
                store_upvr:dispatch({
                    type = "setRewardSpinnerConfig";
                    items = tbl_upvr;
                    duration = 5;
                    winIndex = 77;
                    extraText = "Spin num: "..tostring(var11_upvw);
                })
            end;
        })})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 46
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 49
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end