local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local MemberComponent = Roact.PureComponent:extend("Member")
function MemberComponent.init(self)
	self:setState({
		settingsOpen = false
	})
	function self.toggleSettings()
		self:setState({
			settingsOpen = not self.state.settingsOpen
		})
	end
end
function MemberComponent.render(self)
	local index = self.props.index
	local aspectRatio = self.props.aspectRatio
	local paddingRatio = self.props.paddingRatio
	local mainFrameProps = {
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(62, 65, 78),
		Size = self.props.size,
		Position = self.props.position
	}
	local mainFrameChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local avatarImageProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 255/255, 0/255),
		BackgroundTransparency = 1
	}
	avatarImageProps.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(self.props.userId)
	avatarImageProps.Size = UDim2.fromScale(1 / aspectRatio - 2 * paddingRatio / aspectRatio, 1 - 2 * paddingRatio)
	avatarImageProps.Position = UDim2.fromScale(paddingRatio / aspectRatio, 1 * paddingRatio)
	avatarImageProps.AnchorPoint = Vector2.new(0, 0)
	local avatarChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	local strokeProps = {
		Transparency = 0.5,
		Thickness = 2
	}
	strokeProps.Color = self.props.isOnline and Color3.fromRGB(80, 163, 97) or Color3.new(255/255, 255/255, 255/255)
	avatarChildren.UIStroke = createElement("UIStroke", strokeProps)
	avatarChildren.AdminBadge = self.props.isAdmin and createElement("ImageButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.5, 0.5),
		Position = UDim2.fromScale(0.8, 0.8),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "rbxassetid://12385263946"
	})
	mainFrameChildren.Avatar = createElement("ImageLabel", avatarImageProps, avatarChildren)
	mainFrameChildren.Title = createElement("Frame", {
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
	local actionButtonsContainerProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(2 / aspectRatio, 0, 1, 0),
		Position = UDim2.new(1 - 4 / aspectRatio - paddingRatio / aspectRatio, 0, 0, 0)
	}
	local actionButtonsChildren = {
		UIListLayout = createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder
		})
	}
	local showRequestAccept = self.props.showRequestAccept
	if showRequestAccept then
		local joinRequestAcceptContainerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local joinRequestAcceptChildren = {}
		local joinRequestAcceptButtonProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385251660",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickJoinRequestAccept, index)
		}
		joinRequestAcceptButtonProps.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		joinRequestAcceptChildren.Button = createElement("ImageButton", joinRequestAcceptButtonProps, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showRequestAccept = createElement("Frame", joinRequestAcceptContainerProps, joinRequestAcceptChildren)
	end
	actionButtonsChildren.JoinRequestAcceptContainer = showRequestAccept
	local showRequestDeny = self.props.showRequestDeny
	if showRequestDeny then
		local joinRequestDenyContainerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 10
		}
		local joinRequestDenyChildren = {}
		local joinRequestDenyButtonProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385265200",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickJoinRequestDeny, index)
		}
		joinRequestDenyButtonProps.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		joinRequestDenyChildren.Button = createElement("ImageButton", joinRequestDenyButtonProps, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showRequestDeny = createElement("Frame", joinRequestDenyContainerProps, joinRequestDenyChildren)
	end
	actionButtonsChildren.JoinRequestDenyContainer = showRequestDeny
	local showKick = self.props.showKick
	if showKick then
		local kickContainerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 10
		}
		local kickChildren = {}
		local kickButtonProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385265200",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickKick, index)
		}
		kickButtonProps.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		kickChildren.Button = createElement("ImageButton", kickButtonProps, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showKick = createElement("Frame", kickContainerProps, kickChildren)
	end
	actionButtonsChildren.KickContainer = showKick
	local showAdmin = self.props.showAdmin
	if showAdmin then
		local adminContainerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local adminChildren = {}
		local adminButtonProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385263946",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickAdmin, index)
		}
		adminButtonProps.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		adminChildren.Button = createElement("ImageButton", adminButtonProps, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showAdmin = createElement("Frame", adminContainerProps, adminChildren)
	end
	actionButtonsChildren.AdminContainer = showAdmin
	local showUnAdmin = self.props.showUnAdmin
	if showUnAdmin then
		local unAdminContainerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0),
			LayoutOrder = 5
		}
		local unAdminChildren = {}
		local unAdminButtonProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12600006139",
			[Roact.Event.Activated] = self.props.uncurryPropsIndex(self.props.onClickUnAdmin, index)
		}
		unAdminButtonProps.ImageColor3 = if self.props.networkMutexLocked then Color3.new(0.5, 0.5, 0.5) else Color3.new(255/255, 255/255, 255/255)
		unAdminChildren.Button = createElement("ImageButton", unAdminButtonProps, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
		showUnAdmin = createElement("Frame", unAdminContainerProps, unAdminChildren)
	end
	actionButtonsChildren.UnAdminContainer = showUnAdmin
	mainFrameChildren.Middle = createElement("Frame", actionButtonsContainerProps, actionButtonsChildren)
	local shouldShowStats = not self.props.showRequests
	if shouldShowStats then
		local statsContainerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(2 / aspectRatio, 0, 1, 0),
			Position = UDim2.new(1 - 2 / aspectRatio, 0, 0, 0)
		}
		local statsContainerChildren = {
			UIStroke = createElement("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				Color = Color3.new(255/255, 255/255, 255/255)
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		}
		local infoFrameProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local infoFrameChildren = {}
		local leftStatsProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 1, 0)
		}
		local leftStatsChildren = {
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
		local battlesValueProps = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.6, 0),
			Position = UDim2.new(0, 0, 0.4, 0)
		}
		local battlesValueChildren = {}
		local battlesTextProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.8, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		battlesTextProps.Text = tostring(self.props.battlesPlayed or 0)
		battlesTextProps.Font = Enum.Font.FredokaOne
		battlesTextProps.LineHeight = 1
		battlesTextProps.TextScaled = true
		battlesTextProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		battlesValueChildren.Text = createElement("TextLabel", battlesTextProps)
		leftStatsChildren.Value = createElement("Frame", battlesValueProps, battlesValueChildren)
		infoFrameChildren.Left = createElement("Frame", leftStatsProps, leftStatsChildren)
		infoFrameChildren.Line = createElement("Frame", {
			BorderSizePixel = 0,
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BackgroundTransparency = 0.5
		})
		infoFrameChildren.Right = createElement("Frame", {
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
		statsContainerChildren.Info = createElement("Frame", infoFrameProps, infoFrameChildren)
		shouldShowStats = createElement("Frame", statsContainerProps, statsContainerChildren)
	end
	mainFrameChildren.Right = shouldShowStats
	return createElement("Frame", mainFrameProps, mainFrameChildren)
end
return MemberComponent
