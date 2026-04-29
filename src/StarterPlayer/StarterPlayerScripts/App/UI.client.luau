local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Maid = require(ReplicatedStorage.Std.Maid)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local Notification = require(ReplicatedStorage.Game.Notification)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
local Players = game:GetService("Players")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local Runtime = require(ReplicatedStorage.ActionButton.UI.Runtime)
local AdminPermUtils = require(ReplicatedStorage.App.AdminPermUtils)
require(ReplicatedStorage.App.UI.TopbarHolder)
local SidebarHolder = require(ReplicatedStorage.App.UI.SidebarHolder)
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local BigMinimap = require(ReplicatedStorage.App.UI.BigMinimap)
local MinimapRodux = require(ReplicatedStorage.App.UI.MinimapRodux)
local MinimapConsts = require(ReplicatedStorage.App.MinimapConsts)
local MinimapService = require(ReplicatedStorage.App.MinimapService)
require(ReplicatedStorage.App.RunConsts)
local Bounty = require(ReplicatedStorage.App.UI.Bounty)
local CenterMessage = require(ReplicatedStorage.App.UI.CenterMessage)
local TrackService = require(ReplicatedStorage.RaceTrack.TrackService)
local SidebarUI = require(ReplicatedStorage.Game.SidebarUI)
local Speedometer = require(ReplicatedStorage.Speedometer.UI.Speedometer)
local SpeedometerUtils = require(ReplicatedStorage.Speedometer.SpeedometerUtils)
local LicensePlate = require(ReplicatedStorage.Speedometer.UI.LicensePlate)
local HotbarSystem = require(ReplicatedStorage.Hotbar.HotbarSystem)
local Viewer = require(ReplicatedStorage.CCTV.UI.Viewer)
local CCTVService = require(ReplicatedStorage.CCTV.CCTVService)
local CmdrExtSystem = require(ReplicatedStorage.CmdrExt.CmdrExtSystem)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local TabContainer = require(ReplicatedStorage.EzUi.TabContainer)
local store = require(ReplicatedStorage.App.store)
local Garage = require(ReplicatedStorage.Garage.UI.Garage)
local GarageUtils = require(ReplicatedStorage.Garage.GarageUtils)
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local CasinoKeypad = require(ReplicatedStorage.Casino.UI.CasinoKeypad)
local ChatUtils = require(ReplicatedStorage.Chat.ChatUtils)
local DamageIndicators = require(ReplicatedStorage.DamageIndicator.UI.DamageIndicators)
local LikePromptRodux = require(ReplicatedStorage.LikePrompt.UI.LikePromptRodux)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local Trade = require(ReplicatedStorage.Trade.UI.Trade)
local TradeInitiations = require(ReplicatedStorage.Trade.UI.TradeInitiations)
local TradeResult = require(ReplicatedStorage.Trade.UI.TradeResult)
local RewardSpinner = require(ReplicatedStorage.RewardSpinner.UI.RewardSpinner)
local Safes = require(ReplicatedStorage.Safes.UI.Safes)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local SpawnSelection = require(ReplicatedStorage.SpawnSelection.UI.SpawnSelection)
local SpawnSelectionService = require(ReplicatedStorage.SpawnSelection.SpawnSelectionService)
local ChooseSpawn = require(ReplicatedStorage.SpawnSelection.UI.ChooseSpawn)
local SpawnSelectionConsts = require(ReplicatedStorage.SpawnSelection.SpawnSelectionConsts)
local String = require(ReplicatedStorage.Std.String)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local GarageConsts_2 = require(ReplicatedStorage.Game.Garage.GarageConsts)
require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local TooltipRodux = require(ReplicatedStorage.Tooltip.UI.TooltipRodux)
local OtherTradeServerListRodux = require(ReplicatedStorage.Trade.UI.OtherTradeServerListRodux)
local currentWorld = RunUtils.getWorld()
local AppComponent = Roact.Component:extend("App")
local defaultProps = {}
defaultProps.mapImageId = assert(MinimapConsts.MAP_IMAGE_ID[currentWorld], "missing mapImageId")
defaultProps.mapWorldWidth = assert(MinimapConsts.MAP_WORLD_WIDTH[currentWorld], "missing mapWorldWidth")
defaultProps.mapWorldHeight = assert(MinimapConsts.MAP_WORLD_HEIGHT[currentWorld], "missing mapWorldHeight")
defaultProps.mapWorldCenterX = assert(MinimapConsts.MAP_WORLD_CENTER_X[currentWorld], "missing mapWorldCenterX")
defaultProps.mapWorldCenterY = assert(MinimapConsts.MAP_WORLD_CENTER_Y[currentWorld], "missing mapWorldCenterY")
defaultProps.mapImageWidth = 512
defaultProps.mapImageHeight = 512
AppComponent.defaultProps = defaultProps
function AppComponent.init(self)
	self._maid = Maid.new()
	self:setState({
		controlsEnabled = true,
		teamColor = Settings.TeamColor[GameUtil.Team],
		isSmallScreen = Utils.isSmallScreen(),
		minimapOpen = true,
		megamapOpen = false,
		bounty = 0,
		speedometerEnabled = false,
		vehicleLocked = false,
		hasLicensePlate = false,
		licensePlateText = "JAILBRK",
		missilesEnabled = false,
		devPanelVisible = false,
		garageVisible = false
	})
	self._maid:GiveTask(Utils.getViewportSizeChangedSignal():Connect(function()
		self:setState({
			isSmallScreen = Utils.isSmallScreen()
		})
	end))
	self._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer, "ChoosingTeam", function(choosingTeamValue, taskMaid)
		local function handler(newValue)
			self:setState({
				controlsEnabled = not newValue
			})
		end
		taskMaid:GiveTask(choosingTeamValue.Changed:Connect(handler))
		self:setState({
			controlsEnabled = not choosingTeamValue.Value
		})
	end))
	self._maid:GiveTask(GameUtil.OnTeamChanged:Connect(function(newTeam)
		self:setState({
			teamColor = Settings.TeamColor[newTeam]
		})
	end))
	local function updateBounty()
		self:setState({
			bounty = GameUtil.bounty
		})
	end
	self:setState({
		bounty = GameUtil.bounty
	})
	self._maid:GiveTask(GameUtil.onBountyChanged:Connect(updateBounty))
	local spdDistance, updateSpdDistance = Roact.createBinding(123456)
	self._spdDistance = spdDistance
	self._updateSpdDistance = updateSpdDistance
	local spdSpeed, updateSpdSpeed = Roact.createBinding(878)
	self._spdSpeed = spdSpeed
	self._updateSpdSpeed = updateSpdSpeed
	local spdAccelRatio, updateSpdAccelRatio = Roact.createBinding(0)
	self._spdAccelRatio = spdAccelRatio
	self._updateSpdAccelRatio = updateSpdAccelRatio
	local hotbarWithSpeedometerSetting = {
		name = "hotbarWithSpeedometer",
		title = "Hotbar With Speedometer",
		type = gameSettingType.Checkbox,
		defaultValue = false,
		order = 51
	}
	GameSettingsService.add(hotbarWithSpeedometerSetting)
	local function handleSetting(enabled)
		if VehicleUtils.GetLocalVehiclePacket and VehicleUtils.GetLocalVehiclePacket() then
			if enabled then
				HotbarSystem.show()
				return
			end
			HotbarSystem.hide()
		end
	end
	local hotbarWithSpeedometerEnabled = hotbarWithSpeedometerSetting:getValue()
	if VehicleUtils.GetLocalVehiclePacket and VehicleUtils.GetLocalVehiclePacket() then
		if hotbarWithSpeedometerEnabled then
			HotbarSystem.show()
		else
			HotbarSystem.hide()
		end
	end
	hotbarWithSpeedometerSetting.onChanged:Connect(handleSetting)
	if AdminPermUtils.hasPerms(Players.LocalPlayer) then
		self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and (input.KeyCode == Enum.KeyCode.G and (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and self.state.inVehicle)) then
				self:setState({
					speedometerEnabled = not self.state.speedometerEnabled
				})
			end
		end))
	end
	self._maid:GiveTask(VehicleUtils.OnVehicleEntered:Connect(function(vehiclePacket, isPassenger)
		if not isPassenger then
			if self.state.garageVisible then
				vehiclePacket.LockMovement = true
			end
			store:dispatch({
				type = "setInVehicle",
				inVehicle = true
			})
			store:dispatch({
				type = "setLocalVehiclePacket",
				packet = vehiclePacket
			})
			self:setState({
				inVehicle = true
			})
			vehiclePacket.seatMaid:GiveTask(function()
				store:dispatch({
					type = "setInVehicle",
					inVehicle = false
				})
				self:setState({
					inVehicle = false,
					garageVisible = false
				})
			end)
			local BoundingBox = vehiclePacket.Model:FindFirstChild("BoundingBox")
			if BoundingBox then
				if not hotbarWithSpeedometerSetting:getValue() then
					HotbarSystem.hide()
				end
				vehiclePacket.seatMaid:GiveTask(function()
					if not hotbarWithSpeedometerSetting:getValue() then
						HotbarSystem.show()
					end
				end)
				local vehicleState = {
					speedometerEnabled = true,
					hasLicensePlate = false
				}
				vehicleState.missilesEnabled = (vehiclePacket.Bombs or vehiclePacket.Rockets) and true or false
				vehicleState.speedometerSmallUI = vehiclePacket.Make == "Bionic"
				self:setState(vehicleState)
				vehiclePacket.seatMaid:GiveTask(function()
					self:setState({
						speedometerEnabled = false,
						licensePromptEnabled = false
					})
				end)
				self._updateSpdDistance(0)
				VehicleUtils.updateSpdBarRatio(0)
				VehicleUtils._forceUpdateNitroBar = true
				vehiclePacket.seatMaid:GiveTask(RunService.Heartbeat:Connect(function()
					local rawSpeed = math.abs((BoundingBox.Velocity:Dot(BoundingBox.CFrame.LookVector)))
					local mph = SpeedometerUtils.sToH(SpeedometerUtils.studsToMi(rawSpeed))
					VehicleUtils.LastMPHClient = mph
					self._updateSpdSpeed(mph)
					if vehiclePacket.rpmVisual and vehiclePacket.rpmVisualMax then
						self._updateSpdAccelRatio(vehiclePacket.rpmVisual / vehiclePacket.rpmVisualMax)
					else
						self._updateSpdAccelRatio(rawSpeed / 100)
					end
				end))
				local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
				if PlayerGui then
					local MapMakeOdometer = PlayerGui:FindFirstChild("MapMakeOdometer")
					vehiclePacket.seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(MapMakeOdometer, vehiclePacket.Make, function(odometerValue, taskMaid)
						self._updateSpdDistance(SpeedometerUtils.studsToMi(odometerValue.Value))
						taskMaid:GiveTask(odometerValue.Changed:Connect(function(newValue)
							self._updateSpdDistance(SpeedometerUtils.studsToMi(newValue))
						end))
					end))
				end
				local function updateLocked()
					local lockedState = {}
					lockedState.vehicleLocked = vehiclePacket.Model:GetAttribute("Locked") == true
					lockedState.speedometerLockEnabled = VehicleUtils.canLocalLock()
					self:setState(lockedState)
				end
				local initialLockedState = {}
				initialLockedState.vehicleLocked = vehiclePacket.Model:GetAttribute("Locked") == true
				initialLockedState.speedometerLockEnabled = VehicleUtils.canLocalLock()
				self:setState(initialLockedState)
				vehiclePacket.seatMaid:GiveTask(vehiclePacket.Model:GetAttributeChangedSignal("Locked"):Connect(updateLocked))
				local function updatePassengers()
					local otherPassengers = TableUtils.map(TableUtils.filter(VehicleUtils.getSeats(vehiclePacket.Model), function(seat)
						return seat.Player ~= Players.LocalPlayer
					end), function(seat)
						return seat.Player
					end)
					local passengerState = {
						passengers = otherPassengers
					}
					passengerState.speedometerEjectEnabled = if #otherPassengers > 0 then VehicleUtils.canLocalEject() else false
					self:setState(passengerState)
				end
				updatePassengers()
				for seatIndex, seatChild in ipairs(vehiclePacket.Model:GetChildren()) do
					if seatChild.Name == "Seat" or seatChild.Name == "Passenger" then
						local PlayerName = seatChild:FindFirstChild("PlayerName")
						vehiclePacket.seatMaid:GiveTask(PlayerName.Changed:Connect(updatePassengers))
					end
				end
				local Model = vehiclePacket.Model:FindFirstChild("Model")
				if Model then
					local plate = Model:FindFirstChild("plate")
					if plate then
						local SurfaceGui = plate:FindFirstChild("SurfaceGui")
						if SurfaceGui then
							local TextLabel = SurfaceGui.Frame.TextLabel
							self:setState({
								hasLicensePlate = true,
								licensePlateText = TextLabel.Text
							})
							vehiclePacket.seatMaid:GiveTask(TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
								self:setState({
									licensePlateText = TextLabel.Text
								})
							end))
						end
					end
				end
				local function updateMissiles()
					self:setState({
						missileCount = Players.LocalPlayer:GetAttribute("MissileCount") or 0,
						missileMax = vehiclePacket.Model:GetAttribute("MissileMax") or 0
					})
				end
				updateMissiles()
				vehiclePacket.seatMaid:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal("MissileCount"):Connect(updateMissiles))
				vehiclePacket.seatMaid:GiveTask(vehiclePacket.Model:GetAttributeChangedSignal("MissileMax"):Connect(updateMissiles))
			end
		end
	end))
	self._maid:GiveTask(CCTVService.onRequestPrompt:Connect(function(enabled, permanent)
		if enabled == nil then
			enabled = true
		end
		local cctvState = {
			cctvViewerEnabled = enabled
		}
		cctvState.cctvViewerExpireDistance = if permanent then 9999 else 20
		self:setState(cctvState)
	end))
	self.consoleRef = Roact.createRef()
	self.settingsRef = Roact.createRef()
	self._maid:GiveTask(SidebarUI.onDevPanelToggle:Connect(function()
		self:setState({
			devPanelVisible = not self.state.devPanelVisible,
			devPanelCurrentPage = self.settingsRef:getValue()
		})
	end))
	local function setGarageUIOpen(open)
		local canCustomize = GarageUtils.inVehicle() and (GarageUtils.hasPremium() or GarageUtils.inPhysicalGarage())
		if open then
			if canCustomize then
				local loadLastSelectionRemote = ReplicatedStorage:FindFirstChild(GarageConsts.LOAD_LAST_SELECTION_REMOTE_NAME)
				if loadLastSelectionRemote then
					loadLastSelectionRemote:FireServer()
				end
			end
			local currentState = store:getState()
			local pageAction = {
				type = "setPage"
			}
			pageAction.pageName = if canCustomize then "Customize" else "Spawn"
			pageAction.categoryName = SaleConsts.CATEGORY_NAME
			pageAction.sortId = currentState.garageSort
			pageAction.garageOwned = currentState.garageOwned
			store:dispatch(pageAction)
		end
		self:setState({
			garageVisible = open
		})
	end
	local informUIOpenRemote = ReplicatedStorage:FindFirstChild(GarageConsts.INFORM_UI_IS_OPEN_REMOTE_NAME)
	informUIOpenRemote.OnClientEvent:Connect(setGarageUIOpen)
	self._maid:GiveTask(SidebarUI.onGarageToggle:Connect(function()
		if self.state.garageVisible then
			informUIOpenRemote:FireServer(not self.state.garageVisible)
			setGarageUIOpen(not self.state.garageVisible)
			return
		end
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		if vehiclePacket and vehiclePacket.Passenger then
			Notification.new({
				Title = "Garage",
				Text = "Cannot customize as passenger."
			})
		elseif vehiclePacket and vehiclePacket.Model:GetAttribute("DisableGarage") then
			Notification.new({
				Text = "Garage disabled on this vehicle."
			})
		else
			informUIOpenRemote:FireServer(not self.state.garageVisible)
			setGarageUIOpen(not self.state.garageVisible)
		end
	end))
	function self.onClickLeaveGarage()
		informUIOpenRemote:FireServer(false)
		self:setState({
			garageVisible = false
		})
	end
	function self.onClickSpawnVehicle(params)
		local spawnVehicleRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SPAWN_VEHICLE_REMOTE_NAME)
		if spawnVehicleRemote then
			spawnVehicleRemote:FireServer(params.vehicleType, params.vehicleMake)
		end
		self.onClickLeaveGarage()
	end
	function self.onAttemptPurchaseVehicle(vehicleInfo, categoryInfo)
		if vehicleInfo.limited then
		elseif categoryInfo.locked then
			local confirmation = Confirmation.new("You need the Pro Garage gamepass to buy this here. Otherwise, find it in the world and buy it there. Want to buy Pro Garage?")
			self:setState({
				garageVisible = false
			})
			confirmation.Maid:GiveTask(function()
				self:setState({
					garageVisible = true
				})
			end)
			confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
				self.onRequestPremiumUpgrade()
			end))
		else
			local vehicleMake = vehicleInfo.vehicleMake
			local vehicleTitle = ItemUtils.getTranslatedTitleFromItemTable((ItemUtils.createVehicleItemTable(vehicleMake)))
			local confirmation = Confirmation.new("Purchase the " .. vehicleTitle .. " for $" .. String.comma(vehicleInfo.price) .. "?")
			self:setState({
				garageVisible = false
			})
			confirmation.Maid:GiveTask(function()
				self:setState({
					garageVisible = true
				})
			end)
			confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
				ReplicatedStorage:FindFirstChild(GarageConsts.PURCHASE_VEHICLE_REMOTE_NAME):FireServer(vehicleMake)
			end))
		end
	end
	function self.getRemainingDebounce()
		local currentState = store:getState()
		local timeSinceLastSpawn = workspace:GetServerTimeNow() - PlayerUtils.getLastVehicleSpawnedAt()
		return if currentState.garageInPhysical or Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) then GarageConsts_2.SPAWN_DEBOUNCE_PHYSICAL elseif currentState.garagePremium then GarageConsts_2.SPAWN_DEBOUNCE_PREMIUM else GarageConsts_2.SPAWN_DEBOUNCE_NON_PREMIUM - timeSinceLastSpawn
	end
	function self.onDeleteSlot(slotName)
		local confirmation = Confirmation.new("Are you sure you want to delete this save slot?")
		self:setState({
			garageVisible = false
		})
		confirmation.Maid:GiveTask(function()
			self:setState({
				garageVisible = true
			})
		end)
		confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
			store:dispatch({
				type = "deleteSaveSlot",
				name = slotName
			})
		end))
	end
	function self.attemptEquipGarageItem(itemType, itemName)
		local remote = ReplicatedStorage:FindFirstChild(GarageConsts.EQUIP_ITEM_REMOTE_NAME)
		if remote then
			remote:FireServer(itemType, itemName)
		end
	end
	function self.attemptFavoriteGarageItem(itemType, itemName, favorited)
		local remote = ReplicatedStorage:FindFirstChild(GarageConsts.UPDATE_FAVORITED_REMOTE_NAME)
		if remote then
			remote:FireServer(itemType, itemName, favorited)
		end
	end
	function self.attemptBuyGarageItem(itemType, itemName)
		local remote = ReplicatedStorage:FindFirstChild(GarageConsts.PURCHASE_ITEM_REMOTE_NAME)
		if remote then
			remote:FireServer(itemType, itemName)
		end
	end
	function self.notify(text)
		Notification.new({
			Text = text
		})
	end
	function self.onRequestPremiumUpgrade()
		GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.PremiumGarage)
	end
	function self.garagePromptCashPurchase()
		self.onClickLeaveGarage()
		CashBuyUI.Open()
	end
	self.minimapBaseProps = {
		mapImageColor3 = MinimapService.mapImageColor3,
		mapImageId = self.props.mapImageId,
		mapWorldWidth = self.props.mapWorldWidth,
		mapWorldHeight = self.props.mapWorldHeight,
		mapWorldCenterX = self.props.mapWorldCenterX,
		mapWorldCenterY = self.props.mapWorldCenterY,
		mapImageWidth = self.props.mapImageWidth,
		mapImageHeight = self.props.mapImageHeight,
		worldPosition = MinimapService.mapWorldPosition,
		worldDirection = MinimapService.mapWorldDirection
	}
	function self.minimapOnToggle()
		self:setState({
			minimapOpen = not self.state.minimapOpen
		})
	end
	function self.megamapOnToggle()
		self:setState({
			megamapOpen = not self.state.megamapOpen
		})
	end
	if RunUtils.isMainWorld() then
		store:dispatch({
			type = "addMinimapLabels",
			labels = {
				{
					title = "TOWN",
					position = Vector3.new(621.013, 27.525, -1267.409)
				},
				{
					title = "PRISON",
					position = Vector3.new(-1315.371, 14.684, -1675.214)
				},
				{
					title = "RISING CITY",
					position = Vector3.new(26.525, 14.92, 1059.65)
				},
				{
					title = "CRIME PORT",
					position = Vector3.new(-450.301, 66.298, 2057.057)
				},
				{
					title = "VOLCANO",
					position = Vector3.new(2163.957, 61.551, -2597.875)
				},
				{
					title = "CRATER CITY",
					position = Vector3.new(-403.716, 40.235, -5835.282)
				},
				{
					title = "TRADE PORT",
					position = Vector3.new(2428.203, 20.751, -3775.428)
				}
			}
		})
	end
	self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.M then
				self.megamapOnToggle()
			end
		elseif not gameProcessed and (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.DPadRight) then
			self.megamapOnToggle()
		end
	end))
	function self.onSpawnSelectionSpawnPressed(spawnInfo)
		SpawnSelectionService.attemptSelect(spawnInfo.name)
		GameUtil.removeDeathLighting()
	end
	function self.onSpawnSelectionShowSpawns()
		SpawnSelectionService.requestShowSpawns()
		GameUtil.removeDeathGui()
	end
	local showTooltipsSetting = {
		name = "showTooltips",
		title = "Show Tooltips",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 52
	}
	GameSettingsService.add(showTooltipsSetting)
	local function handleTooltips(value)
		store:dispatch({
			type = "setTooltipVisible",
			value = value
		})
	end
	store:dispatch({
		type = "setTooltipVisible",
		value = showTooltipsSetting:getValue()
	})
	showTooltipsSetting.onChanged:Connect(handleTooltips)
