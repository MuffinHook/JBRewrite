-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Countdown = require(ReplicatedStorage.EzUi.Countdown)
require(ReplicatedStorage.EzUi.EzUtils)
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local paddedScrollingGrid = require(ReplicatedStorage.EzUi.paddedScrollingGrid)
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local AllUpdateText = require(ReplicatedStorage.TeamSelect.AllUpdateText)
local TeamSelectImageAssets = require(ReplicatedStorage.TeamSelect.TeamSelectImageAssets)
local createElement = Roact.createElement
local Localization = require(ReplicatedStorage.Module.Localization)
local Settings = require(ReplicatedStorage.Resource.Settings)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
require(ReplicatedStorage.Std.Interval)
local TeamSelectConsts = require(ReplicatedStorage.TeamSelect.TeamSelectConsts)
local t = {
	Police = "rbxassetid://116966056798634",
	Criminal = "rbxassetid://115514483147983",
	Prison = "rbxassetid://92321803810937"
}
local v1 = Roact.PureComponent:extend("TeamSelect")
v1.defaultProps = {
	aspectRatio = 1.75,
	verticalPaddingRatio = 64,
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function v1.init(p1)
	p1.maid = Maid.new()
end
function v1.render(p1)
	local function buttonComponent(p1)
		local t = {
			Size = p1.size,
			Position = p1.position,
			AnchorPoint = p1.anchorPoint,
			BackgroundTransparency = 0.15,
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			Text = " " .. p1.text
		}
		t.TextColor3 = p1.textColor or Color3.fromRGB(255, 255, 255)
		t.TextScaled = true
		t.Font = Enum.Font.Bangers
		t.Selectable = true
		t.TextXAlignment = Enum.TextXAlignment.Left
		t[Roact.Event.Activated] = p1.onClicked
		local t2 = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = Color3.new(255/255, 255/255, 255/255),
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			})
		}
		t2.Countdown = if p1.text == "OG JAILBREAK" then createElement(Countdown, {
	injectPaddedContainerProps = true,
	endTime = TeamSelectConsts.OG_JB_END_TIME,
	size = UDim2.fromScale(0.4, 0.4),
	position = UDim2.fromScale(0.98, 0.8),
	anchorPoint = Vector2.new(1, 1),
	paddingNone = true,
	textXAlignment = Enum.TextXAlignment.Right,
	fontFace = Font.fromEnum(Enum.Font.Bangers),
	timeFormatFunc = function(p1)
		local v2 = p1 % 86400
		return ("%*D %*H %*M"):format(math.floor(p1 / 86400), math.floor(v2 / 3600), (math.floor(v2 % 3600 / 60)))
	end
}) else false
		return createElement("TextButton", t, t2)
	end
	local v1 = AllUpdateText:split("\n")
	local v2 = nil
	local t2 = {}
	local var3 = false
	local t3 = {}
	local t4 = {}
	for v4, v5 in v1 do
		v5 = v5:gsub("^%s+", "")
		if v5:sub(1, 9) == "[version:" or v4 == #v1 then
			if v2 ~= nil then
				table.insert(t2, v2 .. "\n")
			end
			v2 = ""
			var3 = false
		elseif var3 then
			v2 = v2 .. "\n" .. v5
		else
			table.insert(t3, v5)
			var3 = true
		end
	end
	assert(#t2 == #t3)
	local t5 = {}
	local t6 = {}
	for i = #t2, 1, -1 do
		table.insert(t5, t2[i])
		table.insert(t6, t3[i])
	end
	for v9, v10 in t5 do
		table.insert(t4, createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 0.15, 0),
			Text = t6[v9],
			LayoutOrder = v9 * 3,
			Font = Enum.Font.SourceSansBold,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			TextScaled = true
		}, {
			Stroke = createElement("UIStroke", {
				Thickness = 1,
				Color = Color3.new(102/255, 51/255, 51/255),
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			})
		}))
		table.insert(t4, createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.7, 0),
			RichText = true,
			Text = t5[v9],
			LayoutOrder = v9 * 3 + 1,
			Font = Enum.Font.SourceSansBold,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			TextScaled = true
		}))
		table.insert(t4, createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BorderSizePixel = 0,
			LayoutOrder = v9 * 3 + 2
		}))
	end
	t4.ListLayout = createElement("UIListLayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 0)
	})
	local color16 = Color3.fromHex("6687ce")
	local color17 = Color3.fromHex("de4833")
	local color18 = Color3.fromRGB(253, 123, 49)
	local function getText(p1, p2)
		return createElement("TextLabel", {
			Size = UDim2.fromScale(1, 0.2),
			Position = UDim2.fromScale(0, 0.9),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			Text = p1,
			Font = Enum.Font.Bangers,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = p2
			})
		})
	end
	local function getNumPlayers(p1, p2)
		return createElement("TextLabel", {
			Size = UDim2.fromScale(0.4, 0.09),
			Position = UDim2.fromScale(0.5, 0.9),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Text = ("%* PLAYERS"):format(p1 or 0),
			Font = Enum.Font.Bangers,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = p2
			})
		})
	end
	local v19, v20 = Roact.createBinding(color16)
	local _, _2 = Roact.createBinding(color17)
	return createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	}, {
		BadimoLogo = createElement("ImageLabel", {
			Size = UDim2.fromScale(0.05, 0.05),
			Position = UDim2.new(0, 5, 1, -5),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			Image = TeamSelectImageAssets.BadimoLogo
		}, {
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = 2
			})
		}),
		RightContainer = createElement("Frame", {
			Position = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(1, 1),
			Size = UDim2.fromScale(0.25, 1),
			BackgroundTransparency = 1
		}, {
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.5
			}),
			Inner = createElement(PaddedContainer, {
				verticalPaddingRatio = 64,
				aspectRatio = 0.5,
				paddingNone = true,
				backgroundTransparency = 1
			}, {
				UpdateContainer = createElement(PaddedContainer, {
					verticalPaddingRatio = 0,
					aspectRatio = 1,
					position = UDim2.fromScale(0, 0.55),
					size = UDim2.fromScale(1, 0.25),
					backgroundColor = Color3.new(51/255, 51/255, 51/255),
					backgroundTransparency = 0.5,
					paddingLeft = 0,
					paddingRight = 1,
					paddingBottom = 0,
					paddingTop = 0
				}, {
					UICorner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 8)
					}),
					UIStroke = createElement("UIStroke", {
						Thickness = 2,
						Transparency = 0.5,
						Color = Color3.new(0.1, 0.1, 0.1)
					}),
					ScrollingFrame = createElement(PaddedContainer, {
						backgroundTransparency = 1,
						paddingLeft = 0.5,
						paddingTop = 0.5,
						paddingRight = 0.5,
						paddingBottom = 0.5
					}, {
						ScrollingFrame = createElement("ScrollingFrame", {
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
							BorderSizePixel = 0,
							ScrollBarThickness = 10,
							ScrollBarImageColor3 = Color3.new(255/255, 255/255, 255/255),
							Size = UDim2.fromScale(1, 1),
							CanvasSize = UDim2.new(0, 0, 0, 0),
							AutomaticCanvasSize = Enum.AutomaticSize.Y,
							ElasticBehavior = Enum.ElasticBehavior.Always,
							VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
							VerticalScrollBarInset = Enum.ScrollBarInset.None
						}, t4)
					})
				}),
				Buttons = createElement(PaddedContainer, {
					size = UDim2.fromScale(1, 0.2),
					position = UDim2.fromScale(0, 0.8),
					paddingBottom = 1,
					paddingRight = 1,
					paddingTop = 1,
					paddingLeft = 0,
					backgroundTransparency = 1
				}, {
					Inner = createElement(PaddedContainer, {
						paddingLeft = -1,
						paddingTop = -1,
						paddingBottom = -1,
						paddingRight = -1,
						backgroundTransparency = 1
					}, {
						ServerButtons = createElement(paddedScrollingGrid, {
							exposePaddedContainerProps = true,
							rowsPerPage = 3,
							colsPerRow = 1,
							component = buttonComponent,
							items = p1.props.serverButtons
						})
					})
				})
			})
		}),
		Frame = createElement("Frame", {
			Size = p1.props.size,
			Position = p1.props.position,
			AnchorPoint = p1.props.anchorPoint,
			BackgroundTransparency = 1
		}, {
			MiddleContainer = createElement(PaddedContainer, {
				verticalPaddingRatio = p1.props.verticalPaddingRatio,
				aspectRatio = p1.props.aspectRatio,
				anchorPoint = Vector2.new(0.5, 0.5),
				position = UDim2.fromScale(0.5, 0.45),
				size = UDim2.fromScale(0.5, 0.5),
				paddingNone = true,
				backgroundTransparency = 1
			}, {
				TeamsContainer = createElement(PaddedContainer, {
					verticalPaddingRatio = 0,
					aspectRatio = 1,
					anchorPoint = Vector2.new(0.5, 0.5),
					position = UDim2.fromScale(0.5, 0.55),
					size = UDim2.fromScale(1, 0.5),
					paddingNone = true,
					backgroundTransparency = 1
				}, {
					JailbreakLogo = createElement("ImageLabel", {
						Size = UDim2.fromScale(0.9, 0.5),
						Position = UDim2.fromScale(0.5, 0),
						AnchorPoint = Vector2.new(0.5, 1),
						BackgroundTransparency = 1,
						Image = TeamSelectImageAssets.JailbreakLogo
					}, {
						UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
							AspectRatio = 2.2
						})
					}),
					Text = createElement("TextLabel", {
						Size = UDim2.fromScale(0.75, 0.1),
						Position = UDim2.fromScale(0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundTransparency = 1,
						Text = "CHOOSE YOUR SIDE!",
						Font = Enum.Font.Bangers,
						TextScaled = true,
						TextColor3 = Color3.fromRGB(255, 255, 255)
					}, {
						UIStroke = createElement("UIStroke", {
							Thickness = 1,
							Color = Color3.fromRGB(0, 0, 0)
						})
					}),
					ImagesContainer = createElement(PaddedContainer, {
						verticalPaddingRatio = 0,
						anchorPoint = Vector2.new(0, 0),
						position = UDim2.fromScale(0, 0.1),
						size = UDim2.fromScale(1, 0.9),
						paddingLeft = 0,
						paddingRight = 0,
						paddingTop = 2,
						paddingBottom = 0,
						backgroundTransparency = 1
					}, {
						PoliceTeam = createElement("ImageButton", {
							Size = UDim2.fromScale(0.45, 1),
							AnchorPoint = Vector2.new(1, 0),
							Position = UDim2.fromScale(0.48, 0),
							BackgroundTransparency = 0,
							BackgroundColor3 = v19,
							Image = t.Police,
							[Roact.Event.Activated] = function()
								p1.props.onTeamSelected(Settings.EnumTeam.Police)
							end,
							[Roact.Event.MouseEnter] = function()
								v20(ColorUtils.brightenBy(color16, -0.5))
							end,
							[Roact.Event.MouseLeave] = function()
								v20(color16)
							end,
							Selectable = true
						}, {
							UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
								AspectRatio = 1
							}),
							UICorner = createElement("UICorner", {
								CornerRadius = UDim.new(1)
							}),
							UIStroke = createElement("UIStroke", {
								Thickness = 3,
								Color = v19
							}),
							Text = getText(Localization:FormatByKey("Teams.TeamPolice"), color16),
							NumPlayers = getNumPlayers(p1.props.numPolice, color16)
						}),
						NonPoliceTeam = (function()
							local isAllowCriminal = p1.props.allowCriminal == true
							local v1, v2, var3
							if isAllowCriminal then
								v1 = Settings.EnumTeam.Criminal
								v2 = color17
								var3 = Localization:FormatByKey("Teams.TeamCriminal")
							else
								v1 = Settings.EnumTeam.Prisoner
								v2 = color18
								var3 = Localization:FormatByKey("Teams.TeamPrisoner")
							end
							local v6, v7 = Roact.createBinding(v2)
							local t2 = {
								Size = UDim2.fromScale(0.45, 1),
								AnchorPoint = Vector2.new(0, 0),
								Position = UDim2.fromScale(0.52, 0),
								BackgroundTransparency = 0,
								BackgroundColor3 = v6
							}
							t2.Image = isAllowCriminal and t.Criminal or t.Prison
							t2[Roact.Ref] = p1.props.criminalButtonRef
							t2[Roact.Event.Activated] = function()
								p1.props.onTeamSelected(v1)
							end
							t2[Roact.Event.MouseEnter] = function()
								v7(ColorUtils.brightenBy(v2, -0.5))
							end
							t2[Roact.Event.MouseLeave] = function()
								v7(v2)
							end
							t2.Selectable = true
							return createElement("ImageButton", t2, {
								UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
									AspectRatio = 1
								}),
								UICorner = createElement("UICorner", {
									CornerRadius = UDim.new(1)
								}),
								UIStroke = createElement("UIStroke", {
									Thickness = 3,
									Color = v6
								}),
								Text = getText(var3, v2),
								NumPlayers = getNumPlayers(p1.props.numCriminals, v2)
							})
						end)()
					})
				})
			})
		})
	})
end
function v1.willUnmount(p1)
	p1.maid:Destroy()
end
return v1
