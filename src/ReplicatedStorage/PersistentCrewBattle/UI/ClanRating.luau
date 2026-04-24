-- Reviewed by Claude
-- variables reassigned
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
local local1 = Roact.PureComponent:extend("ClanRating")
function local1.render(self)
	local aspectRatio = self.props.aspectRatio
	if typeof(self.props.clanRating) ~= "string" then
		local local1 = error
		local local2 = typeof(self.props.clanRating)
		local1("clanRating must be a string but is: " .. local2 .. " " .. tostring(self.props.clanRating))
	end
	local clanFlagColor = self.props.clanFlagColor
	local local4
	if if clanFlagColor then (clanFlagColor.R + clanFlagColor.G + clanFlagColor.B) / 3 else 0 < 0.2 then
		local4 = Color3.new(255/255, 255/255, 255/255)
	else
		local local6 = if clanFlagColor then (clanFlagColor.R + clanFlagColor.G + clanFlagColor.B) / 3 else 0
		local4 = if local6 > 0.8 then Color3.new(0/255, 0/255, 0/255) else ColorUtils.brightenBy(clanFlagColor, -0.5)
	end
	local t = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(55, 57, 62),
		Size = self.props.size,
		Position = self.props.position
	}
	local table2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local table4 = {}
	local table5 = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1 / aspectRatio, 1),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 0.5,
		paddingBottom = 1
	}
	local table6 = {}
	local table7 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	table7.Text = tostring(self.props.index)
	table7.TextScaled = true
	table7.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	table6.Text = createElement("TextLabel", table7)
	table4.Rank = createElement(PaddedContainer, table5, table6)
	table4.FlagContainer = createElement(PaddedContainer, {
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
	table4.ClanName2 = createElement(PaddedContainer, {
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
				Color = local4
			})
		})
	})
	table4.CrewView = self.props.showCrewView and createElement("Frame", {
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
	table4.Right = createElement("Frame", {
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
	table2.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = 1 / self.props.paddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, table4)
	return createElement("Frame", t, table2)
end
return local1
