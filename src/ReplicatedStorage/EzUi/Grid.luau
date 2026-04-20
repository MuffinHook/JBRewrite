local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Grid")
any_extend_result1.defaultProps = {
    rowsPerPage = 3;
    colsPerRow = 9;
    itemAspectRatio = nil;
    canvasHeight = 1;
    infHorizontal = false;
    reverseY = false;
}
function any_extend_result1.init(arg1) -- Line 18
end
local GridUtils_upvr = require(script.Parent.GridUtils)
local Dictionary_upvr = require(EzUi.Dictionary)
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 19
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local aspectRatio_2 = arg1.props.aspectRatio
    local var32
    if arg1.props.paddingRatio then
        local var33 = aspectRatio_2
        var32 = "aspectRatio is required when using paddingRatio."
        assert(var33, var32)
        var32 = arg1.props
        var32 = var32.verticalPaddingRatio
        if var32 ~= nil then
            var33 = false
        else
            var33 = true
        end
        var32 = "cannot use paddingRatio & verticalPaddingRatio simultaneously."
        assert(var33, var32)
        var32 = arg1.props
        var32 = var32.paddingRatio
        arg1.props.verticalPaddingRatio = var32 / aspectRatio_2
        arg1.props.paddingRatio = nil
    end
    local var34 = arg1.props.verticalPaddingRatio * aspectRatio_2
    local colsPerRow = arg1.props.colsPerRow
    var32 = arg1.props
    var32 = var32.rowsPerPage
    if arg1.props.itemAspectRatio then
        var32 = colsPerRow / aspectRatio_2 * arg1.props.itemAspectRatio
        arg1.props.rowsPerPage = var32
    end
    local any_getRowRatio_result1_2 = GridUtils_upvr.getRowRatio(arg1.props)
    local any_getColRatio_result1 = GridUtils_upvr.getColRatio(arg1.props, any_getRowRatio_result1_2)
    if not arg1.props.itemDefaults then
    end
    local canvasHeight_2 = arg1.props.canvasHeight
    local module = {}
    for i = 1, #arg1.props.items do
        local var40
        local var41
        if arg1.props.infHorizontal then
            var41 = 1
            var40 = i
        else
            var41 = math.floor((i - 1) / colsPerRow) + 1
            var40 = (i - 1) % colsPerRow + 1
        end
        if arg1.props.reverseY then
            var41 = var32 - var41 + 1
        end
        if arg1.props.items then
        end
        if not arg1.props.items[i] then
        end
        local metadata = arg1.props.metadata
        if metadata then
            metadata = arg1.props.metadata[i]
        end
        if not metadata then
        end
        local any_merge_result1 = Dictionary_upvr.merge({}, {}, {})
        local id = any_merge_result1.id
        if not id then
            id = any_merge_result1.name
            if not id then
                id = #module + 1
            end
        end
        if module[id] then
            warn("An item already exists in grid by key: "..id)
        end
        module[id] = createElement_upvr(arg1.props.component, Dictionary_upvr.merge({
            size = UDim2.new(any_getColRatio_result1 / any_getRowRatio_result1_2, 0, aspectRatio_2 * 1 / any_getRowRatio_result1_2 / canvasHeight_2, 0);
            position = UDim2.new(any_getColRatio_result1 / any_getRowRatio_result1_2 * (var40 - 1) + 1 / var34 * var40, 0, aspectRatio_2 / canvasHeight_2 * ((var41 - 1) * 1 / any_getRowRatio_result1_2 + var41 * 1 / var34), 0);
            aspectRatio = any_getColRatio_result1;
            cornerPixel = 4;
            paddingRatio = any_getRowRatio_result1_2 / var34;
            verticalPaddingRatio = var34 / any_getRowRatio_result1_2;
            parentAspectRatio = aspectRatio_2;
            parentVerticalPaddingRatio = var34 / aspectRatio_2;
            layoutOrder = 2 * var40;
            index = i;
            rowIndex = var41;
            colIndex = var40;
        }, any_merge_result1))
    end
    return Roact_upvr.createFragment(module)
end
return any_extend_result1