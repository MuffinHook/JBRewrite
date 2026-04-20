local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("PortalSaves")
local createElement_upvr = Roact.createElement
local PortalBase_upvr = require(script.Parent.PortalBase)
function any_extend_result1.render(arg1) -- Line 11
    local tbl = {}
    local tbl_2 = {}
    for _, v in ipairs(arg1.props.receipt) do
        tbl_2[v.name] = true
    end
    for i_2 = 1, #arg1.props.items do
        local var17_upvr = arg1.props.items[i_2]
        local tbl_3 = {}
        local var19 = tbl_2[var17_upvr.name]
        tbl_3.selected = var19
        if arg1.props.saves[var17_upvr.name] == nil then
            var19 = false
        else
            var19 = true
        end
        tbl_3.filled = var19
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        tbl_3.getInstCompare = arg1.props.saves[var17_upvr.name]
        var19 = arg1.props.saves[var17_upvr.name]
        local var21 = var19
        if var21 then
            local var22_upvr = arg1.props.saves[var17_upvr.name]
            function var21() -- Line 24
                return var17_upvr.getInstForSelection(var22_upvr)
            end
        end
        tbl_3.getInst = var21
        function tbl_3.onSelect() -- Line 28
            if not var17_upvr.available then
            else
                arg1.props.onSelectItem(var17_upvr)
            end
        end
        tbl[i_2] = tbl_3
    end
    local module = {}
    var17_upvr = "SAVES"
    module.title = var17_upvr
    var17_upvr = arg1.props
    var17_upvr = var17_upvr.items
    module.items = var17_upvr
    module.metadata = tbl
    var17_upvr = arg1.props
    var17_upvr = var17_upvr.sortId
    module.sortId = var17_upvr
    var17_upvr = 5
    module.colsPerRow = var17_upvr
    var17_upvr = 2
    module.rowsPerPage = var17_upvr
    var17_upvr = arg1.props
    var17_upvr = var17_upvr.cornerPixel
    module.cornerPixel = var17_upvr
    var17_upvr = arg1.props
    var17_upvr = var17_upvr.portalRatio
    module.portalRatio = var17_upvr
    var17_upvr = arg1.props
    var17_upvr = var17_upvr.paddingRatio
    module.paddingRatio = var17_upvr
    var17_upvr = arg1.props
    var17_upvr = var17_upvr.onSelectSort
    module.onSelectSort = var17_upvr
    return createElement_upvr(PortalBase_upvr, module)
end
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 50
    return {
        receipt = arg1.garageReceipt;
    }
end, function(arg1) -- Line 54
    return {
        onSelectItem = function(arg1_2) -- Line 56, Named "onSelectItem"
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                    Volume = 0.25;
                })
            end
            arg1({
                type = "addReceiptItem";
                category = "Saves";
                categoryTitle = "Save";
                name = arg1_2.name;
                title = arg1_2.title;
                filled = arg1_2.filled;
            })
        end;
    }
end)(any_extend_result1)