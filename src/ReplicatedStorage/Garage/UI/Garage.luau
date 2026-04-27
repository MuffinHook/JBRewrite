local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local createElement = Roact.createElement
local Receipt = require(script.Parent.Receipt)
local Categories = require(script.Parent.Categories)
local Lite = require(script.Parent.Lite)
local RoundButton = require(script.Parent.RoundButton)
local CashBar = require(script.Parent.CashBar)
local PortalCustomize = require(script.Parent.PortalCustomize)
local PortalSpawn = require(script.Parent.PortalSpawn)
local PortalSaves = require(script.Parent.PortalSaves)

local GarageComponent = Roact.PureComponent:extend("Garage")
GarageComponent.defaultProps = {
	size = UDim2.new(1, 0, 1, 0)
}

function GarageComponent.init(self)
	self:setState({
		showAll = false,
		showFavorited = false
	})
	function self.toggleAll()
		self:setState({
			showAll = not self.state.showAll
		})
	end
	function self.toggleFavorited()
		self:setState({
			showFavorited = not self.state.showFavorited
		})
	end
end

function GarageComponent.render(self)
	if not self.props.disabled then
		local slotHasSave = false
		if self.props.page == "Saves" then
			local firstReceiptItem = self.props.receipt[1]
			if firstReceiptItem then
				slotHasSave = self.props.saves[firstReceiptItem.name]
			end
		end
		local numPanels = if slotHasSave then 3 else 2
		local buttonGroupAspectRatio = 1 / (numPanels / 6.678733031674209 + (numPanels - 1) / 39.36)
		local portalProps = {}
		local PortalComponent = nil
		if self.props.page == "Spawn" then
			PortalComponent = PortalSpawn
			portalProps.onClickSpawnVehicle = self.props.onClickSpawnVehicle
			portalProps.onAttemptPurchaseVehicle = self.props.onAttemptPurchaseVehicle
			portalProps.colsPerRow = self.props.colsPerRow
			portalProps.rowsPerPage = self.props.rowsPerPage
		elseif self.props.page == "Customize" then
			PortalComponent = PortalCustomize
			portalProps.attemptEquipItem = self.props.attemptEquipItem
			portalProps.colsPerRow = self.props.colsPerRow
			portalProps.rowsPerPage = self.props.rowsPerPage
			if self.props.category == SaleConsts.CATEGORY_NAME then
				portalProps.colsPerRow = 6
				portalProps.rowsPerPage = 1.5
			end
		elseif self.props.page == "Saves" then
			PortalComponent = PortalSaves
		end
		portalProps.attemptFavoriteItem = self.props.attemptFavoriteItem
		portalProps.showAll = self.state.showAll
		portalProps.onToggleFavorited = self.toggleFavorited
		portalProps.showFavorited = self.state.showFavorited
		portalProps.onToggleAll = self.toggleAll
		assert(PortalComponent ~= nil, "missing Portal for this page")

		local sidebarCategoryPanel = if self.props.page == "Customize" then createElement(Categories, {
			mainRatio = 0.6346339890357949,
			layoutOrder = 5,
			cornerPixel = 4,
			paddingRatio = 78.72,
			categoriesPerPage = self.props.categoriesPerPage
		}) elseif self.props.page == "Spawn" then createElement(Lite, {
			mainRatio = 0.6346339890357949,
			layoutOrder = 5,
			cornerPixel = 4,
			paddingRatio = 39.36,
			upgraded = self.props.premium,
			inPhysical = self.props.inPhysical,
			getRemainingDebounce = self.props.getRemainingDebounce,
			onRequestPremiumUpgrade = self.props.onRequestPremiumUpgrade
		}) else createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 5
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.6346339890357949
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		})

		local rootFrameProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = self.props.size,
			Position = self.props.position,
			AnchorPoint = self.props.anchorPoint
		}
		local rootChildren = {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 3
			})
		}

		local leftPanelProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(0.13666666666666666, 0, 1, 0),
			LayoutOrder = 1
		}
		local leftPanelChildren = {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			}),
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 3.2
				}),
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1.1, 0, 1.1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = "GARAGE",
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				}, {
					UIStroke = createElement("UIStroke", {
						Color = Color3.new(0/255, 0/255, 0/255),
						Thickness = 3
					})
				})
			}),
			Padding2 = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 2
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 39.36
				})
			})
		}

		local choosePageFrameProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 3
		}
		local choosePageChildren = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 2
			}),
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			})
		}

		local spawnButtonProps = {
			aspectRatio = 6.678733031674209
		}
		spawnButtonProps.color = self.props.page == "Spawn" and Color3.fromRGB(98, 222, 253) or Color3.new(0.1, 0.1, 0.1)
		spawnButtonProps.layoutOrder = 1
		spawnButtonProps.title = "SPAWN"
		function spawnButtonProps.onClick()
			self.props.onSelectPage({
				pageName = "Spawn",
				sortId = self.props.sortId,
				garageOwned = self.props.saves
			})
		end
		choosePageChildren.Spawn = createElement(RoundButton, spawnButtonProps)
		choosePageChildren.Padding1 = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 2
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 39.36
			})
		})

		local customizeButtonProps = {}
		customizeButtonProps.locked = not (self.props.inPhysical or self.props.premium) or nil
		customizeButtonProps.disabled = not (self.props.inPhysical or self.props.premium)
		customizeButtonProps.aspectRatio = 6.678733031674209
		customizeButtonProps.color = self.props.page == "Customize" and Color3.fromRGB(98, 222, 253) or Color3.new(0.1, 0.1, 0.1)
		customizeButtonProps.layoutOrder = 3
		customizeButtonProps.title = "CUSTOMIZE"
		function customizeButtonProps.onClick()
			if self.props.inVehicle then
				if self.props.inPhysical or self.props.premium then
					self.props.onSelectPage({
						pageName = "Customize",
						sortId = self.props.sortId,
						categoryName = self.props.category
					})
				else
					self.props.notify("Head to a garage (or buy premium) to customize!")
				end
			else
				self.props.notify("Enter a vehicle to customize it!")
			end
		end
		choosePageChildren.Customize = createElement(RoundButton, customizeButtonProps)
		choosePageChildren.Padding2 = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 4
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 39.36
			})
		})

		local savesButtonProps = {}
		savesButtonProps.locked = not (self.props.inPhysical or self.props.premium) or nil
		savesButtonProps.disabled = not (self.props.inPhysical or self.props.premium)
		savesButtonProps.aspectRatio = 6.678733031674209
		savesButtonProps.color = self.props.page == "Saves" and Color3.fromRGB(98, 222, 253) or Color3.new(0.1, 0.1, 0.1)
		savesButtonProps.layoutOrder = 5
		savesButtonProps.title = "SAVES"
		function savesButtonProps.onClick()
			if self.props.inVehicle then
				if self.props.inPhysical or self.props.premium then
					self.props.onSelectPage({
						pageName = "Saves",
						sortId = self.props.sortId,
						garageSaves = self.props.saves
					})
				else
					self.props.notify("Head to a garage (or buy premium) to use saves!")
				end
			else
				self.props.notify("Enter a vehicle to use saves!")
			end
		end
		choosePageChildren.Saves = createElement(RoundButton, savesButtonProps)

		leftPanelChildren.ChoosePage = createElement("Frame", choosePageFrameProps, choosePageChildren)
		leftPanelChildren.Padding3 = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 4
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 39.36
			})
		})
		leftPanelChildren.Categories = sidebarCategoryPanel

		rootChildren.Left = createElement("Frame", leftPanelProps, leftPanelChildren)
		rootChildren.LeftPadding = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 2
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.010416666666666666
			})
		})
		rootChildren.Center = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(0.7197222222222223, 0, 1, 0),
			LayoutOrder = 3
		}, {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			}),
			Top = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 29.92605
				}),
				CashBar = createElement(CashBar, {
					mainRatio = 29.92605,
					cash = self.props.cash,
					promptCashPurchase = self.props.promptCashPurchase
				})
			}),
			Padding1 = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 2
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 207.28
				})
			}),
			Portal = createElement(PortalComponent, Dictionary.merge({
				portalRatio = 2.3534863602850824,
				paddingRatio = 207.28,
				cornerPixel = 4,
				items = self.props.items,
				owned = self.props.owned,
				equipped = self.props.equipped,
				saves = self.props.saves
			}, portalProps))
		})
		rootChildren.RightPadding = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 4
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.010416666666666666
			})
		})

		local rightPanelProps = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(0.13666666666666666, 0, 1, 0),
			LayoutOrder = 5
		}
		local rightPanelChildren = {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			}),
			Top = createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 5.682599999999999
				})
			}),
			Padding1 = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 2
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 39.36
				})
			})
		}

		local receiptProps = {
			mainRatio = 1 / (2.4390243902439024 - (0.17597578573188333 + 1 / buttonGroupAspectRatio + 0.0508130081300813)),
			cornerPixel = 4,
			paddingRatio = 39.36,
			layoutOrder = 6
		}
		receiptProps.showTotal = self.props.page == "Customize"
		receiptProps.receipt = self.props.receipt
		receiptProps.owned = self.props.owned
		rightPanelChildren.Receipt = createElement(Receipt, receiptProps)
		rightPanelChildren.Padding3 = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 7
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 39.36
			})
		})

		local buttonGroupFrameProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 255/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 8
		}
		local buttonGroupChildren = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = buttonGroupAspectRatio
			}),
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			})
		}

		buttonGroupChildren.Delete = slotHasSave and createElement(RoundButton, {
			aspectRatio = 6.678733031674209,
			color = Color3.fromRGB(100, 100, 100),
			layoutOrder = 1,
			title = "Delete",
			onClick = function()
				self.props.onDeleteSlot(self.props.receipt[1].name)
			end
		})
		buttonGroupChildren.Padding1 = slotHasSave and createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 2
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 39.36
			})
		})

		local primaryButtonProps = {
			aspectRatio = 6.678733031674209,
			color = Color3.fromRGB(134, 195, 81),
			layoutOrder = 3
		}
		primaryButtonProps.disabled = if self.props.page == "Spawn" then true elseif self.props.page == "Customize" then #self.props.receipt == 0 else false
		primaryButtonProps.title = if self.props.page == "Spawn" then "SPAWN" elseif self.props.page == "Saves" then if slotHasSave then "LOAD" else "SAVE" else "BUY ITEMS"
		function primaryButtonProps.onClick()
			if self.props.page ~= "Customize" then
				if self.props.page == "Saves" then
					local firstReceiptItem = self.props.receipt[1]
					if slotHasSave then
						self.props.onClickLoadSlot(firstReceiptItem.name, self.props.saves[firstReceiptItem.name])
					else
						self.props.onClickSaveSlot(firstReceiptItem.name, self.props.equipped)
					end
				else
					if self.props.page ~= "Spawn" then
						error("Primary button clicked on unknown page.")
					end
					return
				end
			end
			local cash = self.props.cash
			local purchasedAny = false
			for i, receiptItem in ipairs(self.props.receipt) do
				local shouldBuy
				shouldBuy = not (self.props.owned[receiptItem.category] and self.props.owned[receiptItem.category][receiptItem.name])
				if receiptItem.limited then
					shouldBuy = false
				end
				if shouldBuy then
					if cash < receiptItem.price then
						self.props.notify("You need more cash to buy this item!")
						break
					end
					cash = cash - receiptItem.price
					self.props.attemptBuyItem(receiptItem.category, receiptItem.name)
					purchasedAny = true
				end
			end
			if purchasedAny and Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 4977134975, {
					Volume = 0.3
				})
			end
		end
		buttonGroupChildren.Buy = createElement(RoundButton, primaryButtonProps)
		buttonGroupChildren.Padding2 = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 4
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 39.36
			})
		})
		buttonGroupChildren.Leave = createElement(RoundButton, {
			aspectRatio = 6.678733031674209,
			color = Color3.fromRGB(235, 60, 0),
			layoutOrder = 5,
			title = "EXIT GARAGE",
			onClick = self.props.onClickLeaveGarage
		})

		rightPanelChildren.Buttons = createElement("Frame", buttonGroupFrameProps, buttonGroupChildren)
		rootChildren.Right = createElement("Frame", rightPanelProps, rightPanelChildren)
		return createElement("Frame", rootFrameProps, rootChildren)
	end
