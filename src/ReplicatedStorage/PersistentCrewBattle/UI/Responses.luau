local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Flag = require(ReplicatedStorage.PersistentCrew.UI.Flag)
local TextButton = require(ReplicatedStorage.PersistentCrew.UI.TextButton)
local horizontalSquareGrid = require(ReplicatedStorage.PersistentCrew.UI.horizontalSquareGrid)
local function avatarComponent(p1) --[[ Line: 12 | Upvalues: createElement (copy) ]]
	if p1.RespondedAt then
		local t = {
			BorderSizePixel = 0,
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.new(0.9, 0.9, 0.9),
			Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(p1.UserId or 1),
			Size = p1.size,
			Position = p1.position,
			AnchorPoint = Vector2.new(0, 0)
		}
		local t2 = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				Color = Color3.new(0/255, 0/255, 0/255)
			})
		}
		t2.AdminBadge = p1.IsAdmin and createElement("ImageButton", {
			BackgroundTransparency = 1,
			ZIndex = 3,
			Size = UDim2.fromScale(0.4, 0.4),
			Position = UDim2.fromScale(0.8, 0.8),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = "rbxassetid://12385263946"
		})
		return createElement("ImageLabel", t, t2)
	else
		local t = {
			BorderSizePixel = 0,
			BackgroundTransparency = 0
		}
		t.BackgroundColor3 = if p1.RespondedAt ~= nil then Color3.new(255/255, 255/255, 255/255) else Color3.new(102/255, 102/255, 102/255)
		t.Size = p1.size
		t.Position = p1.position
		t.ZIndex = p1.zIndex
		return createElement("Frame", t, {
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
local v1 = Roact.PureComponent:extend("Responses")
v1.defaultProps = {
	size = UDim2.new(1, 0, 0.3, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.new(0.5, 0, 0.5, 0),
	numPlayersPerTeam = 5
}
function v1.init(p1) --[[ Line: 81 | Upvalues: Maid (copy) ]]
	p1.maid = Maid.new()
	p1:setState({
		dots = 0
	})
end
function v1.render(p1) --[[ Line: 87 | Upvalues: createElement (copy), PaddedContainer (copy), Flag (copy), horizontalSquareGrid (copy), avatarComponent (copy), TextButton (copy) ]]
	local v1 = 0.385 / p1.props.aspectRatio * 1.5
	local v2 = Color3.new(51/255, 51/255, 51/255)
	local v3 = ("."):rep(p1.state.dots - 1) .. ("ASSEMBLING %dv%d BATTLE"):format(p1.props.numPlayersPerTeam, p1.props.numPlayersPerTeam) .. ("."):rep(p1.state.dots - 1)
	local clanColorOurs = p1.props.clanColorOurs
	local clanColorTheirs = p1.props.clanColorTheirs
	local v4 = ("rgb(%d, %d, %d)"):format(clanColorOurs.r * 255, clanColorOurs.g * 255, clanColorOurs.b * 255)
	local v5 = if clanColorTheirs then ("rgb(%d, %d, %d)"):format(clanColorTheirs.r * 255, clanColorTheirs.g * 255, clanColorTheirs.b * 255) else "rgb(255, 255, 255)"
	local v7 = ("<font color=\"" .. v4 .. "\">%s</font>"):format(p1.props.clanNameOurs)
	local v8 = ("<font color=\"" .. v5 .. "\">%s</font>"):format(p1.props.clanNameTheirs or "")
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = p1.props.aspectRatio
		}),
		Container = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			aspectRatio = p1.props.aspectRatio,
			verticalPaddingRatio = p1.props.verticalPaddingRatio
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
						Text = v3,
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
						Text = v7,
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
						Text = v8,
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
				backgroundColor = v2,
				size = UDim2.new(v1, 0, 0.385, 0),
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
						userId = p1.props.clanOwnerOurs
					})
				})
			}),
			ClanA = createElement(PaddedContainer, {
				backgroundColor = v2,
				size = UDim2.new(1 - v1, 0, 0.385, 0),
				position = UDim2.new(v1, 0, 0.13, 0),
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
					items = p1.props.clanMembersOurs,
					numItems = p1.props.numPlayersPerTeam
				})
			}),
			ClanBFlag = createElement(PaddedContainer, {
				backgroundColor = v2,
				size = UDim2.new(v1, 0, 0.385, 0),
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
						userId = p1.props.clanOwnerTheirs
					})
				})
			}),
			ClanB = createElement(PaddedContainer, {
				backgroundColor = v2,
				size = UDim2.new(1 - v1, 0, 0.385, 0),
				position = UDim2.new(v1, 0, 0.515, 0),
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
					items = p1.props.clanMembersTheirs,
					numItems = p1.props.numPlayersPerTeam
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
					onClick = p1.props.onUnAcceptBattleInvite
				})
			})
		})
	})
end
function v1.didMount(p1) --[[ Line: 349 | Upvalues: Interval (copy) ]]
	p1.maid:GiveTask(Interval.every(0.5):Connect(function() --[[ Line: 350 | Upvalues: p1 (copy) ]]
		p1:setState({
			dots = p1.state.dots % 4 + 1
		})
	end))
end
function v1.willUnmount(p1) --[[ Line: 356 ]]
	p1.maid:DoCleaning()
end
return v1