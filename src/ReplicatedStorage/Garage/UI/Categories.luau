local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Categories")
any_extend_result1.defaultProps = {
    categoriesPerPage = 10;
}
function any_extend_result1.init(arg1) -- Line 13
end
local createElement_upvr = Roact.createElement
local CategoryItem_upvr = require(script.Parent.CategoryItem)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 14
    local mainRatio = arg1.props.mainRatio
    local paddingRatio = arg1.props.paddingRatio
    local cornerPixel = arg1.props.cornerPixel
    local categoriesPerPage = arg1.props.categoriesPerPage
    local tbl = {}
    for i, v_upvr in pairs(arg1.props.categories) do
        local tbl_3 = {
            layoutOrder = 2 * i;
            mainRatio = 1 / ((1) / (mainRatio * categoriesPerPage) - 1 / paddingRatio + 1 / paddingRatio / categoriesPerPage);
            paddingRatio = paddingRatio;
            cornerPixel = cornerPixel;
        }
        local title = v_upvr.title
        tbl_3.title = title
        if arg1.props.selectedCategory ~= v_upvr.name then
            title = false
        else
            title = true
        end
        tbl_3.selected = title
        function tbl_3.onSelect() -- Line 39
            arg1.props.setCategory(v_upvr.name, arg1.props.sortId)
        end
        table.insert(tbl, createElement_upvr(CategoryItem_upvr, tbl_3))
        table.insert(tbl, createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 0.6;
            BackgroundColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            LayoutOrder = 2 * i + 1;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = paddingRatio;
            });
        }))
    end
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 0;
        BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
        Size = UDim2.new(1, 0, 1, 0);
        LayoutOrder = arg1.props.layoutOrder;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = mainRatio;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
        ScrollingFrame = createElement_upvr("ScrollingFrame", {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            ScrollBarThickness = 4;
            ScrollBarImageColor3 = Color3.new(1, 1, 1);
            CanvasSize = UDim2.new(0, 0, (1 + mainRatio / paddingRatio) * #arg1.props.categories / categoriesPerPage - mainRatio / paddingRatio, 0);
            Size = UDim2.new(1, 0, 1, 0);
            ElasticBehavior = Enum.ElasticBehavior.Always;
            VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left;
            VerticalScrollBarInset = Enum.ScrollBarInset.None;
            ScrollingDirection = Enum.ScrollingDirection.Y;
        }, Dictionary_upvr.merge({
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Top;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Vertical;
            });
        }, tbl));
    })
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 103
    return {
        categories = arg1.garageCategories;
        selectedCategory = arg1.garageCategory;
        sortId = arg1.garageSort;
    }
end, function(arg1) -- Line 109
    return {
        setCategory = function(arg1_2, arg2) -- Line 111, Named "setCategory"
            local tbl_2 = {
                type = "setCategory";
            }
            tbl_2.categoryName = arg1_2
            tbl_2.sortId = arg2
            arg1(tbl_2)
        end;
    }
end)(any_extend_result1)