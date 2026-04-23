local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local v1 = Roact.PureComponent:extend("Member")
function v1.init(p1) --[[ Line: 7 ]]
	p1:setState({
		settingsOpen = false
	})
	function p1.toggleSettings() --[[ Line: 12 | Upvalues: p1 (copy) ]]
		p1:setState({
			settingsOpen = not p1.state.settingsOpen
		})
	end
end
function v1.render(p1) --[[ Line: 18 | Upvalues: createElement (copy), Roact (copy), PersistentCrewBattleUtils (copy) ]]
	local index = p1.props.index
	local aspectRatio = p1.props.aspectRatio
	local paddingRatio = p1.props.paddingRatio
	local t = {
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(62, 65, 78),
		Size = p1.props.size,
		Position = p1.props.position
	}
	local t2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local t3 = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 255/255, 0/255),
		BackgroundTransparency = 1
	}
	t3.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(p1.props.userId)
	t3.Size = UDim2.fromScale(1 / aspectRatio - 2 * paddingRatio / aspectRatio, 1 - 2 * paddingRatio)
	t3.Position = UDim2.fromScale(paddingRatio / aspectRatio, 1 * paddingRatio)
	t3.AnchorPoint = Vector2.new(0, 0)
	local t4 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	local t5 = {
		Transparency = 0.5,
		Thickness = 2
	}
	t5.Color = p1.props.isOnline and Color3.fromRGB(80, 163, 97) or Color3.new(255/255, 255/255, 255/255)
	t4.UIStroke = createElement("UIStroke", t5)
	t4.AdminBadge = p1.props.isAdmin and createElement("ImageButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.5, 0.5),
		Position = UDim2.fromScale(0.8, 0.8),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "rbxassetid://12385263946"
	})
	t2.Avatar = createElement("ImageLabel", t3, t4)
	t2.Title = createElement("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.7 - 1 / aspectRatio - 1 * paddingRatio / aspectRatio, 0, 1, 0),
		Position = UDim2.new(1 / aspectRatio + 1 * paddingRatio / aspectRatio, 0, 0, 0)
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.8, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = p1.props.displayName,
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	local t6 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(2 / aspectRatio, 0, 1, 0),
		Position = UDim2.new(1 - 4 / aspectRatio - paddingRatio / aspectRatio, 0, 0, 0)
	}
	local t7 = {
		UIListLayout = createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
	}
	local showRequestAccept = p1.props.showRequestAccept
	if showRequestAccept then
		local t8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local t9 = {}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385251660",
			[Roact.Event.Activated] = p1.props.uncurryPropsIndex(p1.props.onClickJoinRequestAccept, index)
		}
		t10.ImageColor3 = if p1.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		t9.Button = createElement("ImageButton", t10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showRequestAccept = createElement("Frame", t8, t9)
	end
	t7.JoinRequestAcceptContainer = showRequestAccept
	local showRequestDeny = p1.props.showRequestDeny
	if showRequestDeny then
		local t8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 10
		}
		local t9 = {}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385265200",
			[Roact.Event.Activated] = p1.props.uncurryPropsIndex(p1.props.onClickJoinRequestDeny, index)
		}
		t10.ImageColor3 = if p1.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		t9.Button = createElement("ImageButton", t10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showRequestDeny = createElement("Frame", t8, t9)
	end
	t7.JoinRequestDenyContainer = showRequestDeny
	local showKick = p1.props.showKick
	if showKick then
		local t8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 10
		}
		local t9 = {}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385265200",
			[Roact.Event.Activated] = p1.props.uncurryPropsIndex(p1.props.onClickKick, index)
		}
		t10.ImageColor3 = if p1.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		t9.Button = createElement("ImageButton", t10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showKick = createElement("Frame", t8, t9)
	end
	t7.KickContainer = showKick
	local showAdmin = p1.props.showAdmin
	if showAdmin then
		local t8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local t9 = {}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385263946",
			[Roact.Event.Activated] = p1.props.uncurryPropsIndex(p1.props.onClickAdmin, index)
		}
		t10.ImageColor3 = if p1.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		t9.Button = createElement("ImageButton", t10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showAdmin = createElement("Frame", t8, t9)
	end
	t7.AdminContainer = showAdmin
	local showUnAdmin = p1.props.showUnAdmin
	if showUnAdmin then
		local t8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local t9 = {}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12600006139",
			[Roact.Event.Activated] = p1.props.uncurryPropsIndex(p1.props.onClickUnAdmin, index)
		}
		t10.ImageColor3 = if p1.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		t9.Button = createElement("ImageButton", t10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showUnAdmin = createElement("Frame", t8, t9)
	end
	t7.UnAdminContainer = showUnAdmin
	t2.Middle = createElement("Frame", t6, t7)
	local v36 = not p1.props.showRequests
	if v36 then
		local t8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(2 / aspectRatio, 0, 1, 0),
			Position = UDim2.new(1 - 2 / aspectRatio, 0, 0, 0)
		}
		local t9 = {
			UIStroke = createElement("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				Color = Color3.new(255/255, 255/255, 255/255)
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local t11 = {}
		local t12 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0)
		}
		local t13 = {
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0.4, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = "Battles",
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		}
		local t14 = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.6, 0),
			Position = UDim2.new(0, 0, 0.4, 0)
		}
		local t15 = {}
		local t16 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.8, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		t16.Text = tostring(p1.props.battlesPlayed or 0)
		t16.Font = Enum.Font.FredokaOne
		t16.LineHeight = 1
		t16.TextScaled = true
		t16.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		t15.Text = createElement("TextLabel", t16)
		t13.Value = createElement("Frame", t14, t15)
		t11.Left = createElement("Frame", t12, t13)
		t11.Line = createElement("Frame", {
			BorderSizePixel = 0,
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BackgroundTransparency = 0.5
		})
		t11.Right = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0)
		}, {
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0.4, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = "W/L",
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			}),
			Value = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0.6, 0),
				Position = UDim2.new(0, 0, 0.4, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = PersistentCrewBattleUtils.calculateWLRatio(p1.props.battlesWon, p1.props.battlesPlayed) or "...",
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		})
		t9.Info = createElement("Frame", t10, t11)
		v36 = createElement("Frame", t8, t9)
	end
	t2.Right = v36
	return createElement("Frame", t, t2)
end
return v1