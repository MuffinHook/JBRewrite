local module = {}
local SaleShared_upvr = require(script.Parent.SaleShared)
local store_upvr = require(game:GetService("ReplicatedStorage").App.store)
function module.init() -- Line 6
    SaleShared_upvr.onSaleRefresh:Connect(function() -- Line 7
        local any_getState_result1 = store_upvr:getState()
        store_upvr:dispatch({
            type = "setPage";
            pageName = any_getState_result1.garagePage;
            categoryName = any_getState_result1.garageCategory;
            sortId = any_getState_result1.garageSort;
        })
    end)
end
return module