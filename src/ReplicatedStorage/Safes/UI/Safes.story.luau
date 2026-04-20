local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    function any_extend_result1.init(arg1_2) -- Line 9
        store_upvr:dispatch({
            type = "setSafesInventoryItems";
            itemsOwned = {{
                Id = "a1";
                ItemType = "Safe";
                TypeEnum = 1;
            }, {
                Id = "a2";
                ItemType = "Safe";
                TypeEnum = 1;
            }, {
                Id = "a3";
                ItemType = "Safe";
                TypeEnum = 1;
            }, {
                Id = "a4";
                ItemType = "Safe";
                TypeEnum = 2;
            }, {
                Id = "a5";
                ItemType = "Safe";
                TypeEnum = 1;
            }, {
                Id = "a6";
                ItemType = "Safe";
                TypeEnum = 2;
            }, {
                Id = "a7";
                ItemType = "Safe";
                TypeEnum = 1;
            }, {
                Id = "a8";
                ItemType = "Safe";
                TypeEnum = 1;
            }, {
                Id = "a9";
                ItemType = "Safe";
                TypeEnum = 1;
            }};
        })
        store_upvr:dispatch({
            type = "setSafesOpen";
            value = true;
        })
    end
    local Safes_upvr = require(script.Parent.Safes)
    function any_extend_result1.render(arg1_3) -- Line 65
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(Safes_upvr, {
            size = UDim2.new(0.9, 0, 0.9, 0);
            position = UDim2.new(0.5, 0, 0.5, 0);
            anchorPoint = Vector2.new(0.5, 0.5);
            policyCashAvailable = 100000000;
        })})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 77
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 80
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end