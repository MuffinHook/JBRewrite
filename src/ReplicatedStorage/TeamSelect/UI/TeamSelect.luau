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
local teamImageAssets = {
	Police = "rbxassetid://116966056798634",
	Criminal = "rbxassetid://115514483147983",
	Prison = "rbxassetid://92321803810937"
}
local TeamSelectComponent = Roact.PureComponent:extend("TeamSelect")
TeamSelectComponent.defaultProps = {
	aspectRatio = 1.75,
	verticalPaddingRatio = 64,
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function TeamSelectComponent.init(self)
	self.maid = Maid.new()
end
function TeamSelectComponent.render(componentProps)
	local function buttonComponent(buttonProps)
		local buttonProperties = {
			Size = buttonProps.size,
			Position = buttonProps.position,
			AnchorPoint = buttonProps.anchorPoint,
			BackgroundTransparency = 0.15,
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			Text = " " .. buttonProps.text
		}
		buttonProperties.TextColor3 = buttonProps.textColor or Color3.fromRGB(255, 255, 255)
		buttonProperties.TextScaled = true
		buttonProperties.Font = Enum.Font.Bangers
		buttonProperties.Selectable = true
		buttonProperties.TextXAlignment = Enum.TextXAlignment.Left
		buttonProperties[Roact.Event.Activated] = buttonProps.onClicked
		local childrenElements = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = Color3.new(255/255, 255/255, 255/255),
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			})
		}
		childrenElements.Countdown = if buttonProps.text == "OG JAILBREAK" then createElement(Countdown, {
	injectPaddedContainerProps = true,
	endTime = TeamSelectConsts.OG_JB_END_TIME,
	size = UDim2.fromScale(0.4, 0.4),
	position = UDim2.fromScale(0.98, 0.8),
	anchorPoint = Vector2.new(1, 1),
	paddingNone = true,
	textXAlignment = Enum.TextXAlignment.Right,
	fontFace = Font.fromEnum(Enum.Font.Bangers),
	timeFormatFunc = function(totalSeconds)
		local secondsWithoutDays = totalSeconds % 86400
		return ("%*D %*H %*M"):format(math.floor(totalSeconds / 86400), math.floor(secondsWithoutDays / 3600), (math.floor(secondsWithoutDays % 3600 / 60)))
	end
}) else false
		return createElement("TextButton", buttonProperties, childrenElements)
	end
	local updateLines = AllUpdateText:split("\n")
	local currentVersionText = nil
	local versionTexts = {}
	local isInVersion = false
	local descriptionTexts = {}
	local updatesList = {}
	for lineIndex, line in updateLines do
		line = line:gsub("^%s+", "")
		if line:sub(1, 9) == "[version:" or lineIndex == #updateLines then
			if currentVersionText ~= nil then
				table.insert(versionTexts, currentVersionText .. "\n")
			end
			currentVersionText = ""
			isInVersion = false
		elseif isInVersion then
			currentVersionText = currentVersionText .. "\n" .. line
		else
			table.insert(descriptionTexts, line)
			isInVersion = true
		end
	end
	assert(#versionTexts == #descriptionTexts)
	local reversedVersions = {}
	local reversedDescriptions = {}
	for i = #versionTexts, 1, -1 do
		table.insert(reversedVersions, versionTexts[i])
		table.insert(reversedDescriptions, descriptionTexts[i])
	end
	for updateIndex, updateVersion in reversedVersions do
		table.insert(updatesList, createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 0.15, 0),
			Text = reversedDescriptions[updateIndex],
			LayoutOrder = updateIndex * 3,
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
		table.insert(updatesList, createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.7, 0),
			RichText = true,
			Text = reversedVersions[updateIndex],
			LayoutOrder = updateIndex * 3 + 1,
			Font = Enum.Font.SourceSansBold,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			TextScaled = true
		}))
		table.insert(updatesList, createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BorderSizePixel = 0,
			LayoutOrder = updateIndex * 3 + 2
		}))
	end
	updatesList.ListLayout = createElement("UIListLayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 0)
	})
	local policeColor = Color3.fromHex("6687ce")
	local criminalColor = Color3.fromHex("de4833")
	local prisonerColor = Color3.fromRGB(253, 123, 49)
	local function getText(labelText, strokeColor)
		return createElement("TextLabel", {
			Size = UDim2.fromScale(1, 0.2),
			Position = UDim2.fromScale(0, 0.9),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			Text = labelText,
			Font = Enum.Font.Bangers,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = strokeColor
			})
		})
	end
	local function getNumPlayers(playerCount, strokeColor)
		return createElement("TextLabel", {
			Size = UDim2.fromScale(0.4, 0.09),
			Position = UDim2.fromScale(0.5, 0.9),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Text = ("%* PLAYERS"):format(playerCount or 0),
			Font = Enum.Font.Bangers,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = strokeColor
			})
		})
	end
	local policeColorBinding, setPoliceColor = Roact.createBinding(policeColor)
	local _, _2 = Roact.createBinding(criminalColor)
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
						}, updatesList)
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
							items = componentProps.props.serverButtons
						})
					})
				})
			})
		}),
		Frame = createElement("Frame", {
			Size = componentProps.props.size,
			Position = componentProps.props.position,
			AnchorPoint = componentProps.props.anchorPoint,
			BackgroundTransparency = 1
		}, {
			MiddleContainer = createElement(PaddedContainer, {
				verticalPaddingRatio = componentProps.props.verticalPaddingRatio,
				aspectRatio = componentProps.props.aspectRatio,
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
							BackgroundColor3 = policeColorBinding,
							Image = teamImageAssets.Police,
							[Roact.Event.Activated] = function()
								componentProps.props.onTeamSelected(Settings.EnumTeam.Police)
							end,
							[Roact.Event.MouseEnter] = function()
								setPoliceColor(ColorUtils.brightenBy(policeColor, -0.5))
							end,
							[Roact.Event.MouseLeave] = function()
								setPoliceColor(policeColor)
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
								Color = policeColorBinding
							}),
							Text = getText(Localization:FormatByKey("Teams.TeamPolice"), policeColor),
							NumPlayers = getNumPlayers(componentProps.props.numPolice, policeColor)
						}),
						NonPoliceTeam = (function()
							local isAllowCriminal = componentProps.props.allowCriminal == true
							local selectedTeam, teamColor, teamLabel
							if isAllowCriminal then
								selectedTeam = Settings.EnumTeam.Criminal
								teamColor = criminalColor
								teamLabel = Localization:FormatByKey("Teams.TeamCriminal")
							else
								selectedTeam = Settings.EnumTeam.Prisoner
								teamColor = prisonerColor
								teamLabel = Localization:FormatByKey("Teams.TeamPrisoner")
							end
							local teamColorBinding, setTeamColor = Roact.createBinding(teamColor)
							local buttonProps = {
								Size = UDim2.fromScale(0.45, 1),
								AnchorPoint = Vector2.new(0, 0),
								Position = UDim2.fromScale(0.52, 0),
								BackgroundTransparency = 0,
								BackgroundColor3 = teamColorBinding
							}
							buttonProps.Image = isAllowCriminal and teamImageAssets.Criminal or teamImageAssets.Prison
							buttonProps[Roact.Ref] = componentProps.props.criminalButtonRef
							buttonProps[Roact.Event.Activated] = function()
								componentProps.props.onTeamSelected(selectedTeam)
							end
							buttonProps[Roact.Event.MouseEnter] = function()
								setTeamColor(ColorUtils.brightenBy(teamColor, -0.5))
							end
							buttonProps[Roact.Event.MouseLeave] = function()
								setTeamColor(teamColor)
							end
							buttonProps.Selectable = true
							return createElement("ImageButton", buttonProps, {
								UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
									AspectRatio = 1
								}),
								UICorner = createElement("UICorner", {
									CornerRadius = UDim.new(1)
								}),
								UIStroke = createElement("UIStroke", {
									Thickness = 3,
									Color = teamColorBinding
								}),
								Text = getText(teamLabel, teamColor),
								NumPlayers = getNumPlayers(componentProps.props.numCriminals, teamColor)
							})
						end)()
					})
				})
			})
		})
	})
end
function TeamSelectComponent.willUnmount(self)
	self.maid:Destroy()
end
return TeamSelectComponent
