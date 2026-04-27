local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Flag = require(ReplicatedStorage.PersistentCrew.UI.Flag)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local function colorCompAvg(self)
	if self then
		return (self.R + self.G + self.B) / 3
	else
		return 0
	end
end
local ClanRatingComponent = Roact.PureComponent:extend("ClanRating")
function ClanRatingComponent.render(self)
	local aspectRatio = self.props.aspectRatio
	if typeof(self.props.clanRating) ~= "string" then
		local throwError = error
		local actualType = typeof(self.props.clanRating)
		throwError("clanRating must be a string but is: " .. actualType .. " " .. tostring(self.props.clanRating))
	end
	local clanFlagColor = self.props.clanFlagColor
	local textColor
	if if clanFlagColor then (clanFlagColor.R + clanFlagColor.G + clanFlagColor.B) / 3 else 0 < 0.2 then
		textColor = Color3.new(255/255, 255/255, 255/255)
	else
		local brightness = if clanFlagColor then (clanFlagColor.R + clanFlagColor.G + clanFlagColor.B) / 3 else 0
		textColor = if brightness > 0.8 then Color3.new(0/255, 0/255, 0/255) else ColorUtils.brightenBy(clanFlagColor, -0.5)
	end
	local containerProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(55, 57, 62),
		Size = self.props.size,
		Position = self.props.position
	}
	local frameChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local mainChildren = {}
	local rankPaddingProps = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1 / aspectRatio, 1),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 0.5,
		paddingBottom = 1
	}
	local rankTextChildren = {}
	local rankTextProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	rankTextProps.Text = tostring(self.props.index)
	rankTextProps.TextScaled = true
	rankTextProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	rankTextChildren.Text = createElement("TextLabel", rankTextProps)
	mainChildren.Rank = createElement(PaddedContainer, rankPaddingProps, rankTextChildren)
	mainChildren.FlagContainer = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1.5 / aspectRatio, 1),
		position = UDim2.fromScale(1 / aspectRatio, 0),
		paddingLeft = 0.5,
		paddingRight = 0.5
	}, {
		Flag = createElement(Flag, {
			userId = self.props.ownerUserId,
			flagColor = self.props.clanFlagColor
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 255/255, 255/255),
			Thickness = 2
		})
	})
	mainChildren.ClanName2 = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1 - 2.5 / aspectRatio - 0.2, 1),
		position = UDim2.fromScale(2.5 / aspectRatio, 0),
		paddingLeft = 0.5,
		paddingRight = 1
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = self.props.ownerName .. "\'s " .. self.props.clanName,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextColor3 = self.props.clanFlagColor
		}, {
			UIStroke = createElement("UIStroke", {
				Transparency = 0.6,
				Thickness = 2,
				Color = textColor
			})
		})
	})
	mainChildren.CrewView = self.props.showCrewView and createElement("Frame", {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.1, 0, 1, 0),
		Position = UDim2.new(0.8, 0, 0, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		UIStroke = createElement("UIStroke", {
			Transparency = 0.5,
			Thickness = 2,
			Color = Color3.new(255/255, 255/255, 255/255)
		}),
		Text = createElement("TextButton", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "View Crew",
			TextTransparency = 0.3,
			Font = Enum.Font.FredokaOne,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			[Roact.Event.Activated] = function()
				self.props.attemptViewClanId(self.props.ownerUserId)
			end
		})
	})
	mainChildren.Right = createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.1, 0, 1, 0),
		Position = UDim2.new(0.9, 0, 0, 0)
	}, {
		UIStroke = createElement("UIStroke", {
			Transparency = 0.5,
			Thickness = 2,
			Color = Color3.new(255/255, 255/255, 255/255)
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Info = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0.4, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = "Rating",
					TextTransparency = 0.3,
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(153/255, 153/255, 153/255)
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
					Text = self.props.clanRating,
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		})
	})
	frameChildren.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = 1 / self.props.paddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, mainChildren)
	return createElement("Frame", containerProps, frameChildren)
end
return ClanRatingComponent
