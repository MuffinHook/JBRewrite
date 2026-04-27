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
local SafesShop = Roact.PureComponent:extend("SafesShop")
function SafesShop.init(self)
	self.maid = Maid.new()
	self:setState({
		canPurchase = true
	})
	if Players.LocalPlayer then
		local LocalPlayer = Players.LocalPlayer
		PolicyService.promiseCachedPlayerPolicyInfo(LocalPlayer):andThen(function(policyData)
			if policyData.ArePaidRandomItemsRestricted == true then
				self:setState({
					canPurchase = true,
					policyCashAvailable = LocalPlayer:GetAttribute("NoPaidCash") or 0
				})
				self.maid:GiveTask(LocalPlayer:GetAttributeChangedSignal("NoPaidCash"):Connect(function()
					self:setState({
						policyCashAvailable = LocalPlayer:GetAttribute("NoPaidCash") or 0
					})
				end))
			end
		end)
	end
end
function SafesShop.render(self)
	local color = Color3.new(51/255, 51/255, 51/255)
	local instanceProperties = {
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}
	local children = {}
	local elements = {}
	elements.PolicyCashAvailableBar = if self.state.policyCashAvailable or self.props.policyCashAvailable then createElement(PaddedContainer, {
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
	local topBarPaddingProps = {
		backgroundColor = color,
		paddingTop = 0,
		paddingLeft = 0,
		paddingRight = 0,
		paddingBottom = 0.5,
		size = UDim2.new(1, 0, 0.1, 0)
	}
	local topBarContent = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local buttonsContainerContent = {
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
	local topBarButtonProps = {
		exposePaddedContainerProps = true,
		nextPageTitle = "OPEN SAFES",
		onSelectToggle = self.props.onSelectOpenSafes,
		onSelectExit = self.props.onSelectExit
	}
	topBarButtonProps.policyCashAvailable = self.state.policyCashAvailable or self.props.policyCashAvailable
	buttonsContainerContent.Buttons = createElement(topBarButtonsComponent, topBarButtonProps)
	topBarContent.Inner = createElement(PaddedContainer, {
		backgroundTransparency = 1
	}, buttonsContainerContent)
	elements.TopBar = createElement(PaddedContainer, topBarPaddingProps, topBarContent)
	elements.Left = createElement(PaddedContainer, {
		backgroundColor = color,
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
			items = self.props.sidebarItems,
			metadata = self.props.sidebarItemMetadata
		})
	})
	elements.Body = createElement(PaddedContainer, {
		backgroundColor = color,
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
				items = self.props.items
			})
		})
	})
	elements.Right = createElement(PaddedContainer, {
		backgroundColor = color,
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
			}, self.props.selectedSafeTierData)) })
	})
	local rightBottomProps = {
		backgroundColor = color,
		paddingTop = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0,
		paddingBottom = 0,
		size = UDim2.new(0.175, 0, 0.15, 0),
		position = UDim2.new(0.825, 0, 0.85, 0)
	}
	local rightBottomContent = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	rightBottomContent.Top = if self.state.canPurchase then createElement(PaddedContainer, {
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
			Text = "$" .. String.comma(self.props.selectedSafeTierData.Price),
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
}) else nil
	rightBottomContent.Bottom = if self.state.canPurchase then createElement(PaddedContainer, {
	size = UDim2.new(1, 0, 0.5, 0),
	position = UDim2.new(0, 0, 0.5, 0),
	paddingTop = 0.5,
	backgroundTransparency = 1
}, {
	Button = createElement("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(115, 250, 121),
		Text = "",
		[Roact.Event.Activated] = self.props.onSelectPurchase
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
	rightBottomContent.Warning = if self.state.canPurchase then nil else createElement(PaddedContainer, {
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
	elements.RightBottom = createElement(PaddedContainer, rightBottomProps, rightBottomContent)
	children.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = 1.8,
		verticalPaddingRatio = 128
	}, elements)
	children.AspectRatio = createElement("UIAspectRatioConstraint", {
		AspectRatio = 1.8
	})
	children.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	})
	return createElement("Frame", instanceProperties, children)
end
function SafesShop.didMount(self)  end
return SafesShop
