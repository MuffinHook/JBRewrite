-- Reviewed by Claude
require(script.Parent.Types)
local t = {}
return function(p1)
	t.GuiService = game:GetService("GuiService")
	t.RunService = game:GetService("RunService")
	t.UserInputService = game:GetService("UserInputService")
	t.ContextActionService = game:GetService("ContextActionService")
	t.TextService = game:GetService("TextService")
	t.ICONS = {
		BLANK_SQUARE = "rbxasset://textures/SurfacesDefault.png",
		RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
		DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
		MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
		BOTTOM_RIGHT_CORNER = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png",
		CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
		BORDER = "rbxasset://textures/ui/InspectMenu/gr-item-selector.png",
		ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png",
		UNKNOWN_TEXTURE = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	}
	t.IS_STUDIO = t.RunService:IsStudio()
	function t.getTime()
		if t.IS_STUDIO then
			return os.clock()
		else
			return time()
		end
	end
	t.GuiOffset = if p1._config.IgnoreGuiInset then -t.GuiService:GetGuiInset() else Vector2.zero
	t.MouseOffset = if p1._config.IgnoreGuiInset then Vector2.zero else t.GuiService:GetGuiInset()
	local v5 = nil
	v5 = t.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function()
		t.MouseOffset = if p1._config.IgnoreGuiInset then Vector2.zero else t.GuiService:GetGuiInset()
		t.GuiOffset = if p1._config.IgnoreGuiInset then -t.GuiService:GetGuiInset() else Vector2.zero
		v5:Disconnect()
	end)
	task.delay(5, function()
		v5:Disconnect()
	end)
	function t.getMouseLocation()
		return t.UserInputService:GetMouseLocation() - t.MouseOffset
	end
	function t.isPosInsideRect(p1, p2, p3)
		return if p1.X >= p2.X and (p1.X <= p3.X and p1.Y >= p2.Y) then p1.Y <= p3.Y else false
	end
	function t.findBestWindowPosForPopup(p1, p2, p3, p4)
		local v1 = if p1.X + p2.X + 20 > p4.X then if p1.Y + p2.Y + 20 > p4.Y then p1 + Vector2.new(0, -(20 + p2.Y)) else p1 + Vector2.new(0, 20) else p1 + Vector2.new(20)
		return Vector2.new(math.max(math.min(v1.X + p2.X, p4.X) - p2.X, p3.X), (math.max(math.min(v1.Y + p2.Y, p4.Y) - p2.Y, p3.Y)))
	end
	function t.getScreenSizeForWindow(p1)
		if p1.Instance:IsA("GuiBase2d") then
			return p1.Instance.AbsoluteSize
		else
			local v1 = p1.Instance.Parent
			if v1:IsA("GuiBase2d") or v1.Parent:IsA("GuiBase2d") then
				return v1.AbsoluteSize
			else
				return workspace.CurrentCamera.ViewportSize
			end
		end
	end
	function t.extend(p1, p2)
		local v1 = table.clone(p1)
		for v2, v3 in p2 do
			v1[v2] = v3
		end
		return v1
	end
	function t.UIPadding(p1, p2)
		local UIPadding = Instance.new("UIPadding")
		UIPadding.PaddingLeft = UDim.new(0, p2.X)
		UIPadding.PaddingRight = UDim.new(0, p2.X)
		UIPadding.PaddingTop = UDim.new(0, p2.Y)
		UIPadding.PaddingBottom = UDim.new(0, p2.Y)
		UIPadding.Parent = p1
		return UIPadding
	end
	function t.UIListLayout(p1, p2, p3)
		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = p3
		UIListLayout.FillDirection = p2
		UIListLayout.Parent = p1
		return UIListLayout
	end
	function t.UIStroke(p1, p2, p3, p4)
		local UIStroke = Instance.new("UIStroke")
		UIStroke.Thickness = p2
		UIStroke.Color = p3
		UIStroke.Transparency = p4
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.Parent = p1
		return UIStroke
	end
	function t.UICorner(p1, p2)
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(if p2 then 0 else 1, p2 or 0)
		UICorner.Parent = p1
		return UICorner
	end
	function t.UISizeConstraint(p1, p2, p3)
		local UISizeConstraint = Instance.new("UISizeConstraint")
		UISizeConstraint.MinSize = p2 or UISizeConstraint.MinSize
		UISizeConstraint.MaxSize = p3 or UISizeConstraint.MaxSize
		UISizeConstraint.Parent = p1
		return UISizeConstraint
	end
	function t.applyTextStyle(p12)
		p12.FontFace = p1._config.TextFont
		p12.TextSize = p1._config.TextSize
		p12.TextColor3 = p1._config.TextColor
		p12.TextTransparency = p1._config.TextTransparency
		p12.TextXAlignment = Enum.TextXAlignment.Left
		p12.TextYAlignment = Enum.TextYAlignment.Center
		p12.RichText = p1._config.RichText
		p12.TextWrapped = p1._config.TextWrapped
		p12.AutoLocalize = false
	end
	function t.applyInteractionHighlights(p12, p2, p3, p4)
		local v1 = false
		t.applyMouseEnter(p2, function()
			p3[p12 .. "Color3"] = p4.HoveredColor
			p3[p12 .. "Transparency"] = p4.HoveredTransparency
			v1 = false
		end)
		t.applyMouseLeave(p2, function()
			p3[p12 .. "Color3"] = p4.Color
			p3[p12 .. "Transparency"] = p4.Transparency
			v1 = true
		end)
		t.applyInputBegan(p2, function(p1)
			if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Gamepad1 then
				p3[p12 .. "Color3"] = p4.ActiveColor
				p3[p12 .. "Transparency"] = p4.ActiveTransparency
			end
		end)
		t.applyInputEnded(p2, function(p1)
			if (p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Gamepad1) and not v1 then
				if p1.UserInputType == Enum.UserInputType.MouseButton1 then
					p3[p12 .. "Color3"] = p4.HoveredColor
					p3[p12 .. "Transparency"] = p4.HoveredTransparency
				end
				if p1.UserInputType == Enum.UserInputType.Gamepad1 then
					p3[p12 .. "Color3"] = p4.Color
					p3[p12 .. "Transparency"] = p4.Transparency
				end
			end
		end)
		p2.SelectionImageObject = p1.SelectionImageObject
	end
	function t.applyInteractionHighlightsWithMultiHighlightee(p12, p2, p3)
		local v1 = false
		t.applyMouseEnter(p2, function()
			for v12, v2 in p3 do
				v2[1][p12 .. "Color3"] = v2[2].HoveredColor
				v2[1][p12 .. "Transparency"] = v2[2].HoveredTransparency
				v1 = false
			end
		end)
		t.applyMouseLeave(p2, function()
			for v12, v2 in p3 do
				v2[1][p12 .. "Color3"] = v2[2].Color
				v2[1][p12 .. "Transparency"] = v2[2].Transparency
				v1 = true
			end
		end)
		t.applyInputBegan(p2, function(p1)
			if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Gamepad1 then
				for v1, v2 in p3 do
					v2[1][p12 .. "Color3"] = v2[2].ActiveColor
					v2[1][p12 .. "Transparency"] = v2[2].ActiveTransparency
				end
			end
		end)
		t.applyInputEnded(p2, function(p1)
			if (p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Gamepad1) and not v1 then
				for v12, v2 in p3 do
					if p1.UserInputType == Enum.UserInputType.MouseButton1 then
						v2[1][p12 .. "Color3"] = v2[2].HoveredColor
						v2[1][p12 .. "Transparency"] = v2[2].HoveredTransparency
					end
					if p1.UserInputType == Enum.UserInputType.Gamepad1 then
						v2[1][p12 .. "Color3"] = v2[2].Color
						v2[1][p12 .. "Transparency"] = v2[2].Transparency
					end
				end
			end
		end)
		p2.SelectionImageObject = p1.SelectionImageObject
	end
	function t.applyFrameStyle(p12, p2, p3)
		local FrameBorderSize = p1._config.FrameBorderSize
		local FrameRounding = p1._config.FrameRounding
		p12.BorderSizePixel = 0
		if FrameBorderSize > 0 then
			t.UIStroke(p12, FrameBorderSize, p1._config.BorderColor, p1._config.BorderTransparency)
		end
		if FrameRounding > 0 and not p3 then
			t.UICorner(p12, FrameRounding)
		end
		if not p2 then
			t.UIPadding(p12, p1._config.FramePadding)
		end
	end
	function t.applyButtonClick(p1, p2)
		p1.MouseButton1Click:Connect(function()
			p2()
		end)
	end
	function t.applyButtonDown(p1, p2)
		p1.MouseButton1Down:Connect(function(p1, p22)
			local v1 = Vector2.new(p1, p22) - t.MouseOffset
			p2(v1.X, v1.Y)
		end)
	end
	function t.applyMouseEnter(p1, p2)
		p1.MouseEnter:Connect(function(p1, p22)
			local v1 = Vector2.new(p1, p22) - t.MouseOffset
			p2(v1.X, v1.Y)
		end)
	end
	function t.applyMouseMoved(p1, p2)
		p1.MouseMoved:Connect(function(p1, p22)
			local v1 = Vector2.new(p1, p22) - t.MouseOffset
			p2(v1.X, v1.Y)
		end)
	end
	function t.applyMouseLeave(p1, p2)
		p1.MouseLeave:Connect(function(p1, p22)
			local v1 = Vector2.new(p1, p22) - t.MouseOffset
			p2(v1.X, v1.Y)
		end)
	end
	function t.applyInputBegan(p1, p2)
		p1.InputBegan:Connect(function(...)
			p2(...)
		end)
	end
	function t.applyInputEnded(p1, p2)
		p1.InputEnded:Connect(function(...)
			p2(...)
		end)
	end
	function t.discardState(p1)
		for v1, v2 in p1.state do
			v2.ConnectedWidgets[p1.ID] = nil
		end
	end
	function t.registerEvent(p12, p2)
		local function f1()
			table.insert(p1._connections, t.UserInputService[p12]:Connect(p2))
		end
		table.insert(p1._initFunctions, f1)
	end
	t.EVENTS = {
		hover = function(p1)
			return {
				Init = function(p12)
					local v1 = p1(p12)
					t.applyMouseEnter(v1, function()
						p12.isHoveredEvent = true
					end)
					t.applyMouseLeave(v1, function()
						p12.isHoveredEvent = false
					end)
					p12.isHoveredEvent = false
				end,
				Get = function(p1)
					return p1.isHoveredEvent
				end
			}
		end,
		click = function(p12)
			return {
				Init = function(p13)
					local v1 = p12(p13)
					p13.lastClickedTick = -1
					t.applyButtonClick(v1, function()
						p13.lastClickedTick = p1._cycleTick + 1
					end)
				end,
				Get = function(p12)
					return p12.lastClickedTick == p1._cycleTick
				end
			}
		end,
		rightClick = function(p12)
			return {
				Init = function(p13)
					local v1 = p12(p13)
					p13.lastRightClickedTick = -1
					v1.MouseButton2Click:Connect(function()
						p13.lastRightClickedTick = p1._cycleTick + 1
					end)
				end,
				Get = function(p12)
					return p12.lastRightClickedTick == p1._cycleTick
				end
			}
		end,
		doubleClick = function(p12)
			return {
				Init = function(p13)
					local v1 = p12(p13)
					p13.lastClickedTime = -1
					p13.lastClickedPosition = Vector2.zero
					p13.lastDoubleClickedTick = -1
					t.applyButtonDown(v1, function(p12, p2)
						local v1 = t.getTime()
						if v1 - p13.lastClickedTime < p1._config.MouseDoubleClickTime and (Vector2.new(p12, p2) - p13.lastClickedPosition).Magnitude < p1._config.MouseDoubleClickMaxDist then
							p13.lastDoubleClickedTick = p1._cycleTick + 1
						else
							p13.lastClickedTime = v1
							p13.lastClickedPosition = Vector2.new(p12, p2)
						end
					end)
				end,
				Get = function(p12)
					return p12.lastDoubleClickedTick == p1._cycleTick
				end
			}
		end,
		ctrlClick = function(p12)
			return {
				Init = function(p13)
					local v1 = p12(p13)
					p13.lastCtrlClickedTick = -1
					t.applyButtonClick(v1, function()
						if t.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or t.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
							p13.lastCtrlClickedTick = p1._cycleTick + 1
						end
					end)
				end,
				Get = function(p12)
					return p12.lastCtrlClickedTick == p1._cycleTick
				end
			}
		end
	}
	p1._utility = t
	require(script.Root)(p1, t)
	require(script.Window)(p1, t)
	require(script.Menu)(p1, t)
	require(script.Format)(p1, t)
	require(script.Text)(p1, t)
	require(script.Button)(p1, t)
	require(script.Checkbox)(p1, t)
	require(script.RadioButton)(p1, t)
	require(script.Image)(p1, t)
	require(script.Tree)(p1, t)
	require(script.Tab)(p1, t)
	require(script.Input)(p1, t)
	require(script.Combo)(p1, t)
	require(script.Plot)(p1, t)
	require(script.Table)(p1, t)
end
