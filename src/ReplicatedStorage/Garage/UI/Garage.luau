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
local v1 = Roact.PureComponent:extend("Garage")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0)
}
function v1.init(p1) --[[ Line: 23 ]]
	p1:setState({
		showAll = false,
		showFavorited = false
	})
	function p1.toggleAll() --[[ Line: 28 | Upvalues: p1 (copy) ]]
		p1:setState({
			showAll = not p1.state.showAll
		})
	end
	function p1.toggleFavorited() --[[ Line: 33 | Upvalues: p1 (copy) ]]
		p1:setState({
			showFavorited = not p1.state.showFavorited
		})
	end
end
function v1.render(p1) --[[ Line: 39 | Upvalues: PortalSpawn (copy), PortalCustomize (copy), SaleConsts (copy), PortalSaves (copy), createElement (copy), Categories (copy), Lite (copy), RoundButton (copy), CashBar (copy), Dictionary (copy), Receipt (copy), Players (copy), Audio (copy) ]]
	if not p1.props.disabled then
		local v1 = false
		if p1.props.page == "Saves" then
			local v2 = p1.props.receipt[1]
			if v2 then
				v1 = p1.props.saves[v2.name]
			end
		end
		local v3 = if v1 then 3 else 2
		local v4 = 1 / (v3 / 6.678733031674209 + (v3 - 1) / 39.36)
		local t = {}
		local v6 = nil
		if p1.props.page == "Spawn" then
			v6 = PortalSpawn
			t.onClickSpawnVehicle = p1.props.onClickSpawnVehicle
			t.onAttemptPurchaseVehicle = p1.props.onAttemptPurchaseVehicle
			t.colsPerRow = p1.props.colsPerRow
			t.rowsPerPage = p1.props.rowsPerPage
		elseif p1.props.page == "Customize" then
			v6 = PortalCustomize
			t.attemptEquipItem = p1.props.attemptEquipItem
			t.colsPerRow = p1.props.colsPerRow
			t.rowsPerPage = p1.props.rowsPerPage
			if p1.props.category == SaleConsts.CATEGORY_NAME then
				t.colsPerRow = 6
				t.rowsPerPage = 1.5
			end
		elseif p1.props.page == "Saves" then
			v6 = PortalSaves
		end
		t.attemptFavoriteItem = p1.props.attemptFavoriteItem
		t.showAll = p1.state.showAll
		t.onToggleFavorited = p1.toggleFavorited
		t.showFavorited = p1.state.showFavorited
		t.onToggleAll = p1.toggleAll
		assert(v6 ~= nil, "missing Portal for this page")
		local v8 = if p1.props.page == "Customize" then createElement(Categories, {
	mainRatio = 0.6346339890357949,
	layoutOrder = 5,
	cornerPixel = 4,
	paddingRatio = 78.72,
	categoriesPerPage = p1.props.categoriesPerPage
}) elseif p1.props.page == "Spawn" then createElement(Lite, {
	mainRatio = 0.6346339890357949,
	layoutOrder = 5,
	cornerPixel = 4,
	paddingRatio = 39.36,
	upgraded = p1.props.premium,
	inPhysical = p1.props.inPhysical,
	getRemainingDebounce = p1.props.getRemainingDebounce,
	onRequestPremiumUpgrade = p1.props.onRequestPremiumUpgrade
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
		local t2 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = p1.props.size,
			Position = p1.props.position,
			AnchorPoint = p1.props.anchorPoint
		}
		local t3 = {
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
		local t4 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(0.13666666666666666, 0, 1, 0),
			LayoutOrder = 1
		}
		local t5 = {
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
		local t6 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 3
		}
		local t7 = {
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
		local t8 = {
			aspectRatio = 6.678733031674209
		}
		t8.color = p1.props.page == "Spawn" and Color3.fromRGB(98, 222, 253) or Color3.new(0.1, 0.1, 0.1)
		t8.layoutOrder = 1
		t8.title = "SPAWN"
		function t8.onClick() --[[ Line: 233 | Upvalues: p1 (copy) ]]
			p1.props.onSelectPage({
				pageName = "Spawn",
				sortId = p1.props.sortId,
				garageOwned = p1.props.saves
			})
		end
		t7.Spawn = createElement(RoundButton, t8)
		t7.Padding1 = createElement("Frame", {
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
		local t9 = {}
		t9.locked = not (p1.props.inPhysical or p1.props.premium) or nil
		t9.disabled = not (p1.props.inPhysical or p1.props.premium)
		t9.aspectRatio = 6.678733031674209
		t9.color = p1.props.page == "Customize" and Color3.fromRGB(98, 222, 253) or Color3.new(0.1, 0.1, 0.1)
		t9.layoutOrder = 3
		t9.title = "CUSTOMIZE"
		function t9.onClick() --[[ Line: 260 | Upvalues: p1 (copy) ]]
			if p1.props.inVehicle then
				if p1.props.inPhysical or p1.props.premium then
					p1.props.onSelectPage({
						pageName = "Customize",
						sortId = p1.props.sortId,
						categoryName = p1.props.category
					})
				else
					p1.props.notify("Head to a garage (or buy premium) to customize!")
				end
			else
				p1.props.notify("Enter a vehicle to customize it!")
			end
		end
		t7.Customize = createElement(RoundButton, t9)
		t7.Padding2 = createElement("Frame", {
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
		local t10 = {}
		t10.locked = not (p1.props.inPhysical or p1.props.premium) or nil
		t10.disabled = not (p1.props.inPhysical or p1.props.premium)
		t10.aspectRatio = 6.678733031674209
		t10.color = p1.props.page == "Saves" and Color3.fromRGB(98, 222, 253) or Color3.new(0.1, 0.1, 0.1)
		t10.layoutOrder = 5
		t10.title = "SAVES"
		function t10.onClick() --[[ Line: 296 | Upvalues: p1 (copy) ]]
			if p1.props.inVehicle then
				if p1.props.inPhysical or p1.props.premium then
					p1.props.onSelectPage({
						pageName = "Saves",
						sortId = p1.props.sortId,
						garageSaves = p1.props.saves
					})
				else
					p1.props.notify("Head to a garage (or buy premium) to use saves!")
				end
			else
				p1.props.notify("Enter a vehicle to use saves!")
			end
		end
		t7.Saves = createElement(RoundButton, t10)
		t5.ChoosePage = createElement("Frame", t6, t7)
		t5.Padding3 = createElement("Frame", {
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
		t5.Categories = v8
		t3.Left = createElement("Frame", t4, t5)
		t3.LeftPadding = createElement("Frame", {
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
		t3.Center = createElement("Frame", {
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
					cash = p1.props.cash,
					promptCashPurchase = p1.props.promptCashPurchase
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
			Portal = createElement(v6, Dictionary.merge({
				portalRatio = 2.3534863602850824,
				paddingRatio = 207.28,
				cornerPixel = 4,
				items = p1.props.items,
				owned = p1.props.owned,
				equipped = p1.props.equipped,
				saves = p1.props.saves
			}, t))
		})
		t3.RightPadding = createElement("Frame", {
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
		local t11 = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(0.13666666666666666, 0, 1, 0),
			LayoutOrder = 5
		}
		local t12 = {
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
		local t13 = {
			mainRatio = 1 / (2.4390243902439024 - (0.17597578573188333 + 1 / v4 + 0.0508130081300813)),
			cornerPixel = 4,
			paddingRatio = 39.36,
			layoutOrder = 6
		}
		t13.showTotal = p1.props.page == "Customize"
		t13.receipt = p1.props.receipt
		t13.owned = p1.props.owned
		t12.Receipt = createElement(Receipt, t13)
		t12.Padding3 = createElement("Frame", {
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
		local t14 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 255/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			LayoutOrder = 8
		}
		local t15 = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = v4
			}),
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			})
		}
		t15.Delete = v1 and createElement(RoundButton, {
			aspectRatio = 6.678733031674209,
			color = Color3.fromRGB(100, 100, 100),
			layoutOrder = 1,
			title = "Delete",
			onClick = function() --[[ Name: onClick | Line: 477 | Upvalues: p1 (copy) ]]
				p1.props.onDeleteSlot(p1.props.receipt[1].name)
			end
		})
		t15.Padding1 = v1 and createElement("Frame", {
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
		local t16 = {
			aspectRatio = 6.678733031674209,
			color = Color3.fromRGB(134, 195, 81),
			layoutOrder = 3
		}
		t16.disabled = if p1.props.page == "Spawn" then true elseif p1.props.page == "Customize" then #p1.props.receipt == 0 else false
		t16.title = if p1.props.page == "Spawn" then "SPAWN" elseif p1.props.page == "Saves" then if v1 then "LOAD" else "SAVE" else "BUY ITEMS"
		function t16.onClick() --[[ Line: 502 | Upvalues: p1 (copy), Players (ref), Audio (ref), v1 (ref) ]]
			if p1.props.page ~= "Customize" then
				if p1.props.page == "Saves" then
					local v12 = p1.props.receipt[1]
					if v1 then
						p1.props.onClickLoadSlot(v12.name, p1.props.saves[v12.name])
					else
						p1.props.onClickSaveSlot(v12.name, p1.props.equipped)
					end
				else
					if p1.props.page ~= "Spawn" then
						error("Primary button clicked on unknown page.")
					end
					return
				end
			end
			local cash = p1.props.cash
			local v2 = false
			for i, v in ipairs(p1.props.receipt) do
				local v3
				v3 = not (p1.props.owned[v.category] and p1.props.owned[v.category][v.name])
				if v.limited then
					v3 = false
				end
				if v3 then
					if cash < v.price then
						p1.props.notify("You need more cash to buy this item!")
						break
					end
					cash = cash - v.price
					p1.props.attemptBuyItem(v.category, v.name)
					v2 = true
				end
			end
			if v2 and Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 4977134975, {
					Volume = 0.3
				})
			end
		end
		t15.Buy = createElement(RoundButton, t16)
		t15.Padding2 = createElement("Frame", {
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
		t15.Leave = createElement(RoundButton, {
			aspectRatio = 6.678733031674209,
			color = Color3.fromRGB(235, 60, 0),
			layoutOrder = 5,
			title = "EXIT GARAGE",
			onClick = p1.props.onClickLeaveGarage
		})
		t12.Buttons = createElement("Frame", t14, t15)
		t3.Right = createElement("Frame", t11, t12)
		return createElement("Frame", t2, t3)
	end
end
function v1.didMount(p1) --[[ Line: 567 ]] end
function v1.willUnmount(p1) --[[ Line: 568 ]] end
function v1.didUpdate(p1, p2, p3) --[[ Line: 569 ]]
	if p1.props.disabled ~= p2.disabled and p1.props.disabled then
		p1:setState({
			showAll = false,
			showFavorited = false
		})
	end
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 592 ]]
	return {
		cash = p1.cash,
		items = p1.garageItems,
		owned = p1.garageOwned,
		equipped = p1.garageEquipped,
		page = p1.garagePage,
		categories = p1.garageCategories,
		category = p1.garageCategory,
		sortId = p1.garageSort,
		receipt = p1.garageReceipt,
		saves = p1.garageSaves,
		premium = p1.garagePremium,
		inPhysical = p1.garageInPhysical,
		inVehicle = p1.garageInVehicle
	}
end, function(p1) --[[ Line: 608 | Upvalues: Players (copy), Audio (copy) ]]
	return {
		onSelectPage = function(p12) --[[ Name: onSelectPage | Line: 610 | Upvalues: Players (ref), Audio (ref), p1 (copy) ]]
			assert(p12.pageName ~= nil, "pageName is required")
			if Players.LocalPlayer then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.25
				})
			end
			p1({
				type = "setPage",
				pageName = p12.pageName,
				sortId = p12.sortId,
				categoryName = p12.categoryName,
				garageSaves = p12.saves,
				garageOwned = p12.garageOwned
			})
		end,
		onClickSaveSlot = function(p12, p2) --[[ Name: onClickSaveSlot | Line: 628 | Upvalues: p1 (copy) ]]
			p1({
				type = "setSaveSlot",
				name = p12,
				equipped = p2
			})
		end,
		onClickLoadSlot = function(p12, p2) --[[ Name: onClickLoadSlot | Line: 636 | Upvalues: p1 (copy) ]]
			p1({
				type = "loadSaveSlot",
				name = p12
			})
		end
	}
end)(v1)