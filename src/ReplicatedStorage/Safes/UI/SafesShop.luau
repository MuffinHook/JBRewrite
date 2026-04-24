-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local String = require(ReplicatedStorage.Std.String)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local PolicyService = require(ReplicatedStorage.Policy.PolicyService)
local SafeComponent = require(script.Parent.SafeComponent)
local safeInfoComponent = require(script.Parent.safeInfoComponent)
local paddedScrollingGrid = require(script.Parent.paddedScrollingGrid)
local topBarButtonsComponent = require(script.Parent.topBarButtonsComponent)
local rewardCardComponent = require(ReplicatedStorage.RewardSpinner.UI.rewardCardComponent)
local bodyTopBarComponent = require(script.Parent.bodyTopBarComponent)
local v1 = Roact.PureComponent:extend("SafesShop")
function v1.init(p1)
	p1.maid = Maid.new()
	p1:setState({
		canPurchase = true
	})
	if Players.LocalPlayer then
		local LocalPlayer = Players.LocalPlayer
		PolicyService.promiseCachedPlayerPolicyInfo(LocalPlayer):andThen(function(p12)
			if p12.ArePaidRandomItemsRestricted == true then
				p1:setState({
					canPurchase = true,
					policyCashAvailable = LocalPlayer:GetAttribute("NoPaidCash") or 0
				})
				p1.maid:GiveTask(LocalPlayer:GetAttributeChangedSignal("NoPaidCash"):Connect(function()
					p1:setState({
						policyCashAvailable = LocalPlayer:GetAttribute("NoPaidCash") or 0
					})
				end))
			end
		end)
	end
end
function v1.render(p1)
	local v1 = Color3.new(51/255, 51/255, 51/255)
	local t = {
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}
	local t2 = {}
	local t4 = {}
	t4.PolicyCashAvailableBar = if p1.state.policyCashAvailable or p1.props.policyCashAvailable then createElement(PaddedContainer, {
	backgroundColor = Color3.new(51/255, 51/255, 51/255),
	size = UDim2.new(1, 0, 0.05, 0),
	position = UDim2.new(0, 0, -0.05, 0),
	paddingTop = 0,
	paddingBottom = 1,
	paddingLeft = 0,
	paddingRight = 0
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	}),
	Text = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.9, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = "Hey! Due to local laws, you may only spend the cash you\'ve earned, not paid for. Below is your available cash for safes.",
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.Bangers,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	})
}) else nil
	local t5 = {
		backgroundColor = v1,
		paddingTop = 0,
		paddingLeft = 0,
		paddingRight = 0,
		paddingBottom = 0.5,
		size = UDim2.new(1, 0, 0.1, 0)
	}
	local t6 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local t8 = {
		Title = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1.25, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "SAFE STORE",
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	}
	local t9 = {
		exposePaddedContainerProps = true,
		nextPageTitle = "OPEN SAFES",
		onSelectToggle = p1.props.onSelectOpenSafes,
		onSelectExit = p1.props.onSelectExit
	}
	t9.policyCashAvailable = p1.state.policyCashAvailable or p1.props.policyCashAvailable
	t8.Buttons = createElement(topBarButtonsComponent, t9)
	t6.Inner = createElement(PaddedContainer, {
		backgroundTransparency = 1
	}, t8)
	t4.TopBar = createElement(PaddedContainer, t5, t6)
	t4.Left = createElement(PaddedContainer, {
		backgroundColor = v1,
		paddingTop = 0.5,
		paddingLeft = 0,
		paddingRight = 0.5,
		paddingBottom = 0,
		size = UDim2.new(0.12, 0, 0.9, 0),
		position = UDim2.new(0, 0, 0.1, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Icons = createElement(paddedScrollingGrid, {
			exposePaddedContainerProps = true,
			paddingRatio = 32,
			rowsPerPage = 4.5,
			colsPerRow = 1,
			component = SafeComponent,
			items = p1.props.sidebarItems,
			metadata = p1.props.sidebarItemMetadata
		})
	})
	t4.Body = createElement(PaddedContainer, {
		backgroundColor = v1,
		paddingTop = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0.5,
		paddingBottom = 0,
		size = UDim2.new(0.7050000000000001, 0, 0.9, 0),
		position = UDim2.new(0.12, 0, 0.1, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Top = createElement(bodyTopBarComponent, {
			exposePaddedContainerProps = true
		}),
		Body = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.9, 0),
			Position = UDim2.new(0, 0, 0.1, 0)
		}, {
			Icons = createElement(paddedScrollingGrid, {
				exposePaddedContainerProps = true,
				paddingRatio = 32,
				rowsPerPage = 2.25,
				colsPerRow = 5,
				component = rewardCardComponent,
				items = p1.props.items
			})
		})
	})
	t4.Right = createElement(PaddedContainer, {
		backgroundColor = v1,
		paddingTop = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0,
		paddingBottom = 0.5,
		size = UDim2.new(0.175, 0, 0.75, 0),
		position = UDim2.new(0.825, 0, 0.1, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Inner = createElement(PaddedContainer, {
			backgroundTransparency = 1
		}, { createElement(safeInfoComponent, Dictionary.merge({
				exposePaddedContainerProps = true
			}, p1.props.selectedSafeTierData)) })
	})
	local t10 = {
		backgroundColor = v1,
		paddingTop = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0,
		paddingBottom = 0,
		size = UDim2.new(0.175, 0, 0.15, 0),
		position = UDim2.new(0.825, 0, 0.85, 0)
	}
	local t11 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	t11.Top = if p1.state.canPurchase then createElement(PaddedContainer, {
	backgroundTransparency = 1,
	size = UDim2.new(1, 0, 0.5, 0),
	paddingBottom = 0.5
}, {
	Title = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0)
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "$" .. String.comma(p1.props.selectedSafeTierData.Price),
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
}) else nil
	t11.Bottom = if p1.state.canPurchase then createElement(PaddedContainer, {
	size = UDim2.new(1, 0, 0.5, 0),
	position = UDim2.new(0, 0, 0.5, 0),
	paddingTop = 0.5,
	backgroundTransparency = 1
}, {
	Button = createElement("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(115, 250, 121),
		Text = "",
		[Roact.Event.Activated] = p1.props.onSelectPurchase
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "PURCHASE",
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(0/255, 0/255, 0/255)
		})
	})
}) else nil
	t11.Warning = if p1.state.canPurchase then nil else createElement(PaddedContainer, {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	paddingTop = 0.5,
	backgroundTransparency = 1
}, {
	Text = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "Paid random items are restricted for this account.",
		TextScaled = true,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	})
})
	t4.RightBottom = createElement(PaddedContainer, t10, t11)
	t2.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = 1.8,
		verticalPaddingRatio = 128
	}, t4)
	t2.AspectRatio = createElement("UIAspectRatioConstraint", {
		AspectRatio = 1.8
	})
	t2.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	})
	return createElement("Frame", t, t2)
end
function v1.didMount(p1)  end
return v1
