local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    store_upvr:dispatch({
        type = "setLocalVehiclePacket";
        packet = {
            Model = ReplicatedStorage_upvr.Resource.Vehicles.Chiron:Clone();
            Make = "Chiron";
            Type = "Chassis";
        };
    })
    store_upvr:dispatch({
        type = "setSort";
        id = 3;
    })
    store_upvr:dispatch({
        type = "setPage";
        pageName = "Customize";
        categoryName = "Texture";
        sortId = store_upvr:getState().garageSort;
    })
    store_upvr:dispatch({
        type = "setInVehicle";
        inVehicle = true;
    })
    store_upvr:dispatch({
        type = "setInPhysical";
        inPhysical = true;
    })
    for i = 1, 11 do
        store_upvr:dispatch({
            type = "addReceiptItem";
            name = "name"..tostring(i);
            title = "title"..tostring(i);
            category = "category"..tostring(i);
            categoryTitle = "categoryTitle"..tostring(i);
        })
    end
    function any_extend_result1.init(arg1_2) -- Line 49
        arg1_2.maid = Maid_upvr.new()
    end
    local os_clock_result1_upvr = os.clock()
    function any_extend_result1.render(arg1_3) -- Line 53
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(require(script.Parent.Garage), {
            disabled = false;
            attemptBuyItem = function(arg1_4, arg2) -- Line 59, Named "attemptBuyItem"
                local tbl = {
                    type = "setCategoryItemOwned";
                }
                tbl.category = arg1_4
                tbl.name = arg2
                store_upvr:dispatch(tbl)
            end;
            getRemainingDebounce = function() -- Line 66, Named "getRemainingDebounce"
                return (10) - (os.clock() - os_clock_result1_upvr)
            end;
            colsPerRow = 7;
            rowsPerPage = 2.5;
        })})
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 74
        arg1_5.maid:Destroy()
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 79
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end