local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils_upvr = require(ReplicatedStorage.EzUi.EzUtils)
local Roact = require(ReplicatedStorage.Roact)
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local any_extend_result1 = Roact.PureComponent:extend("TooltipContainer")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 27
    arg1:setState({
        smallScreen = EzUtils_upvr.isSmallScreen();
        touchControls = InputUtils_upvr.isTouch();
    })
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
local Tooltip_upvr = require(script.Parent.Tooltip)
function any_extend_result1.render(arg1) -- Line 34
    local module = {
        UIListLayout1 = createElement_upvr("UIListLayout", {
            Padding = UDim.new(0.01, 0);
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            VerticalAlignment = Enum.VerticalAlignment.Bottom;
        });
        UIPadding = createElement_upvr("UIPadding", {
            PaddingBottom = UDim.new(0.01, 0);
        });
    }
    local tbl = {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        BackgroundTransparency = 1;
        LayoutOrder = 3;
    }
    local var15 = 0.2
    tbl.Position = UDim2.fromScale(var15, 0)
    if arg1.state.smallScreen or arg1.state.touchControls then
        var15 = 0.7
    else
        var15 = 0.4
    end
    tbl.Size = UDim2.fromScale(var15, 1)
    module.Container = createElement_upvr("Frame", tbl, {
        UIListLayout = createElement_upvr("UIListLayout", {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            VerticalAlignment = Enum.VerticalAlignment.Center;
        });
        UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 12;
            AspectType = Enum.AspectType.ScaleWithParentSize;
        });
    })
    module.TooltipContainer = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        LayoutOrder = 2;
        Size = UDim2.fromScale(1, 1);
    }, {
        Tooltip = createElement_upvr(Tooltip_upvr, arg1.props);
    })
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
    }, module)
end
function any_extend_result1.didMount(arg1) -- Line 81
    arg1.maid:GiveTask(EzUtils_upvr.getViewportSizeChangedSignal():Connect(function() -- Line 82
        local any_isSmallScreen_result1 = EzUtils_upvr.isSmallScreen()
        local any_isTouch_result1 = InputUtils_upvr.isTouch()
        if any_isSmallScreen_result1 ~= arg1.state.smallScreen or any_isTouch_result1 ~= arg1.state.touchControls then
            arg1:setState({
                smallScreen = any_isSmallScreen_result1;
                touchControls = any_isTouch_result1;
            })
        end
    end))
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 94
    local module_2 = {
        text = arg1.tooltipConfig.text;
    }
    local visible = arg2.visible
    if visible then
        visible = arg1.tooltipConfig
        visible = visible.visible
    end
    module_2.visible = visible
    return module_2
end)(any_extend_result1)