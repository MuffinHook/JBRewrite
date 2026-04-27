local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Flag = require(ReplicatedStorage.PersistentCrew.UI.Flag)
local TextButton = require(ReplicatedStorage.PersistentCrew.UI.TextButton)
local horizontalSquareGrid = require(ReplicatedStorage.PersistentCrew.UI.horizontalSquareGrid)
local function avatarComponent(self)
	if self.RespondedAt then
		local avatarProperties = {
			BorderSizePixel = 0,
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.new(0.9, 0.9, 0.9),
			Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(self.UserId or 1),
			Size = self.size,
			Position = self.position,
			AnchorPoint = Vector2.new(0, 0)
		}
		local avatarChildren = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				Color = Color3.new(0/255, 0/255, 0/255)
			})
		}
		avatarChildren.AdminBadge = self.IsAdmin and createElement("ImageButton", {
			BackgroundTransparency = 1,
			ZIndex = 3,
			Size = UDim2.fromScale(0.4, 0.4),
			Position = UDim2.fromScale(0.8, 0.8),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385263946"
		})
		return createElement("ImageLabel", avatarProperties, avatarChildren)
	else
		local emptyFrameProperties = {
			BorderSizePixel = 0,
			BackgroundTransparency = 0
		}
		emptyFrameProperties.BackgroundColor3 = if self.RespondedAt ~= nil then Color3.new(255/255, 255/255, 255/255) else Color3.new(102/255, 102/255, 102/255)
		emptyFrameProperties.Size = self.size
		emptyFrameProperties.Position = self.position
		emptyFrameProperties.ZIndex = self.zIndex
		return createElement("Frame", emptyFrameProperties, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				Color = Color3.new(0/255, 0/255, 0/255)
			}),
			Q = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Text = "?",
				Font = Enum.Font.FredokaOne,
				TextScaled = true,
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				TextColor3 = Color3.new(51/255, 51/255, 51/255)
			})
		})
	end
