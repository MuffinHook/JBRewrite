local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local CategoryItem = require(script.Parent.CategoryItem)
local CategoriesComponent = Roact.PureComponent:extend("Categories")
CategoriesComponent.defaultProps = {
	categoriesPerPage = 10
}
function CategoriesComponent.init(self)  end
function CategoriesComponent.render(self)
	local mainRatio = self.props.mainRatio
	local paddingRatio = self.props.paddingRatio
	local cornerPixel = self.props.cornerPixel
	local categoriesPerPage = self.props.categoriesPerPage
	local calculatedMainRatio = 1 / (1 / (mainRatio * categoriesPerPage) - 1 / paddingRatio + 1 / paddingRatio / categoriesPerPage)
	local elementsList = {}
	for k, category in pairs(self.props.categories) do
		local isSelected
		local categoryItemProps = {
			layoutOrder = 2 * k,
			mainRatio = calculatedMainRatio,
			paddingRatio = paddingRatio,
			cornerPixel = cornerPixel,
			title = category.title
		}
		isSelected = self.props.selectedCategory == category.name
		categoryItemProps.selected = isSelected
		function categoryItemProps.onSelect()
			self.props.setCategory(category.name, self.props.sortId)
		end
		table.insert(elementsList, (createElement(CategoryItem, categoryItemProps)))
		table.insert(elementsList, (createElement("Frame", {
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
		LayoutOrder = self.props.layoutOrder
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
			CanvasSize = UDim2.new(0, 0, (1 + mainRatio / paddingRatio) * #self.props.categories / categoriesPerPage - mainRatio / paddingRatio, 0),
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
		}, elementsList))
	})
end
return RoactRodux.connect(function(stateSlice, dispatchAction)
	return {
		categories = stateSlice.garageCategories,
		selectedCategory = stateSlice.garageCategory,
		sortId = stateSlice.garageSort
	}
end, function(dispatchAction)
	return {
		setCategory = function(categoryName, sortId)
			dispatchAction({
				type = "setCategory",
				categoryName = categoryName,
				sortId = sortId
			})
		end
	}
end)(CategoriesComponent)
