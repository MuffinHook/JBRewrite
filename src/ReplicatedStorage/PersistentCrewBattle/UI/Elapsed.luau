local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Elapsed")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(1, 1);
    position = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
    createdAt = nil;
    createdAtBinding = nil;
    textXAlignment = Enum.TextXAlignment.Center;
    prefix = "";
    suffix = "";
    disabled = false;
    font = Enum.Font.FredokaOne;
    textColor = Color3.new(0, 0, 0);
    countDown = false;
    alwaysShowHours = false;
    alwaysShowMinutes = true;
    alwaysShowSeconds = true;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 25
    arg1:setState({
        elapsed = 0;
    })
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 31
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local elapsed_2 = arg1.props.elapsed
    if not elapsed_2 then
        elapsed_2 = arg1.state
        elapsed_2 = elapsed_2.elapsed
    end
    local alwaysShowHours_2 = arg1.props.alwaysShowHours
    if not alwaysShowHours_2 then
        if 0 >= math.floor(elapsed_2 % 86400 / 3600) then
            alwaysShowHours_2 = false
        else
            alwaysShowHours_2 = true
        end
    end
    if not arg1.props.alwaysShowMinutes then
        if not alwaysShowHours_2 then
            if 0 >= math.floor(elapsed_2 % 3600 / 60) then
            else
            end
        end
    end
    if not arg1.props.alwaysShowSeconds then
        if not true then
            if 0 > math.floor(elapsed_2 % 60) then
            else
            end
        end
    end
    if alwaysShowHours_2 then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    else
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    else
    end
    if true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    else
    end
    local module_2 = {}
    local tbl = {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.9, 0, 0.8, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
    }
    if not arg1.props.disabled then
    else
    end
    tbl.Text = string.format("%s--%s", arg1.props.prefix, arg1.props.suffix)
    tbl.TextXAlignment = arg1.props.textXAlignment
    tbl.Font = arg1.props.font
    tbl.LineHeight = 1
    tbl.TextScaled = true
    tbl.TextColor3 = arg1.props.textColor
    tbl[Roact_upvr.Children] = arg1.props[Roact_upvr.Children]
    module_2.Text = createElement_upvr("TextLabel", tbl)
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 0, 0);
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, module_2)
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1._startCounting(arg1) -- Line 69
    local function update() -- Line 70
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1.props.createdAtBinding then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1.props.createdAt then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    update()
    arg1.maid.counting = Interval_upvr.every(0.5):Connect(update)
end
function any_extend_result1.didMount(arg1) -- Line 92
    if not arg1.props.elapsed and not arg1.props.disabled then
        arg1:_startCounting()
    end
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 97
    if arg1.props.elapsed or arg1.props.disabled then
        arg1.maid.counting = nil
    elseif arg1.maid.counting == nil then
        arg1:_startCounting()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 106
    arg1.maid:DoCleaning()
end
return any_extend_result1