end

function GarageComponent.didMount(self) end
function GarageComponent.willUnmount(self) end
function GarageComponent.didUpdate(self, prevProps, prevState)
	if self.props.disabled ~= prevProps.disabled and self.props.disabled then
		self:setState({
			showAll = false,
			showFavorited = false
		})
	end
end

return RoactRodux.connect(function(state, props)
	return {
		cash = state.cash,
		items = state.garageItems,
		owned = state.garageOwned,
		equipped = state.garageEquipped,
		page = state.garagePage,
		categories = state.garageCategories,
		category = state.garageCategory,
		sortId = state.garageSort,
		receipt = state.garageReceipt,
		saves = state.garageSaves,
		premium = state.garagePremium,
		inPhysical = state.garageInPhysical,
		inVehicle = state.garageInVehicle
	}
end, function(dispatch)
	return {
		onSelectPage = function(pageInfo)
			assert(pageInfo.pageName ~= nil, "pageName is required")
			if Players.LocalPlayer then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.25
				})
			end
			dispatch({
				type = "setPage",
				pageName = pageInfo.pageName,
				sortId = pageInfo.sortId,
				categoryName = pageInfo.categoryName,
				garageSaves = pageInfo.saves,
				garageOwned = pageInfo.garageOwned
			})
		end,
		onClickSaveSlot = function(slotName, equipped)
			dispatch({
				type = "setSaveSlot",
				name = slotName,
				equipped = equipped
			})
		end,
		onClickLoadSlot = function(slotName, saveData)
			dispatch({
				type = "loadSaveSlot",
				name = slotName
			})
		end
	}
end)(GarageComponent)
