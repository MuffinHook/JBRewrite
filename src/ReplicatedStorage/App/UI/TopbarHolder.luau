local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("TopbarHolder")
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
    local tbl = {}
    for i, v in ipairs(arg1.props.buttons) do
        tbl[v.name] = createElement_upvr(BigButton_upvr, {
            imageId = v.imageId;
            imageScale = v.imageScale;
            count = v.count;
            onClick = v.onClick;
            enabled = v.enabled;
            ref = v.ref;
            displayOrder = v.displayOrder or i;
            color = arg1.props.color;
        })
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 0.7, 0);
        Position = UDim2.fromScale(0, 0.5);
        AnchorPoint = Vector2.new(0, 0.5);
    }, {
        Padding = createElement_upvr("UIPadding", {
            PaddingLeft = UDim.new(0, 4);
            PaddingRight = UDim.new(0, 4);
            PaddingTop = UDim.new(0, 4);
        });
        Left = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
        }, Dictionary_upvr.merge({
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                VerticalAlignment = Enum.VerticalAlignment.Center;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Horizontal;
                Padding = UDim.new(0, 4);
            });
        }, {}));
        Right = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
        }, Dictionary_upvr.merge({
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                VerticalAlignment = Enum.VerticalAlignment.Center;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Horizontal;
                Padding = UDim.new(0, 8);
            });
        }, tbl));
    })
end
function any_extend_result1.willUnmount(arg1) -- Line 94
    arg1._maid:DoCleaning()
end
return any_extend_result1