end
local constant = Roact.PureComponent:extend("Responses")
constant.defaultProps = {
	size = UDim2.new(1, 0, 0.3, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.new(0.5, 0, 0.5, 0),
	numPlayersPerTeam = 5
}
function constant.init(self)
	self.maid = Maid.new()
	self:setState({
		dots = 0
	})
end
function constant.render(self)
	local flagSizeRatio = 0.385 / self.props.aspectRatio * 1.5
	local identityColor = Color3.new(51/255, 51/255, 51/255)
	local assemblyStatusText = ("."):rep(self.state.dots - 1) .. ("ASSEMBLING %dv%d BATTLE"):format(self.props.numPlayersPerTeam, self.props.numPlayersPerTeam) .. ("."):rep(self.state.dots - 1)
	local clanColorOurs = self.props.clanColorOurs
	local clanColorTheirs = self.props.clanColorTheirs
	local clanColorOursRgb = ("rgb(%d, %d, %d)"):format(clanColorOurs.r * 255, clanColorOurs.g * 255, clanColorOurs.b * 255)
	local clanColorTheirsRgb = if clanColorTheirs then ("rgb(%d, %d, %d)"):format(clanColorTheirs.r * 255, clanColorTheirs.g * 255, clanColorTheirs.b * 255) else "rgb(255, 255, 255)"
	local clanNameOursFormatted = ("<font color=\"" .. clanColorOursRgb .. "\">%s</font>"):format(self.props.clanNameOurs)
	local clanNameTheirsFormatted = ("<font color=\"" .. clanColorTheirsRgb .. "\">%s</font>"):format(self.props.clanNameTheirs or "")
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		}),
		Container = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			aspectRatio = self.props.aspectRatio,
			verticalPaddingRatio = self.props.verticalPaddingRatio
		}, {
			TitleContainer = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.new(1, 0, 0.13, 0),
				paddingTop = 0,
				paddingBottom = 1,
				paddingLeft = 0,
				paddingRight = 0
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				TextContainer = createElement(PaddedContainer, {
					size = UDim2.fromScale(0.5, 1),
					position = UDim2.fromScale(0.25, 0),
					backgroundTransparency = 1,
					paddingTop = 1,
					paddingBottom = 1,
					paddingLeft = 1,
					paddingRight = 1
				}, {
					UICorner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Text = assemblyStatusText,
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.Bangers,
						TextXAlignment = Enum.TextXAlignment.Center
					})
				}),
				CrewTitleAContainer = createElement(PaddedContainer, {
					size = UDim2.fromScale(0.5, 1),
					position = UDim2.fromScale(0, 0),
					backgroundTransparency = 1,
					paddingTop = 1,
					paddingBottom = 1,
					paddingLeft = 1,
					paddingRight = 1
				}, {
					UICorner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Text = clanNameOursFormatted,
						RichText = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.Bangers,
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				CrewTitleBContainer = createElement(PaddedContainer, {
					size = UDim2.fromScale(0.5, 1),
					position = UDim2.fromScale(0.5, 0),
					backgroundTransparency = 1,
					paddingTop = 1,
					paddingBottom = 1,
					paddingLeft = 1,
					paddingRight = 1
				}, {
					UICorner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Text = clanNameTheirsFormatted,
						RichText = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.Bangers,
						TextXAlignment = Enum.TextXAlignment.Right
					})
				})
			}),
			ClanAFlag = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = identityColor,
				size = UDim2.new(flagSizeRatio, 0, 0.385, 0),
				position = UDim2.new(0, 0, 0.13, 0),
				paddingTop = 0,
				paddingBottom = 0.5,
				paddingLeft = 0,
				paddingRight = 0.5
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Inner = createElement(PaddedContainer, {
					backgroundTransparency = 1
				}, {
					Flag = createElement(Flag, {
						flagColor = clanColorOurs,
						userId = self.props.clanOwnerOurs
					})
				})
			}),
			ClanA = createElement(PaddedContainer, {
				backgroundColor = identityColor,
				size = UDim2.new(1 - flagSizeRatio, 0, 0.385, 0),
				position = UDim2.new(flagSizeRatio, 0, 0.13, 0),
				paddingTop = 0,
				paddingBottom = 0.5,
				paddingLeft = 0.5,
				paddingRight = 0
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Grid = createElement(horizontalSquareGrid, {
					exposePaddedContainerProps = true,
					component = avatarComponent,
					items = self.props.clanMembersOurs,
					numItems = self.props.numPlayersPerTeam
				})
			}),
			ClanBFlag = createElement(PaddedContainer, {
				backgroundColor = identityColor,
				size = UDim2.new(flagSizeRatio, 0, 0.385, 0),
				position = UDim2.new(0, 0, 0.515, 0),
				paddingTop = 0.5,
				paddingBottom = 0,
				paddingLeft = 0,
				paddingRight = 0.5
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Inner = createElement(PaddedContainer, {
					backgroundTransparency = 1
				}, {
					Flag = createElement(Flag, {
						flagColor = clanColorTheirs,
						userId = self.props.clanOwnerTheirs
					})
				})
			}),
			ClanB = createElement(PaddedContainer, {
				backgroundColor = identityColor,
				size = UDim2.new(1 - flagSizeRatio, 0, 0.385, 0),
				position = UDim2.new(flagSizeRatio, 0, 0.515, 0),
				paddingTop = 0.5,
				paddingBottom = 0,
				paddingLeft = 0.5,
				paddingRight = 0
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Grid = createElement(horizontalSquareGrid, {
					exposePaddedContainerProps = true,
					component = avatarComponent,
					items = self.props.clanMembersTheirs,
					numItems = self.props.numPlayersPerTeam
				})
			}),
			FooterContainer = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.new(1, 0, 0.1, 0),
				position = UDim2.fromScale(0, 0.9),
				paddingTop = 1,
				paddingBottom = 0,
				paddingLeft = 0,
				paddingRight = 0
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				UnacceptMatchmaking = createElement(TextButton, {
					text = "UNACCEPT BATTLE",
					backgroundColor = Color3.fromRGB(255, 58, 43),
					size = UDim2.fromScale(1, 1),
					cornerRadius = 4,
					onClick = self.props.onUnAcceptBattleInvite
				})
			})
		})
	})
end
function constant.didMount(self)
	self.maid:GiveTask(Interval.every(0.5):Connect(function()
		self:setState({
			dots = self.state.dots % 4 + 1
		})
	end))
end
function constant.willUnmount(self)
	self.maid:DoCleaning()
end
return constant
