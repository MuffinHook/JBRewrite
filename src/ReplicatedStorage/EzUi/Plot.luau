local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("Plot")
function any_extend_result1.init(arg1) -- Line 8
    arg1:setState({
        aspectRatio = 1;
    })
end
function any_extend_result1.CalculateAspectRatio(arg1, arg2) -- Line 13
    arg1:setState({
        aspectRatio = arg2.AbsoluteSize.Y / arg2.AbsoluteSize.X;
    })
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 18
    local window = arg1.props.window
    local _1 = window[1]
    local _2 = window[2]
    local var21 = window[3] - _1
    local var22 = window[4] - _2
    if arg1.props.lines then
        for _, v in ipairs(arg1.props.lines) do
            local var26 = (v[1] - _1) / var21
            local var27 = (v[2] - _2) / var22
            local var28 = (v[3] - _1) / var21
            local var29 = (v[4] - _2) / var22
            local var30 = var28 - var26
            local var31 = var29 - var27
            local tbl_3 = {
                AnchorPoint = Vector2.new(0.5, 0.5);
            }
            local lineColor = arg1.props.lineColor
            if not lineColor then
                lineColor = Color3.new(1, 1, 1)
            end
            tbl_3.BackgroundColor3 = lineColor
            tbl_3.BorderSizePixel = 0
            tbl_3.Size = UDim2.new(math.sqrt(var31 * var31 * arg1.state.aspectRatio * arg1.state.aspectRatio + var30 * var30), 0, 0, arg1.props.lineWidth or 2)
            tbl_3.Rotation = math.deg(-math.atan2(var31 * arg1.state.aspectRatio, var30))
            tbl_3.Position = UDim2.new((var26 + var28) * 0.5, 0, 1 - (var27 + var29) * 0.5, 0)
            table.insert({}, createElement_upvr("Frame", tbl_3))
        end
    end
    if arg1.props.points then
        local var34 = arg1.props.pointRadius or 3
        for _, v_2 in ipairs(arg1.props.points) do
            local tbl_2 = {
                AnchorPoint = Vector2.new(0.5, 0.5);
            }
            local pointColor = arg1.props.pointColor
            if not pointColor then
                pointColor = Color3.new(1, 1, 1)
            end
            tbl_2.BackgroundColor3 = pointColor
            tbl_2.BorderSizePixel = 0
            tbl_2.Size = UDim2.new(0, var34 * 2, 0, var34 * 2)
            tbl_2.Position = UDim2.new((v_2[1] - _1) / var21, 0, 1 - (v_2[2] - _2) / var22, 0)
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            table.insert({}, createElement_upvr("Frame", tbl_2))
        end
    end
    if arg1.props.labels then
        for _, v_3 in ipairs(arg1.props.labels) do
            v_2 = v_3[1]
            local tbl = {
                BackgroundTransparency = 1;
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = v_2;
            }
            local labelColor = arg1.props.labelColor
            if not labelColor then
                labelColor = Color3.new(1, 1, 1)
            end
            tbl.TextColor3 = labelColor
            tbl.Position = UDim2.new((v_3[2] - _1) / var21, 0, 1 - (v_3[3] - _2) / var22, 0)
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            table.insert({}, createElement_upvr("TextLabel", tbl))
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return createElement_upvr("Frame", {
        BorderSizePixel = 1;
        BorderColor3 = Color3.new(1, 1, 1);
        BackgroundColor3 = Color3.fromRGB(20, 20, 20);
        BackgroundTransparency = arg1.props.backgroundTransparency;
        Size = arg1.props.size;
        Position = arg1.props.position;
        ZIndex = arg1.props.zIndex;
        [Roact_upvr.Change.AbsoluteSize] = function(arg1_2) -- Line 96
            arg1:CalculateAspectRatio(arg1_2)
        end;
    }, {})
end
return any_extend_result1