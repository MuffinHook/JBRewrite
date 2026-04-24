-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local local1 = Roact.PureComponent:extend("Member")
function local1.init(self)
	self:setState({
		settingsOpen = false
	})
	function self.toggleSettings()
		self:setState({
			settingsOpen = not self.state.settingsOpen
		})
	end
end
function local1.render(self)
	local index = self.props.index
	local aspectRatio = self.props.aspectRatio
	local paddingRatio = self.props.paddingRatio
	local t = {
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(62, 65, 78),
		Size = self.props.size,
		Position = self.props.position
	}
	local table2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local table3 = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 255/255, 0/255),
		BackgroundTransparency = 1
	}
	table3.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(self.props.userId)
	table3.Size = UDim2.fromScale(1 / aspectRatio - 2 * paddingRatio / aspectRatio, 1 - 2 * paddingRatio)
	table3.Position = UDim2.fromScale(paddingRatio / aspectRatio, 1 * paddingRatio)
	table3.AnchorPoint = Vector2.new(0, 0)
	local table4 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	local table5 = {
		Transparency = 0.5,
		Thickness = 2
	}
	table5.Color = self.props.isOnline and Color3.fromRGB(80, 163, 97) or Color3.new(255/255, 255/255, 255/255)
	table4.UIStroke = createElement("UIStroke", table5)
	table4.AdminBadge = self.props.isAdmin and createElement("ImageButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.5, 0.5),
		Position = UDim2.fromScale(0.8, 0.8),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "rbxassetid://12385263946"
	})
	table2.Avatar = createElement("ImageLabel", table3, table4)
	table2.Title = createElement("Frame", {
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
			Text = self.props.displayName,
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	local table6 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(2 / aspectRatio, 0, 1, 0),
		Position = UDim2.new(1 - 4 / aspectRatio - paddingRatio / aspectRatio, 0, 0, 0)
	}
	local table7 = {
		UIListLayout = createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
	}
	local showRequestAccept = self.props.showRequestAccept
	if showRequestAccept then
		local table8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local table9 = {}
		local table10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385251660",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickJoinRequestAccept, index)
		}
		table10.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		table9.Button = createElement("ImageButton", table10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showRequestAccept = createElement("Frame", table8, table9)
	end
	table7.JoinRequestAcceptContainer = showRequestAccept
	local showRequestDeny = self.props.showRequestDeny
	if showRequestDeny then
		local table8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 10
		}
		local table9 = {}
		local table10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385265200",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickJoinRequestDeny, index)
		}
		table10.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		table9.Button = createElement("ImageButton", table10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showRequestDeny = createElement("Frame", table8, table9)
	end
	table7.JoinRequestDenyContainer = showRequestDeny
	local showKick = self.props.showKick
	if showKick then
		local table8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 10
		}
		local table9 = {}
		local table10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385265200",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickKick, index)
		}
		table10.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		table9.Button = createElement("ImageButton", table10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showKick = createElement("Frame", table8, table9)
	end
	table7.KickContainer = showKick
	local showAdmin = self.props.showAdmin
	if showAdmin then
		local table8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local table9 = {}
		local table10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385263946",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickAdmin, index)
		}
		table10.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		table9.Button = createElement("ImageButton", table10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showAdmin = createElement("Frame", table8, table9)
	end
	table7.AdminContainer = showAdmin
	local showUnAdmin = self.props.showUnAdmin
	if showUnAdmin then
		local table8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local table9 = {}
		local table10 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12600006139",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickUnAdmin, index)
		}
		table10.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		table9.Button = createElement("ImageButton", table10, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showUnAdmin = createElement("Frame", table8, table9)
	end
	table7.UnAdminContainer = showUnAdmin
	table2.Middle = createElement("Frame", table6, table7)
	local local36 = not self.props.showRequests
	if local36 then
		local table8 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(2 / aspectRatio, 0, 1, 0),
			Position = UDim2.new(1 - 2 / aspectRatio, 0, 0, 0)
		}
		local table9 = {
			UIStroke = createElement("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				Color = Color3.new(255/255, 255/255, 255/255)
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		}
		local table10 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local table11 = {}
		local table12 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0)
		}
		local table13 = {
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
		local table14 = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.6, 0),
			Position = UDim2.new(0, 0, 0.4, 0)
		}
		local table15 = {}
		local table16 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.8, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		table16.Text = tostring(self.props.battlesPlayed or 0)
		table16.Font = Enum.Font.FredokaOne
		table16.LineHeight = 1
		table16.TextScaled = true
		table16.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		table15.Text = createElement("TextLabel", table16)
		table13.Value = createElement("Frame", table14, table15)
		table11.Left = createElement("Frame", table12, table13)
		table11.Line = createElement("Frame", {
			BorderSizePixel = 0,
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BackgroundTransparency = 0.5
		})
		table11.Right = createElement("Frame", {
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
					Text = PersistentCrewBattleUtils.calculateWLRatio(self.props.battlesWon, self.props.battlesPlayed) or "...",
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		})
		table9.Info = createElement("Frame", table10, table11)
		local36 = createElement("Frame", table8, table9)
	end
	table2.Right = local36
	return createElement("Frame", t, table2)
end
return local1
