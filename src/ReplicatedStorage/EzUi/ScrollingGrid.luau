local EzUi = script:FindFirstAncestor("EzUi")
local Roact = require(EzUi.Parent.Roact)
local any_extend_result1 = Roact.PureComponent:extend("ScrollingGrid")
any_extend_result1.defaultProps = {
    rowsPerPage = 3;
    colsPerRow = 9;
}
function any_extend_result1.init(arg1) -- Line 14
end
local createElement_upvr = Roact.createElement
local Grid_upvr = require(EzUi.Grid)
local Dictionary_upvr = require(EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 15
    local aspectRatio = arg1.props.aspectRatio
    if arg1.props.paddingRatio then
        local var9 = aspectRatio
        assert(var9, "aspectRatio is required when using paddingRatio.")
        if arg1.props.verticalPaddingRatio ~= nil then
            var9 = false
        else
            var9 = true
        end
        assert(var9, "cannot use paddingRatio & verticalPaddingRatio simultaneously.")
        arg1.props.verticalPaddingRatio = arg1.props.paddingRatio / aspectRatio
        arg1.props.paddingRatio = nil
    end
    if arg1.props.itemAspectRatio then
        arg1.props.rowsPerPage = arg1.props.colsPerRow / aspectRatio * arg1.props.itemAspectRatio
    end
    local var10 = (math.floor((#arg1.props.items - 1) / arg1.props.colsPerRow) + 1) / arg1.props.rowsPerPage
    local maximum = math.max(1, var10 - (aspectRatio) / (arg1.props.verticalPaddingRatio * aspectRatio) * (var10 - 1))
    return createElement_upvr("ScrollingFrame", {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        ScrollBarThickness = 4;
        ScrollBarImageColor3 = Color3.new(1, 1, 1);
        CanvasSize = UDim2.new(0, 0, maximum - 0.0001, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
        ScrollingDirection = Enum.ScrollingDirection.Y;
        Selectable = false;
    }, createElement_upvr(Grid_upvr, Dictionary_upvr.merge({
        canvasHeight = maximum;
    }, arg1.props)))
end
return any_extend_result1