end
function AppComponent.render(self)
	local children = {
		Controls = createElement(Runtime, {
			enabled = self.state.controlsEnabled,
			color = self.state.teamColor
		})
	}
	if self.state.isSmallScreen then
		local frameProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.1, 0, 1, 0),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0)
		}
		local innerChildren = {
			Padding = createElement("UIPadding", {
				PaddingTop = UDim.new(0, 61)
			}),
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8)
			})
		}
		local bountyProps = {
			amount = self.state.bounty
		}
		bountyProps.enabled = self.state.bounty > 0
		bountyProps.displayOrder = 2
		innerChildren.Bounty = createElement(Bounty, bountyProps)
		local minimapProps = {
			square = true,
			mapScale = 6,
			size = UDim2.new(0.9, 0, 0.9, 0),
			anchorPoint = Vector2.new(0.5, 0.5),
			isSmallScreen = self.state.isSmallScreen,
			color = self.state.teamColor
		}
		minimapProps.open = self.state.minimapOpen and self.state.controlsEnabled
		minimapProps.showToggleButton = self.state.controlsEnabled
		minimapProps.time = SidebarUI.time
		minimapProps.displayOrder = 3
		minimapProps.onToggle = self.minimapOnToggle
		minimapProps.onClick = self.megamapOnToggle
		innerChildren.Minimap = createElement(MinimapRodux, Dictionary.merge(self.minimapBaseProps, minimapProps))
		children.TopRight = createElement("Frame", frameProps, innerChildren)
	else
		local isGamepad = InputUtils.isGamepad()
		local frameProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.4, 0)
		}
		frameProps.Position = UDim2.new(0, 0, if isGamepad then 0.74 else 0.6, 0)
		frameProps.AnchorPoint = Vector2.new(0, 0.5)
		local innerChildren = {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8)
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.4,
				DominantAxis = Enum.DominantAxis.Height
			}),
			Sidebar = createElement(SidebarHolder, {
				color = self.state.teamColor,
				buttons = BigButtonService.active,
				size = UDim2.new(1, 0, 1, 0),
				anchorPoint = Vector2.new(0, 1),
				position = UDim2.new(0, 0, 0, 0),
				displayOrder = 1
			})
		}
		local bountyProps = {
			amount = self.state.bounty
		}
		bountyProps.enabled = self.state.bounty > 0
		bountyProps.displayOrder = 2
		innerChildren.Bounty = createElement(Bounty, bountyProps)
		local minimapProps = {
			square = true,
			mapScale = 6,
			size = UDim2.new(0.9, 0, 0.9, 0),
			anchorPoint = Vector2.new(0.5, 0.5),
			isSmallScreen = self.state.isSmallScreen,
			color = self.state.teamColor
		}
		minimapProps.open = self.state.minimapOpen and self.state.controlsEnabled
		minimapProps.showToggleButton = self.state.controlsEnabled
		minimapProps.time = SidebarUI.time
		minimapProps.displayOrder = 3
		minimapProps.onToggle = self.minimapOnToggle
		minimapProps.onClick = self.megamapOnToggle
		innerChildren.Minimap = createElement(MinimapRodux, Dictionary.merge(self.minimapBaseProps, minimapProps))
		children.Buttons = createElement("Frame", frameProps, innerChildren)
	end
	children.Minimap = createElement(BigMinimap, Dictionary.merge(self.minimapBaseProps, {
		visible = self.state.megamapOpen,
		open = true,
		size = UDim2.new(0.7, 0, 0.7, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5),
		labels = self.state.minimapLabels,
		color = self.state.teamColor,
		displayOrder = 1,
		onToggle = self.megamapOnToggle,
		isSmallScreen = self.state.isSmallScreen,
		square = true
	}))
	children.TrackCountdown = createElement(CenterMessage, {
		text = TrackService.screenText
	})
	children.LikePrompt = createElement(LikePromptRodux, {
		size = UDim2.fromScale(0.35, 0.5),
		anchorPoint = Vector2.new(0.5, 1),
		position = UDim2.fromScale(0.5, 0.8)
	})
	local tooltipProps = {}
	tooltipProps.size = UDim2.fromScale(0.6, if self.state.isSmallScreen then 0.025 else 0.015)
	tooltipProps.anchorPoint = Vector2.new(0.5, 1)
	tooltipProps.position = if Utils.isSmallScreen() then UDim2.fromScale(0.5, 0.95) else UDim2.fromScale(0.5, 1)
	tooltipProps.visible = not self.state.inVehicle
	children.Tooltip = createElement(TooltipRodux, tooltipProps)
	if self.state.speedometerEnabled then
		local spdProps = {
			enabled = true,
			color = self.state.teamColor,
			distance = self._spdDistance,
			speed = self._spdSpeed,
			barRatio = VehicleUtils.spdBarRatio,
			accelRatio = self._spdAccelRatio,
			size = UDim2.new(0.25, 0, 0.5, 0)
		}
		spdProps.position = UDim2.new(0.5, 0, if self.state.speedometerSmallUI then 0.93 else 0.95, 0)
		spdProps.anchorPoint = Vector2.new(0.5, 1)
		spdProps.locked = self.state.vehicleLocked
		spdProps.lockEnabled = self.state.speedometerLockEnabled
		spdProps.hasLicensePlate = self.state.hasLicensePlate
		spdProps.licensePlate = self.state.licensePlateText
		spdProps.ejectEnabled = self.state.speedometerEjectEnabled
		spdProps.missilesEnabled = self.state.missilesEnabled
		spdProps.missileCount = self.state.missileCount
		spdProps.missileMax = self.state.missileMax
		spdProps.passengers = self.state.passengers
		spdProps.smallUI = self.state.speedometerSmallUI
		function spdProps.onClickBar()
			VehicleUtils.NitroShopVisible(true, true)
		end
		function spdProps.onClickLock()
			VehicleUtils.toggleLocalLocked()
		end
		function spdProps.onClickEjectName(playerName)
			VehicleUtils.attemptPassengerEject(playerName)
		end
		function spdProps.onClickPlate()
			self:setState({
				licensePromptEnabled = true
			})
		end
		spdProps.onClickMissileBuy = VehicleUtils.promptMissileBuy
		children.Speedometer = createElement(Speedometer, spdProps)
	end
	if self.state.licensePromptEnabled then
		children.LicensePlate = createElement(LicensePlate, {
			text = self.state.licensePlateText,
			size = UDim2.new(0.2, 0, 0.5, 0),
			position = UDim2.new(0.5, 0, 0.5, 0),
			onClickClose = function()
				self:setState({
					licensePromptEnabled = false
				})
			end,
			onClickApply = function(newText)
				self:setState({
					licensePromptEnabled = false
				})
				if #newText ~= 0 then
					self.attemptBuyGarageItem("LicensePlate", newText)
				end
			end
		})
	end
	if self.state.cctvViewerEnabled then
		children.CCTVViewer = createElement(Viewer, {
			size = UDim2.new(0.5, 0, 0.5, 0),
			position = UDim2.new(0.5, 0, 0.5, 0),
			distance = 96,
			aspectRatio = 16/9,
			expireDistance = self.state.cctvViewerExpireDistance,
			cameraTag = "CCTVCamera",
			fieldOfView = 70,
			onClickClose = function()
				self:setState({
					cctvViewerEnabled = false
				})
			end
		})
	end
	children.DevPanel = createElement(TabContainer, {
		color = self.state.teamColor,
		visible = self.state.devPanelVisible,
		isSmallScreen = self.state.isSmallScreen,
		anchorPoint = Vector2.new(0.5, 0.5),
		position = UDim2.new(0.5, 0, 0.5, 0),
		size = UDim2.new(0.5, 0, 0.5, 0),
		pages = {
			{
				title = "CONSOLE",
				tabColor = Color3.new(0/255, 0/255, 0/255),
				layoutOrder = 1,
				backgroundColor = Color3.fromRGB(17, 17, 17),
				backgroundTransparency = 0.4,
				[Roact.Ref] = self.consoleRef
			},
			{
				title = "SETTINGS",
				tabColor = Color3.new(0/255, 255/255, 0/255),
				layoutOrder = 2,
				backgroundColor = Color3.fromRGB(17, 17, 17),
				backgroundTransparency = 0.4,
				[Roact.Ref] = self.settingsRef,
				[Roact.Children] = createElement(require(ReplicatedStorage.GameSettings.UI.GameSettings), {
					size = UDim2.new(1, 0, 1, 0),
					color = self.state.teamColor
				})
			}
		},
		currentPage = self.state.devPanelCurrentPage,
		updatePage = function(newPage)
			self:setState({
				devPanelCurrentPage = newPage
			})
		end
	})
	local garageProps = {}
	garageProps.size = if self.state.isSmallScreen then UDim2.new(0.65, 0, 0.6, 0) else UDim2.new(0.65, 0, 0.7, 0) or UDim2.new(0.65, 0, 0.6, 0)
	garageProps.anchorPoint = Vector2.new(0.5, 0.5)
	garageProps.position = if self.state.isSmallScreen then UDim2.new(0.5, 0, 0.35, 0) else UDim2.new(0.5, 0, 0.25, 0) or UDim2.new(0.5, 0, 0.35, 0)
	garageProps.disabled = not self.state.garageVisible
	garageProps.onClickLeaveGarage = self.onClickLeaveGarage
	garageProps.onClickSpawnVehicle = self.onClickSpawnVehicle
	garageProps.onAttemptPurchaseVehicle = self.onAttemptPurchaseVehicle
	garageProps.getRemainingDebounce = self.getRemainingDebounce
	garageProps.attemptEquipItem = self.attemptEquipGarageItem
	garageProps.attemptBuyItem = self.attemptBuyGarageItem
	garageProps.attemptFavoriteItem = self.attemptFavoriteGarageItem
	garageProps.notify = self.notify
	garageProps.onRequestPremiumUpgrade = self.onRequestPremiumUpgrade
	garageProps.promptCashPurchase = self.garagePromptCashPurchase
	garageProps.colsPerRow = if self.state.isSmallScreen then 6 else 7
	garageProps.rowsPerPage = if self.state.isSmallScreen then 2 else 2.5
	garageProps.categoriesPerPage = if self.state.isSmallScreen then 7 else 10
	garageProps.onDeleteSlot = self.onDeleteSlot
	children.Garage = createElement(Garage, garageProps)
	children.CasinoKeypad = createElement(CasinoKeypad)
	children.DamageIndicators = createElement(DamageIndicators, {
		size = UDim2.new(0.5, 0, 0.5, 0)
	})
	local tradeProps = {}
	tradeProps.size = self.state.isSmallScreen and UDim2.new(0.75, 0, 0.75, 0) or UDim2.new(0.6, 0, 0.6, 0)
	tradeProps.position = self.state.isSmallScreen and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.55, 0)
	children.Trade = createElement(Trade, tradeProps)
	local tradeInitiationsProps = {
		size = UDim2.new(1/3, 0, 1/3, 0)
	}
	tradeInitiationsProps.position = if self.state.isSmallScreen then UDim2.new(0.5, 0, 2/3, 0) else UDim2.new(1, 0, 0.7, 0)
	tradeInitiationsProps.anchorPoint = if self.state.isSmallScreen then Vector2.new(0.5, 0.5) else Vector2.new(1, 0.5)
	children.TradeInitiations = createElement(TradeInitiations, tradeInitiationsProps)
	children.TradeResult = createElement(TradeResult, {
		size = UDim2.new(0.25, 0, 0.25, 0),
		position = UDim2.new(0.5, 0, 1/3, 0),
		anchorPoint = Vector2.new(0.5, 0.5)
	})
	children.RewardSpinner = createElement(RewardSpinner, {
		size = UDim2.new(1/3, 0, 0.25, 0),
		position = UDim2.new(0.5, 0, 0.03125, 0),
		anchorPoint = Vector2.new(0.5, 0)
	})
	children.Safes = createElement(Safes, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5)
	})
	children.SpawnSelection = createElement(SpawnSelection, Dictionary.merge(self.minimapBaseProps, {
		visible = true,
		open = true,
		size = UDim2.new(0.7, 0, 0.7, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5),
		color = self.state.teamColor,
		displayOrder = 1,
		isSmallScreen = self.state.isSmallScreen,
		square = true,
		duration = SpawnSelectionConsts.MAX_WAIT_TIME,
		onSpawnPressed = self.onSpawnSelectionSpawnPressed
	}))
	children.ChooseSpawn = createElement(ChooseSpawn, {
		duration = Settings.Time.Respawn,
		size = UDim2.new(0.5, 0, 0.08, 0),
		position = UDim2.new(0.5, 0, 0.7, 0),
		onSelect = self.onSpawnSelectionShowSpawns
	})
	children.OtherTradeServerListRodux = createElement(OtherTradeServerListRodux, {
		verticalPaddingRatio = 128,
		aspectRatio = 2,
		size = UDim2.fromScale(0.8, 0.7),
		position = UDim2.fromScale(0.5, 0.5),
		anchorPoint = Vector2.new(0.5, 0.5)
	})
	return Roact.createElement(RoactRodux.StoreProvider, {
		store = store
	}, { Roact.createFragment(children) })
