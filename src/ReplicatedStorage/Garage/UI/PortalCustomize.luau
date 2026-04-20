local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("PortalCustomize")
local createElement_upvr = Roact.createElement
local PortalBase_upvr = require(script.Parent.PortalBase)
function any_extend_result1.render(arg1) -- Line 11
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local ipairs_result1, ipairs_result2, ipairs_result3 = ipairs(arg1.props.categories)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [20.8]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [20.2147483650]
    if nil == arg1.props.category then
        for _, v in ipairs(arg1.props.receipt) do
            ({})[v.category..v.name] = true
            local _
        end
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 92
    return {
        category = arg1.garageCategory;
        categories = arg1.garageCategories;
        receipt = arg1.garageReceipt;
        favorited = arg1.garageFavorited;
    }
end, function(arg1) -- Line 100
    return {
        onSelectItem = function(arg1_2, arg2, arg3, arg4) -- Line 102, Named "onSelectItem"
            if Players_upvr.LocalPlayer and Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                    Volume = 0.25;
                })
            end
            if arg3.onItemSelected then
                arg3.onItemSelected()
            end
            local tbl = {
                type = "addReceiptItem";
            }
            tbl.category = arg1_2
            tbl.categoryTitle = arg2
            tbl.name = arg3.name
            tbl.title = arg3.title
            tbl.price = arg3.price
            tbl.limited = arg3.limited
            arg1(tbl)
            if arg4.owned then
                local tbl_2 = {
                    type = "setCategoryEquipped";
                }
                tbl_2.category = arg1_2
                tbl_2.name = arg3.name
                arg1(tbl_2)
            end
        end;
        onFavoriteItem = function(arg1_3, arg2, arg3) -- Line 126, Named "onFavoriteItem"
            local tbl_3 = {
                type = "setCategoryItemFavorited";
            }
            tbl_3.category = arg1_3
            tbl_3.name = arg2
            tbl_3.favorited = arg3
            arg1(tbl_3)
        end;
    }
end)(any_extend_result1)