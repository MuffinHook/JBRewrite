-- Reviewed by Claude
local v1 = script:FindFirstAncestor("EzUi")
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local RunService = game:GetService("RunService")
local ColorUtils = require(v1.Parent.Std.ColorUtils)
local AccelTween = require(v1.Parent.Std.AccelTween)
local Maid = require(v1.Parent.Std.Maid)
local Dictionary = require(v1.Dictionary)
local Tab = require(script.Tab)
local TabPage = require(script.TabPage)
local v2 = Roact.PureComponent:extend("TabContainer")
v2.defaultProps = {
	size = UDim2.new(0.5, 0, 0.5, 0),
	isSmallScreen = true
}
function v2.init(p1)
	p1.pageLayoutRef = Roact.createRef()
	p1.data = {}
end
function v2.render(p1)
	local v1 = if p1.props.isSmallScreen then 1 else 4
	local v2 = #p1.props.pages
	local t = {}
	local t2 = {}
	for i, v in ipairs(p1.props.pages) do
		local v3
		local currentPage = p1.props.currentPage
		if currentPage then
			currentPage = v[Roact.Ref]:getValue() == p1.props.currentPage
		end
		v3 = if currentPage then 0.1 else 0
		local v5 = (1 + v3) / (v2 + 0.1)
		local v6 = p1.data[v.title]
		if not v6 then
			v6 = {}
			p1.data[v.title] = v6
			v6.maid = Maid.new()
			local v7, v8 = Roact.createBinding(v5)
			v6.scaleXBinding = v7
			v6.updateScaleXBinding = v8
			v6.scaleXAccelTween = AccelTween.new(15)
			v6.scaleXAccelTween.p = v5
		end
		v6.scaleXAccelTween.t = v5
		v6.maid.scaleXUpdate = RunService.Heartbeat:Connect(function()
			if v6.scaleXAccelTween.rtime == 0 then
				v6.maid.scaleXUpdate = nil
			end
			v6.updateScaleXBinding(v6.scaleXAccelTween.p)
		end)
		local v9 = math.ceil(v1 * (1 / v2 + 1))
		t[v.title] = createElement(TabPage, {
			[Roact.Ref] = v[Roact.Ref],
			layoutOrder = v.layoutOrder,
			backgroundColor = v.backgroundColor,
			backgroundTransparency = v.backgroundTransparency,
			[Roact.Children] = v[Roact.Children]
		})
		t2[v.title] = createElement(Tab, {
			backgroundColor = p1.props.color,
			title = v.title,
			scaleXBinding = v6.scaleXBinding,
			paddingX = v9,
			active = currentPage,
			layoutOrder = v.layoutOrder,
			onClick = function()
				local v1 = v[Roact.Ref]:getValue()
				if p1.props.currentPage ~= v1 then
					p1.props.updatePage(v1)
				end
			end
		})
	end
	local v10 = if p1.props.isSmallScreen then 0.1 else 0.05
	return createElement("Frame", {
		Visible = p1.props.visible,
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint,
		ClipsDescendants = true
	}, {
		Tabs = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = ColorUtils.brightenTo(p1.props.color, 0.3),
			BackgroundTransparency = 0,
			Size = UDim2.new(1, 0, v10, 0)
		}, Dictionary.merge({
			Padding = createElement("UIPadding", {
				PaddingTop = UDim.new(0, v1),
				PaddingBottom = UDim.new(0, v1)
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 6)
			}),
			Layout = createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, v1)
			})
		}, t2)),
		Container = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, v10, v1),
			Size = UDim2.new(1, 0, 1 - v10, -v1)
		}, Dictionary.merge({
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 6)
			}),
			PageLayout = createElement("UIPageLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				EasingStyle = Enum.EasingStyle.Quad,
				TweenTime = 0.2,
				[Roact.Change.CurrentPage] = function(p12)
					local CurrentPage = p12.CurrentPage
					if p1.props.currentPage ~= CurrentPage then
						p1.props.updatePage(CurrentPage)
					end
				end,
				[Roact.Ref] = p1.pageLayoutRef
			})
		}, t))
	})
end
function v2.didUpdate(p1, p2, p3)
	if p1.props.currentPage ~= p3.currentPage and p1.pageLayoutRef:getValue().CurrentPage ~= p1.props.currentPage then
		p1.pageLayoutRef:getValue():JumpTo(p1.props.currentPage)
	end
end
function v2.willUnmount(p1)
	for k, v in pairs(p1.data) do
		v.maid:DoCleaning()
	end
	table.clear(p1.data)
end
return v2
