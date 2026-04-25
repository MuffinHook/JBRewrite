-- Reviewed by Claude
-- variables reassigned
local ezUiModule = script:FindFirstAncestor("EzUi")
local Roact = require(ezUiModule.Parent.Roact)
local createElement = Roact.createElement
local RunService = game:GetService("RunService")
local ColorUtils = require(ezUiModule.Parent.Std.ColorUtils)
local AccelTween = require(ezUiModule.Parent.Std.AccelTween)
local Maid = require(ezUiModule.Parent.Std.Maid)
local Dictionary = require(ezUiModule.Dictionary)
local Tab = require(script.Tab)
local TabPage = require(script.TabPage)
local v2 = Roact.PureComponent:extend("TabContainer")
v2.defaultProps = {
	size = UDim2.new(0.5, 0, 0.5, 0),
	isSmallScreen = true
}
function v2.init(self)
	self.pageLayoutRef = Roact.createRef()
	self.data = {}
end
function v2.render(self)
	local columnsPerPage = if self.props.isSmallScreen then 1 else 4
	local pageCount = #self.props.pages
	local pageElements = {}
	local tabElements = {}
	for i, v in ipairs(self.props.pages) do
		local opacityOffset
		local currentPage = self.props.currentPage
		if currentPage then
			currentPage = v[Roact.Ref]:getValue() == self.props.currentPage
		end
		opacityOffset = if currentPage then 0.1 else 0
		local tabScaleX = (1 + opacityOffset) / (pageCount + 0.1)
		local pageData = self.data[v.title]
		if not pageData then
			pageData = {}
			self.data[v.title] = pageData
			pageData.maid = Maid.new()
			local scaleXBindingValue, updateScaleXValue = Roact.createBinding(tabScaleX)
			pageData.scaleXBinding = scaleXBindingValue
			pageData.updateScaleXBinding = updateScaleXValue
			pageData.scaleXAccelTween = AccelTween.new(15)
			pageData.scaleXAccelTween.p = tabScaleX
		end
		pageData.scaleXAccelTween.t = tabScaleX
		pageData.maid.scaleXUpdate = RunService.Heartbeat:Connect(function()
			if pageData.scaleXAccelTween.rtime == 0 then
				pageData.maid.scaleXUpdate = nil
			end
			pageData.updateScaleXBinding(pageData.scaleXAccelTween.p)
		end)
		local tabPaddingX = math.ceil(columnsPerPage * (1 / pageCount + 1))
		pageElements[v.title] = createElement(TabPage, {
			[Roact.Ref] = v[Roact.Ref],
			layoutOrder = v.layoutOrder,
			backgroundColor = v.backgroundColor,
			backgroundTransparency = v.backgroundTransparency,
			[Roact.Children] = v[Roact.Children]
		})
		tabElements[v.title] = createElement(Tab, {
			backgroundColor = self.props.color,
			title = v.title,
			scaleXBinding = pageData.scaleXBinding,
			paddingX = tabPaddingX,
			active = currentPage,
			layoutOrder = v.layoutOrder,
			onClick = function()
				local v1 = v[Roact.Ref]:getValue()
				if self.props.currentPage ~= v1 then
					self.props.updatePage(v1)
				end
			end
		})
	end
	local topBarHeightRatio = if self.props.isSmallScreen then 0.1 else 0.05
	return createElement("Frame", {
		Visible = self.props.visible,
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint,
		ClipsDescendants = true
	}, {
		Tabs = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = ColorUtils.brightenTo(self.props.color, 0.3),
			BackgroundTransparency = 0,
			Size = UDim2.new(1, 0, topBarHeightRatio, 0)
		}, Dictionary.merge({
			Padding = createElement("UIPadding", {
				PaddingTop = UDim.new(0, columnsPerPage),
				PaddingBottom = UDim.new(0, columnsPerPage)
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 6)
			}),
			Layout = createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, columnsPerPage)
			})
		}, tabElements)),
		Container = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, topBarHeightRatio, columnsPerPage),
			Size = UDim2.new(1, 0, 1 - topBarHeightRatio, -columnsPerPage)
		}, Dictionary.merge({
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 6)
			}),
			PageLayout = createElement("UIPageLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				EasingStyle = Enum.EasingStyle.Quad,
				TweenTime = 0.2,
				[Roact.Change.CurrentPage] = function(component)
					local CurrentPage = component.CurrentPage
					if self.props.currentPage ~= CurrentPage then
						self.props.updatePage(CurrentPage)
					end
				end,
				[Roact.Ref] = self.pageLayoutRef
			})
		}, pageElements))
	})
end
function v2.didUpdate(self, prevProps, prevState)
	if self.props.currentPage ~= prevState.currentPage and self.pageLayoutRef:getValue().CurrentPage ~= self.props.currentPage then
		self.pageLayoutRef:getValue():JumpTo(self.props.currentPage)
	end
end
function v2.willUnmount(self)
	for k, v in pairs(self.data) do
		v.maid:DoCleaning()
	end
	table.clear(self.data)
end
return v2
