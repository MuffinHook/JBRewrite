require(script.Parent.Parent.Types)
return function(irisConfig, utils)
	local childCount = 0
	irisConfig.WidgetConstructor("Root", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(widgetObject)
			local Iris_Root = Instance.new("Folder")
			Iris_Root.Name = "Iris_Root"
			local PseudoWindowScreenGui
			if irisConfig._config.UseScreenGUIs then
				local ScreenGui = Instance.new("ScreenGui")
				ScreenGui.ResetOnSpawn = false
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui.ScreenInsets = irisConfig._config.ScreenInsets
				ScreenGui.IgnoreGuiInset = irisConfig._config.IgnoreGuiInset
				ScreenGui.DisplayOrder = irisConfig._config.DisplayOrderOffset
				PseudoWindowScreenGui = ScreenGui
			else
				local Frame = Instance.new("Frame")
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.fromScale(0.5, 0.5)
				Frame.Size = UDim2.fromScale(1, 1)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = irisConfig._config.DisplayOrderOffset
				PseudoWindowScreenGui = Frame
			end
			PseudoWindowScreenGui.Name = "PseudoWindowScreenGui"
			PseudoWindowScreenGui.Parent = Iris_Root
			local PopupScreenGui
			if irisConfig._config.UseScreenGUIs then
				local ScreenGui = Instance.new("ScreenGui")
				ScreenGui.ResetOnSpawn = false
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui.DisplayOrder = irisConfig._config.DisplayOrderOffset + 1024
				ScreenGui.ScreenInsets = irisConfig._config.ScreenInsets
				ScreenGui.IgnoreGuiInset = irisConfig._config.IgnoreGuiInset
				PopupScreenGui = ScreenGui
			else
				local Frame = Instance.new("Frame")
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.fromScale(0.5, 0.5)
				Frame.Size = UDim2.fromScale(1, 1)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = irisConfig._config.DisplayOrderOffset + 1024
				PopupScreenGui = Frame
			end
			PopupScreenGui.Name = "PopupScreenGui"
			PopupScreenGui.Parent = Iris_Root
			local TooltipContainer = Instance.new("Frame")
			TooltipContainer.Name = "TooltipContainer"
			TooltipContainer.AutomaticSize = Enum.AutomaticSize.XY
			TooltipContainer.Size = UDim2.fromOffset(0, 0)
			TooltipContainer.BackgroundTransparency = 1
			TooltipContainer.BorderSizePixel = 0
			utils.UIListLayout(TooltipContainer, Enum.FillDirection.Vertical, UDim.new(0, irisConfig._config.PopupBorderSize))
			TooltipContainer.Parent = PopupScreenGui
			local MenuBarContainer = Instance.new("Frame")
			MenuBarContainer.Name = "MenuBarContainer"
			MenuBarContainer.AutomaticSize = Enum.AutomaticSize.Y
			MenuBarContainer.Size = UDim2.fromScale(1, 0)
			MenuBarContainer.BackgroundTransparency = 1
			MenuBarContainer.BorderSizePixel = 0
			MenuBarContainer.Parent = PopupScreenGui
			local PseudoWindow = Instance.new("Frame")
			PseudoWindow.Name = "PseudoWindow"
			PseudoWindow.AutomaticSize = Enum.AutomaticSize.XY
			PseudoWindow.Size = UDim2.new(0, 0, 0, 0)
			PseudoWindow.Position = UDim2.fromOffset(0, 22)
			PseudoWindow.BackgroundTransparency = irisConfig._config.WindowBgTransparency
			PseudoWindow.BackgroundColor3 = irisConfig._config.WindowBgColor
			PseudoWindow.BorderSizePixel = irisConfig._config.WindowBorderSize
			PseudoWindow.BorderColor3 = irisConfig._config.BorderColor
			PseudoWindow.Selectable = false
			PseudoWindow.SelectionGroup = true
			PseudoWindow.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			PseudoWindow.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			PseudoWindow.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			PseudoWindow.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			PseudoWindow.Visible = false
			utils.UIPadding(PseudoWindow, irisConfig._config.WindowPadding)
			utils.UIListLayout(PseudoWindow, Enum.FillDirection.Vertical, UDim.new(0, irisConfig._config.ItemSpacing.Y))
			PseudoWindow.Parent = PseudoWindowScreenGui
			return Iris_Root
		end,
		Update = function(widgetState)
			if childCount > 0 then
				widgetState.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true
			end
		end,
		Discard = function(widgetState)
			childCount = 0
			widgetState.Instance:Destroy()
		end,
		ChildAdded = function(widgetState, childInfo)
			local instanceRoot = widgetState.Instance
			if childInfo.type == "Window" then
				return widgetState.Instance
			elseif childInfo.type == "Tooltip" then
				return instanceRoot.PopupScreenGui.TooltipContainer
			elseif childInfo.type == "MenuBar" then
				return instanceRoot.PopupScreenGui.MenuBarContainer
			else
				local PseudoWindow = instanceRoot.PseudoWindowScreenGui.PseudoWindow
				childCount = childCount + 1
				PseudoWindow.Visible = true
				return PseudoWindow
			end
		end,
		ChildDiscarded = function(widgetState, childInfo)
			if childInfo.type ~= "Window" and (childInfo.type ~= "Tooltip" and childInfo.type ~= "MenuBar") then
				childCount = childCount - 1
				if childCount == 0 then
					widgetState.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false
				end
			end
		end
	})
end
