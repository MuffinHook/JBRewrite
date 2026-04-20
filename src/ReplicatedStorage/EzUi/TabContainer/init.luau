local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TabContainer")
any_extend_result1.defaultProps = {
    size = UDim2.new(0.5, 0, 0.5, 0);
    isSmallScreen = true;
}
function any_extend_result1.init(arg1) -- Line 18
    arg1.pageLayoutRef = Roact_upvr.createRef()
    arg1.data = {}
end
local Maid_upvr = require(EzUi.Parent.Std.Maid)
local AccelTween_upvr = require(EzUi.Parent.Std.AccelTween)
local RunService_upvr = game:GetService("RunService")
local createElement_upvr = Roact_upvr.createElement
local TabPage_upvr = require(script.TabPage)
local Tab_upvr = require(script.Tab)
local ColorUtils_upvr = require(EzUi.Parent.Std.ColorUtils)
local Dictionary_upvr = require(EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 22
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var21
    if arg1.props.isSmallScreen then
        var21 = 1
    else
        var21 = 4
    end
    local tbl_3 = {}
    local len = #arg1.props.pages
    for _, v_upvr in ipairs(arg1.props.pages) do
        local currentPage = arg1.props.currentPage
        if currentPage then
            if v_upvr[Roact_upvr.Ref]:getValue() ~= arg1.props.currentPage then
                currentPage = false
            else
                currentPage = true
            end
        end
        if currentPage then
        else
        end
        local var28 = (1 + 0) / (len + 0.1)
        if not arg1.data[v_upvr.title] then
            local tbl_2_upvw = {}
            arg1.data[v_upvr.title] = tbl_2_upvw
            tbl_2_upvw.maid = Maid_upvr.new()
            local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(var28)
            tbl_2_upvw.scaleXBinding = any_createBinding_result1
            tbl_2_upvw.updateScaleXBinding = any_createBinding_result2
            tbl_2_upvw.scaleXAccelTween = AccelTween_upvr.new(15)
            tbl_2_upvw.scaleXAccelTween.p = var28
        end
        tbl_2_upvw.scaleXAccelTween.t = var28
        tbl_2_upvw.maid.scaleXUpdate = RunService_upvr.Heartbeat:Connect(function() -- Line 42
            if tbl_2_upvw.scaleXAccelTween.rtime == 0 then
                tbl_2_upvw.maid.scaleXUpdate = nil
            end
            tbl_2_upvw.updateScaleXBinding(tbl_2_upvw.scaleXAccelTween.p)
        end)
        tbl_3[v_upvr.title] = createElement_upvr(TabPage_upvr, {
            [Roact_upvr.Ref] = v_upvr[Roact_upvr.Ref];
            layoutOrder = v_upvr.layoutOrder;
            backgroundColor = v_upvr.backgroundColor;
            backgroundTransparency = v_upvr.backgroundTransparency;
            [Roact_upvr.Children] = v_upvr[Roact_upvr.Children];
        })
        ;({})[v_upvr.title] = createElement_upvr(Tab_upvr, {
            backgroundColor = arg1.props.color;
            title = v_upvr.title;
            scaleXBinding = tbl_2_upvw.scaleXBinding;
            paddingX = math.ceil(var21 * (1 / len + 1));
            active = currentPage;
            layoutOrder = v_upvr.layoutOrder;
            onClick = function() -- Line 66, Named "onClick"
                local any_getValue_result1 = v_upvr[Roact_upvr.Ref]:getValue()
                if arg1.props.currentPage ~= any_getValue_result1 then
                    arg1.props.updatePage(any_getValue_result1)
                end
            end;
        })
    end
    if arg1.props.isSmallScreen then
        local _ = 0.1
    else
    end
    local module = {}
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    module.Tabs = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = ColorUtils_upvr.brightenTo(arg1.props.color, 0.3);
        BackgroundTransparency = 0;
        Size = UDim2.new(1, 0, 0.05, 0);
    }, Dictionary_upvr.merge({
        Padding = createElement_upvr("UIPadding", {
            PaddingTop = UDim.new(0, var21);
            PaddingBottom = UDim.new(0, var21);
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
        Layout = createElement_upvr("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder;
            VerticalAlignment = Enum.VerticalAlignment.Center;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            FillDirection = Enum.FillDirection.Horizontal;
            Padding = UDim.new(0, var21);
        });
    }, {}))
    local tbl = {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl.Position = UDim2.new(0, 0, 0.05, var21)
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl.Size = UDim2.new(1, 0, 1 - 0.05, -var21)
    module.Container = createElement_upvr("Frame", tbl, Dictionary_upvr.merge({
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
        PageLayout = createElement_upvr("UIPageLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder;
            EasingStyle = Enum.EasingStyle.Quad;
            TweenTime = 0.2;
            [Roact_upvr.Change.CurrentPage] = function(arg1_2) -- Line 128
                local CurrentPage = arg1_2.CurrentPage
                if arg1.props.currentPage ~= CurrentPage then
                    arg1.props.updatePage(CurrentPage)
                end
            end;
            [Roact_upvr.Ref] = arg1.pageLayoutRef;
        });
    }, tbl_3))
    return createElement_upvr("Frame", {
        Visible = arg1.props.visible;
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        ClipsDescendants = true;
    }, module)
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 140
    if arg1.props.currentPage ~= arg3.currentPage and arg1.pageLayoutRef:getValue().CurrentPage ~= arg1.props.currentPage then
        arg1.pageLayoutRef:getValue():JumpTo(arg1.props.currentPage)
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 147
    for _, v_2 in pairs(arg1.data) do
        v_2.maid:DoCleaning()
    end
    table.clear(arg1.data)
end
return any_extend_result1