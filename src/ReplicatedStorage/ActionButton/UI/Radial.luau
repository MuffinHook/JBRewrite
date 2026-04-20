local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local function calculateRadial_upvr(arg1, arg2) -- Line 11, Named "calculateRadial"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local count = arg1.count
    local var4 = arg1.centerAngle or -2.356194490192345
    local var5 = arg1.angleBetween or 0.59839860068377
    local floored = math.floor((arg1.maxSweepAngle or math.pi) / var5)
    local ceiled = math.ceil(arg2 / floored)
    local var8
    if floored < count then
        var8 = ceiled * floored
        count = math.min(floored, (floored) - (var8 - count))
    end
    local var9 = (arg2 - 1) % floored + 1
    local heavy = arg1.heavy
    local var11 = count
    var8 = var11 % 2
    if var8 == 0 then
        var11 += 1
    end
    var8 = count
    if var8 % 2 == 0 then
        var8 -= 1
    end
    if not arg1.center or not count or not heavy or not var11 then
    end
    if not heavy or not (var11 - 1) then
    end
    local var12 = var8 - 2 * (var9 - 1)
    if var12 < 1 then
        var12 = -var12 + 1
    end
    return var4 - var5 * (var8 - 1) * 0.5 + var5 * (var9 - 1), var12 + (ceiled - 1) * floored, ceiled, var4
end
local any_extend_result1 = Roact.PureComponent:extend("Radial")
any_extend_result1.defaultProps = {
    enabled = true;
    size = UDim2.new(1, 0, 1, 0);
    countOuter = 5;
    buttonRadiusOuter = 0.1;
    radiusOuter = 0.4;
    angleBetweenOuter = 0.59839860068377;
    maxSweepAngleOuter = 4.1887902047863905;
    countInner = 2;
    buttonRadiusInner = 0.12;
    radiusInner = 0.58;
    angleBetweenInner = 0.48;
}
local makeButton_upvr = require(script.Parent.makeButton)
function any_extend_result1._makeButton(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 66
    return makeButton_upvr(arg1.props, arg2, arg3, 100 - arg3 + 500 * arg4, UDim2.new(arg7 * 2, 0, arg7 * 2, 0), UDim2.new(0.5 + arg5, 0, 0.5 + arg6, 0))
end
local createElement_upvr = Roact.createElement
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 73
    local tbl_3 = {
        count = arg1.props.countOuter;
        maxSweepAngle = arg1.props.maxSweepAngleOuter;
        angleBetween = arg1.props.angleBetweenOuter;
        heavy = true;
        center = false;
    }
    local radiusInner = arg1.props.radiusInner
    local tbl = {
        count = arg1.props.countInner;
        angleBetween = arg1.props.angleBetweenInner;
        heavy = true;
        center = true;
    }
    for i = 1, tbl_3.count do
        local buttonRadiusOuter = arg1.props.buttonRadiusOuter
        local calculateRadial_upvr_result1, calculateRadial_result2, calculateRadial_upvr_result3_2 = calculateRadial_upvr(tbl_3, i)
        local radiusOuter = arg1.props.radiusOuter
        local var32 = 2 * radiusOuter * math.sin(tbl_3.angleBetween / 2) * 0.5 - buttonRadiusOuter
        for _ = 1, calculateRadial_upvr_result3_2 - 1 do
            radiusOuter += math.sqrt((2 * buttonRadiusOuter + 2 * var32) ^ 2 - (2 * radiusOuter * math.sin(tbl_3.angleBetween / 2) / 2) ^ 2) - radiusOuter * (1 - math.cos(tbl_3.angleBetween / 2))
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if calculateRadial_result2 == 1 then
            buttonRadiusOuter *= 1.2
        end
        ;({})[calculateRadial_result2] = arg1:_makeButton("outer", calculateRadial_result2, calculateRadial_upvr_result3_2, radiusOuter * math.cos(calculateRadial_upvr_result1 + tbl_3.angleBetween * (calculateRadial_upvr_result3_2 - 1) % 2 * 0.5), radiusOuter * math.sin(calculateRadial_upvr_result1 + tbl_3.angleBetween * (calculateRadial_upvr_result3_2 - 1) % 2 * 0.5), buttonRadiusOuter)
    end
    local tbl_2 = {}
    for i_3 = 1, tbl.count do
        local calculateRadial_result1, calculateRadial_result2_2, calculateRadial_upvr_result3, calculateRadial_result4 = calculateRadial_upvr(tbl, i_3)
        local buttonRadiusInner = arg1.props.buttonRadiusInner
        if calculateRadial_result2_2 == 1 then
            buttonRadiusInner *= 1.2
        end
        tbl_2[calculateRadial_result2_2] = arg1:_makeButton("inner", calculateRadial_result2_2, calculateRadial_upvr_result3, radiusInner * math.cos(calculateRadial_result1) - radiusInner * math.cos(calculateRadial_result4), radiusInner * math.sin(calculateRadial_result1) - radiusInner * math.sin(calculateRadial_result4), buttonRadiusInner)
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return createElement_upvr("Frame", {
        Visible = arg1.props.enabled;
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, Dictionary_upvr.merge({
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
        Center = createElement_upvr("Frame", {
            Size = UDim2.new(1, 0, 1, 0);
            BackgroundTransparency = 1;
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
        }, tbl_2);
    }, {}))
end
return any_extend_result1