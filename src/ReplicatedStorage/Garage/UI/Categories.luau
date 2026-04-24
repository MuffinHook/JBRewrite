-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local CategoryItem = require(script.Parent.CategoryItem)
local v1 = Roact.PureComponent:extend("Categories")
v1.defaultProps = {
	categoriesPerPage = 10
}
function v1.init(p1)  end
function v1.render(p1)
	local mainRatio = p1.props.mainRatio
	local paddingRatio = p1.props.paddingRatio
	local cornerPixel = p1.props.cornerPixel
	local categoriesPerPage = p1.props.categoriesPerPage
	local v2 = 1 / (1 / (mainRatio * categoriesPerPage) - 1 / paddingRatio + 1 / paddingRatio / categoriesPerPage)
	local t = {}
	for k, v in pairs(p1.props.categories) do
		local v3
		local t2 = {
			layoutOrder = 2 * k,
			mainRatio = v2,
			paddingRatio = paddingRatio,
			cornerPixel = cornerPixel,
			title = v.title
		}
		v3 = p1.props.selectedCategory == v.name
		t2.selected = v3
		function t2.onSelect()
			p1.props.setCategory(v.name, p1.props.sortId)
		end
		table.insert(t, (createElement(CategoryItem, t2)))
		table.insert(t, (createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 0.6,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 2 * k + 1
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = paddingRatio
			})
		})))
	end
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = p1.props.layoutOrder
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingFrame = createElement("ScrollingFrame", {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BorderSizePixel = 0,
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = Color3.new(255/255, 255/255, 255/255),
			CanvasSize = UDim2.new(0, 0, (1 + mainRatio / paddingRatio) * #p1.props.categories / categoriesPerPage - mainRatio / paddingRatio, 0),
			Size = UDim2.new(1, 0, 1, 0),
			ElasticBehavior = Enum.ElasticBehavior.Always,
			VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left,
			VerticalScrollBarInset = Enum.ScrollBarInset.None,
			ScrollingDirection = Enum.ScrollingDirection.Y
		}, Dictionary.merge({
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			})
		}, t))
	})
end
return RoactRodux.connect(function(p1, p2)
	return {
		categories = p1.garageCategories,
		selectedCategory = p1.garageCategory,
		sortId = p1.garageSort
	}
end, function(p1)
	return {
		setCategory = function(p12, p2)
			p1({
				type = "setCategory",
				categoryName = p12,
				sortId = p2
			})
		end
	}
end)(v1)
