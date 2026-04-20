local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Board")
local createElement_upvr = Roact.createElement
local BoardEntry_upvr = require(script.Parent.BoardEntry)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 9
    local module = {}
    for i, v in ipairs(arg1.props.entries) do
        module[i] = createElement_upvr(BoardEntry_upvr, {
            rank = i;
            name = v.name;
            userId = v.userId;
            message = v.message;
        })
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
    }, Dictionary_upvr.merge({
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Top;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
        });
    }, module))
end
return any_extend_result1