end
function AppComponent.didMount(self)
	self._maid:GivePromise(CmdrExtSystem.promiseCmdr():andThen(function(cmdr, cmdrFrame)
		self.cmdr = cmdr
		self.cmdrFrame = cmdrFrame
		cmdrFrame.Parent = self.consoleRef.current
		cmdr:SetEnabled(true)
		self._maid:GiveTask(function()
			cmdr:SetEnabled(false)
		end)
		self._maid:GiveTask(function()
			cmdrFrame.Parent = Players.LocalPlayer
		end)
		if self.state.devPanelVisible and self.state.devPanelCurrentPage == self.consoleRef:getValue() then
			cmdr:Show()
		else
			cmdr:Hide()
		end
		self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Backquote and (not gameProcessed or self.state.devPanelVisible) then
				self:setState({
					devPanelVisible = not self.state.devPanelVisible,
					devPanelCurrentPage = self.consoleRef:getValue()
				})
			end
		end))
		self._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(ReplicatedStorage, "OpenCmdrMenu", function(remote)
			remote.OnClientEvent:Connect(function()
				self:setState({
					devPanelVisible = true,
					devPanelCurrentPage = self.consoleRef:getValue()
				})
			end)
		end))
	end))
end
function AppComponent.didUpdate(self, prevProps, prevState)
	if self.state.devPanelVisible ~= prevState.devPanelVisible or self.state.devPanelCurrentPage ~= prevState.devPanelCurrentPage then
		if self.state.devPanelVisible and self.state.devPanelCurrentPage == self.consoleRef:getValue() then
			if self.cmdr then
				self.cmdr:Show()
			end
		elseif self.cmdr then
			self.cmdr:Hide()
			if self.cmdrFrame then
				for childIndex, cmdrChild in self.cmdrFrame:GetChildren() do
					if cmdrChild:IsA("TextBox") and cmdrChild:IsFocused() then
						cmdrChild:ReleaseFocus()
					end
				end
			end
		end
	end
	if self.state.garageVisible ~= prevState.garageVisible then
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		if vehiclePacket then
			vehiclePacket.LockMovement = self.state.garageVisible
		end
		if self.state.garageVisible then
			ActionButtonService.hide()
			ChatUtils.setEnabled(false)
			return
		end
		ActionButtonService.show()
		ChatUtils.setEnabled(true)
	end
end
function AppComponent.willUnmount(self)
	self._maid:DoCleaning()
end
Roact.mount(createElement("ScreenGui", {
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 8
}, { createElement(AppComponent) }), Players.LocalPlayer.PlayerGui, "AppUI")
RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer.PlayerGui, "TouchGui", function(touchGui, taskMaid)
	taskMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(touchGui, "TouchControlFrame", function(touchControlFrame, innerTaskMaid)
		innerTaskMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(touchControlFrame, "JumpButton", function(jumpButton)
			task.defer(jumpButton.Destroy, jumpButton)
		end))
	end))
end)
