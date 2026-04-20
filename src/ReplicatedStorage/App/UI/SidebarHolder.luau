local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("SidebarHolder")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 12
    arg1:setState({
        counter = 0;
    })
    arg1._maid = Maid_upvr.new()
end
local BigButtonService_upvr = require(ReplicatedStorage.App.BigButtonService)
function any_extend_result1.didMount(arg1) -- Line 18
    arg1._maid:GiveTask(BigButtonService_upvr.triggerUpdate:Connect(function() -- Line 19
        arg1:_fetchState()
    end))
end
function any_extend_result1._fetchState(arg1) -- Line 23
    arg1:setState({
        counter = arg1.state.counter + 1;
    })
end
local createElement_upvr = Roact.createElement
local BigButton_upvr = require(script.Parent.BigButton)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 28
    local module = {}
    for i, v in ipairs(arg1.props.buttons) do
        module[v.name] = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Visible = v.enabled;
            LayoutOrder = v.displayOrder or i;
        }, {
            [v.name] = createElement_upvr(BigButton_upvr, {
                imageId = v.imageId;
                imageScale = v.imageScale;
                count = v.count;
                onClick = v.onClick;
                enabled = v.enabled;
                ref = v.ref;
                displayOrder = v.displayOrder or i;
                color = arg1.props.color;
                size = UDim2.new(0.9, 0, 0.9, 0);
            });
        })
    end
    return createElement_upvr("Frame", {
        Visible = arg1.props.enabled;
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        LayoutOrder = arg1.props.displayOrder;
    }, Dictionary_upvr.merge({
        GridLayout = createElement_upvr("UIGridLayout", {
            CellSize = UDim2.new(0.5, 0, 1, 0);
            CellPadding = UDim2.new(0, 0, 0, 0);
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            VerticalAlignment = Enum.VerticalAlignment.Bottom;
            StartCorner = Enum.StartCorner.BottomRight;
            SortOrder = Enum.SortOrder.LayoutOrder;
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2;
        });
    }, module))
end
function any_extend_result1.willUnmount(arg1) -- Line 77
    arg1._maid:DoCleaning()
end
return any_extend_result1