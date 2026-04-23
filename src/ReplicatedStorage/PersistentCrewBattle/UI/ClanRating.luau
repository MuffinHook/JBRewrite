local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Flag = require(ReplicatedStorage.PersistentCrew.UI.Flag)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local function colorCompAvg(p1) --[[ Line: 8 ]]
	if p1 then
		return (p1.R + p1.G + p1.B) / 3
	else
		return 0
	end
end
local v1 = Roact.PureComponent:extend("ClanRating")
function v1.render(p1) --[[ Line: 16 | Upvalues: ColorUtils (copy), createElement (copy), PaddedContainer (copy), Flag (copy), Roact (copy) ]]
	local aspectRatio = p1.props.aspectRatio
	if typeof(p1.props.clanRating) ~= "string" then
		local v1 = error
		local v2 = typeof(p1.props.clanRating)
		v1("clanRating must be a string but is: " .. v2 .. " " .. tostring(p1.props.clanRating))
	end
	local clanFlagColor = p1.props.clanFlagColor
	local v4
	if if clanFlagColor then (clanFlagColor.R + clanFlagColor.G + clanFlagColor.B) / 3 else 0 < 0.2 then
		v4 = Color3.new(255/255, 255/255, 255/255)
	else
		local v6 = if clanFlagColor then (clanFlagColor.R + clanFlagColor.G + clanFlagColor.B) / 3 else 0
		v4 = if v6 > 0.8 then Color3.new(0/255, 0/255, 0/255) else ColorUtils.brightenBy(clanFlagColor, -0.5)
	end
	local t = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(55, 57, 62),
		Size = p1.props.size,
		Position = p1.props.position
	}
	local t2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local t4 = {}
	local t5 = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1 / aspectRatio, 1),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 0.5,
		paddingBottom = 1
	}
	local t6 = {}
	local t7 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	t7.Text = tostring(p1.props.index)
	t7.TextScaled = true
	t7.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	t6.Text = createElement("TextLabel", t7)
	t4.Rank = createElement(PaddedContainer, t5, t6)
	t4.FlagContainer = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1.5 / aspectRatio, 1),
		position = UDim2.fromScale(1 / aspectRatio, 0),
		paddingLeft = 0.5,
		paddingRight = 0.5
	}, {
		Flag = createElement(Flag, {
			userId = p1.props.ownerUserId,
			flagColor = p1.props.clanFlagColor
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 255/255, 255/255),
			Thickness = 2
		})
	})
	t4.ClanName2 = createElement(PaddedContainer, {
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
			Text = p1.props.ownerName .. "\'s " .. p1.props.clanName,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextColor3 = p1.props.clanFlagColor
		}, {
			UIStroke = createElement("UIStroke", {
				Transparency = 0.6,
				Thickness = 2,
				Color = v4
			})
		})
	})
	t4.CrewView = p1.props.showCrewView and createElement("Frame", {
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
			[Roact.Event.Activated] = function() --[[ Line: 148 | Upvalues: p1 (copy) ]]
				p1.props.attemptViewClanId(p1.props.ownerUserId)
			end
		})
	})
	t4.Right = createElement("Frame", {
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
					Text = p1.props.clanRating,
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		})
	})
	t2.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = 1 / p1.props.paddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, t4)
	return createElement("Frame", t, t2)
end
return v1