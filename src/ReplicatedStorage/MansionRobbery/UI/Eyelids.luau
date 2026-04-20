local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Eyelids")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 7
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 10
    local any_map_result1 = arg1.props.pctClosed:map(function(arg1_2) -- Line 11
        return UDim2.new(1, 0, arg1_2 / 2, 0)
    end)
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundTransparency = 1;
    }, {
        Top = createElement_upvr("Frame", {
            BackgroundColor3 = Color3.new(0, 0, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            Position = UDim2.new(0.5, 0, 0, 0);
            Size = any_map_result1;
            BorderSizePixel = 0;
        });
        Bottom = createElement_upvr("Frame", {
            BackgroundColor3 = Color3.new(0, 0, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            Position = UDim2.new(0.5, 0, 1, 0);
            Size = any_map_result1;
            BorderSizePixel = 0;
        });
    })
end
function any_extend_result1.didMount(arg1) -- Line 34
end
function any_extend_result1.willUnmount(arg1) -- Line 35
    arg1.maid:DoCleaning()
end
return any_extend_result1