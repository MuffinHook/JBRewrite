-- App UI Component
-- Main Roact component that drives the HUD, minimap, speedometer, garage, CCTV, etc.

local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")

local RunUtils             = require(ReplicatedStorage.App.RunUtils)
local Settings             = require(ReplicatedStorage.Resource.Settings)
local RxInstanceUtils      = require(ReplicatedStorage.Std.RxInstanceUtils)
local Utils                = require(ReplicatedStorage.EzUi.Utils)
local Roact                = require(ReplicatedStorage.Roact)
local createElement        = Roact.createElement
local VehicleUtils         = require(ReplicatedStorage.Vehicle.VehicleUtils)
local MinimapConsts        = require(ReplicatedStorage.App.MinimapConsts)
local SidebarUI            = require(ReplicatedStorage.Game.SidebarUI)
local store                = require(ReplicatedStorage.App.store)
local Maid                 = require(ReplicatedStorage.Std.Maid)
local GameUtil             = require(ReplicatedStorage.Game.GameUtil)
local gameSettingType      = require(ReplicatedStorage.GameSettings.gameSettingType)
local GameSettingsService  = require(ReplicatedStorage.GameSettings.GameSettingsService)
local HotbarSystem         = require(ReplicatedStorage.Hotbar.HotbarSystem)
local AdminPermUtils       = require(ReplicatedStorage.App.AdminPermUtils)
local SpeedometerUtils     = require(ReplicatedStorage.Speedometer.SpeedometerUtils)
local TableUtils           = require(ReplicatedStorage.Std.TableUtils)
local CCTVService          = require(ReplicatedStorage.CCTV.CCTVService)
local GarageUtils          = require(ReplicatedStorage.Garage.GarageUtils)
local GarageConsts2        = require(ReplicatedStorage.Garage.GarageConsts)  -- garage remote consts
local SaleConsts           = require(ReplicatedStorage.Sale.SaleConsts)
local Notification         = require(ReplicatedStorage.Game.Notification)
local Confirmation         = require(ReplicatedStorage.Module.Confirmation)
local ItemUtils            = require(ReplicatedStorage.App.ItemUtils)
local String               = require(ReplicatedStorage.Std.String)
local PlayerUtils          = require(ReplicatedStorage.Game.PlayerUtils)
local GarageConsts         = require(ReplicatedStorage.Game.Garage.GarageConsts)  -- spawn debounce consts
local GamepassUtils        = require(ReplicatedStorage.Gamepass.GamepassUtils)
local CashBuyUI            = require(ReplicatedStorage.Game.CashBuyUI)
local MinimapService       = require(ReplicatedStorage.App.MinimapService)
local SpawnSelectionService = require(ReplicatedStorage.SpawnSelection.SpawnSelectionService)

-- UI sub-modules (required at bottom of file, kept here for clarity)
local Runtime              = require(ReplicatedStorage.ActionButton.UI.Runtime)
local Bounty               = require(ReplicatedStorage.App.UI.Bounty)
local MinimapRodux         = require(ReplicatedStorage.App.UI.MinimapRodux)
local Dictionary           = require(ReplicatedStorage.EzUi.Dictionary)
local InputUtils           = require(ReplicatedStorage.Std.InputUtils)
local SidebarHolder        = require(ReplicatedStorage.App.UI.SidebarHolder)
local BigButtonService     = require(ReplicatedStorage.App.BigButtonService)
local BigMinimap           = require(ReplicatedStorage.App.UI.BigMinimap)
local CenterMessage        = require(ReplicatedStorage.App.UI.CenterMessage)
local TrackService         = require(ReplicatedStorage.RaceTrack.TrackService)
local LikePromptRodux      = require(ReplicatedStorage.LikePrompt.UI.LikePromptRodux)
local TooltipRodux         = require(ReplicatedStorage.Tooltip.UI.TooltipRodux)
local Speedometer          = require(ReplicatedStorage.Speedometer.UI.Speedometer)
local LicensePlate         = require(ReplicatedStorage.Speedometer.UI.LicensePlate)
local Viewer               = require(ReplicatedStorage.CCTV.UI.Viewer)
local TabContainer         = require(ReplicatedStorage.EzUi.TabContainer)
local Garage               = require(ReplicatedStorage.Garage.UI.Garage)
local CasinoKeypad         = require(ReplicatedStorage.Casino.UI.CasinoKeypad)
local DamageIndicators     = require(ReplicatedStorage.DamageIndicator.UI.DamageIndicators)
local Trade                = require(ReplicatedStorage.Trade.UI.Trade)
local TradeInitiations     = require(ReplicatedStorage.Trade.UI.TradeInitiations)
local TradeResult          = require(ReplicatedStorage.Trade.UI.TradeResult)
local RewardSpinner        = require(ReplicatedStorage.RewardSpinner.UI.RewardSpinner)
local Safes                = require(ReplicatedStorage.Safes.UI.Safes)
local SpawnSelection       = require(ReplicatedStorage.SpawnSelection.UI.SpawnSelection)
local SpawnSelectionConsts = require(ReplicatedStorage.SpawnSelection.SpawnSelectionConsts)
local ChooseSpawn          = require(ReplicatedStorage.SpawnSelection.UI.ChooseSpawn)
local OtherTradeServerListRodux = require(ReplicatedStorage.Trade.UI.OtherTradeServerListRodux)
local RoactRodux           = require(ReplicatedStorage.RoactRodux)
local CmdrExtSystem        = require(ReplicatedStorage.CmdrExt.CmdrExtSystem)
local ActionButtonService  = require(ReplicatedStorage.ActionButton.ActionButtonService)
local ChatUtils            = require(ReplicatedStorage.Chat.ChatUtils)

-- ── App component setup ───────────────────────────────────────
local world   = RunUtils.getWorld()
local AppComp = Roact.Component:extend("App")

AppComp.defaultProps = {
	mapImageId      = assert(MinimapConsts.MAP_IMAGE_ID[world],      "missing mapImageId"),
	mapWorldWidth   = assert(MinimapConsts.MAP_WORLD_WIDTH[world],   "missing mapWorldWidth"),
	mapWorldHeight  = assert(MinimapConsts.MAP_WORLD_HEIGHT[world],  "missing mapWorldHeight"),
	mapWorldCenterX = assert(MinimapConsts.MAP_WORLD_CENTER_X[world], "missing mapWorldCenterX"),
	mapWorldCenterY = assert(MinimapConsts.MAP_WORLD_CENTER_Y[world], "missing mapWorldCenterY"),
	mapImageWidth   = 512,
	mapImageHeight  = 512,
}

-- ── init ──────────────────────────────────────────────────────
function AppComp.init(self)
	self._maid = Maid.new()

	self:setState({
		controlsEnabled    = true,
		teamColor          = Settings.TeamColor[GameUtil.Team],
		isSmallScreen      = Utils.isSmallScreen(),
		minimapOpen        = true,
		megamapOpen        = false,
		bounty             = 0,
		speedometerEnabled = false,
		vehicleLocked      = false,
		hasLicensePlate    = false,
		licensePlateText   = "JAILBRK",
		missilesEnabled    = false,
		devPanelVisible    = false,
		garageVisible      = false,
	})

	-- viewport size changes
	self._maid:GiveTask(Utils.getViewportSizeChangedSignal():Connect(function()
		self:setState({ isSmallScreen = Utils.isSmallScreen() })
	end))

	-- disable controls while team chooser is open
	self._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(
		Players.LocalPlayer, "ChoosingTeam",
		function(choosingTeamValue, childMaid)
			childMaid:GiveTask(choosingTeamValue.Changed:Connect(function(val)
				self:setState({ controlsEnabled = not val })
			end))
			self:setState({ controlsEnabled = not choosingTeamValue.Value })
		end
	))

	-- team color
	self._maid:GiveTask(GameUtil.OnTeamChanged:Connect(function(newTeam)
		self:setState({ teamColor = Settings.TeamColor[newTeam] })
	end))

	-- bounty
	self:setState({ bounty = GameUtil.bounty })
	self._maid:GiveTask(GameUtil.onBountyChanged:Connect(function()
		self:setState({ bounty = GameUtil.bounty })
	end))

	-- speedometer bindings
	local spdDistanceBinding, updateSpdDistance = Roact.createBinding(123456)
	local spdSpeedBinding,    updateSpdSpeed    = Roact.createBinding(878)
	local spdAccelBinding,    updateSpdAccel    = Roact.createBinding(0)

	self._spdDistance      = spdDistanceBinding
	self._updateSpdDistance = updateSpdDistance
	self._spdSpeed         = spdSpeedBinding
	self._updateSpdSpeed   = updateSpdSpeed
	self._spdAccelRatio    = spdAccelBinding
	self._updateSpdAccelRatio = updateSpdAccel

	-- hotbar with speedometer setting
	local hotbarWithSpeedoSetting = {
		name         = "hotbarWithSpeedometer",
		title        = "Hotbar With Speedometer",
		type         = gameSettingType.Checkbox,
		defaultValue = false,
		order        = 51,
	}
	GameSettingsService.add(hotbarWithSpeedoSetting)

	-- apply on load
	if VehicleUtils.GetLocalVehiclePacket and VehicleUtils.GetLocalVehiclePacket() then
		if hotbarWithSpeedoSetting:getValue() then
			HotbarSystem.show()
		else
			HotbarSystem.hide()
		end
	end

	hotbarWithSpeedoSetting.onChanged:Connect(function(enabled)
		if VehicleUtils.GetLocalVehiclePacket and VehicleUtils.GetLocalVehiclePacket() then
			if enabled then
				HotbarSystem.show()
			else
				HotbarSystem.hide()
			end
		end
	end)

	-- admin speedometer toggle (Shift+G while in vehicle)
	if AdminPermUtils.hasPerms(Players.LocalPlayer) then
		self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, processed)
			if not processed
				and input.KeyCode == Enum.KeyCode.G
				and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
				and self.state.inVehicle
			then
				self:setState({ speedometerEnabled = not self.state.speedometerEnabled })
			end
		end))
	end

	-- vehicle entered
	self._maid:GiveTask(VehicleUtils.OnVehicleEntered:Connect(function(packet, isPassenger)
		if isPassenger then return end  -- only driver gets full HUD setup

		-- lock movement if garage is open
		if self.state.garageVisible then
			packet.LockMovement = true
		end

		store:dispatch({ type = "setInVehicle",          inVehicle = true })
		store:dispatch({ type = "setLocalVehiclePacket", packet    = packet })
		self:setState({ inVehicle = true })

		-- cleanup on exit
		packet.seatMaid:GiveTask(function()
			store:dispatch({ type = "setInVehicle", inVehicle = false })
			self:setState({ inVehicle = false, garageVisible = false })
		end)

		local bbox = packet.Model:FindFirstChild("BoundingBox")
		if not bbox then return end

		-- hide hotbar while in vehicle (unless setting says keep it)
		if not hotbarWithSpeedoSetting:getValue() then
			HotbarSystem.hide()
		end
		packet.seatMaid:GiveTask(function()
			if not hotbarWithSpeedoSetting:getValue() then
				HotbarSystem.show()
			end
		end)

		-- initial speedometer state
		self:setState({
			speedometerEnabled    = true,
			hasLicensePlate       = false,
			missilesEnabled       = packet.Bombs or packet.Rockets and true or false,
			speedometerSmallUI    = false,
		})

		packet.seatMaid:GiveTask(function()
			self:setState({
				speedometerEnabled   = false,
				licensePromptEnabled = false,
			})
		end)

		self._updateSpdDistance(0)
		VehicleUtils.updateSpdBarRatio(0)
		VehicleUtils._forceUpdateNitroBar = true

		-- speed update loop
		packet.seatMaid:GiveTask(RunService.Heartbeat:Connect(function()
			local speed    = math.abs(bbox.Velocity:Dot(bbox.CFrame.LookVector))
			local speedMph = SpeedometerUtils.sToH(SpeedometerUtils.studsToMi(speed))
			VehicleUtils.LastMPHClient = speedMph
			self._updateSpdSpeed(speedMph)
			if packet.rpmVisual and packet.rpmVisualMax then
				self._updateSpdAccelRatio(packet.rpmVisual / packet.rpmVisualMax)
			else
				self._updateSpdAccelRatio(speed / 100)
			end
		end))

		-- odometer distance
		local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
		if playerGui then
			local odometer = playerGui:FindFirstChild("MapMakeOdometer")
			if odometer then
				packet.seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(
					odometer, packet.Make,
					function(distValue, distMaid)
						self._updateSpdDistance(SpeedometerUtils.studsToMi(distValue.Value))
						distMaid:GiveTask(distValue.Changed:Connect(function(newVal)
							self._updateSpdDistance(SpeedometerUtils.studsToMi(newVal))
						end))
					end
				))
			end
		end

		-- vehicle lock state
		local function updateLocked()
			self:setState({
				vehicleLocked          = packet.Model:GetAttribute("Locked") == true,
				speedometerLockEnabled = VehicleUtils.canLocalLock(),
			})
		end
		updateLocked()
		packet.seatMaid:GiveTask(
			packet.Model:GetAttributeChangedSignal("Locked"):Connect(updateLocked)
		)

		-- passengers list
		local function updatePassengers()
			local seats = VehicleUtils.getSeats(packet.Model)
			local others = TableUtils.map(
				TableUtils.filter(seats, function(seat)
					return seat.Player ~= Players.LocalPlayer
				end),
				function(seat) return seat.Player end
			)
			local canEject = #others > 0 and VehicleUtils.canLocalEject() or false
			self:setState({
				passengers               = others,
				speedometerEjectEnabled  = canEject,
			})
		end
		updatePassengers()

		for _, child in ipairs(packet.Model:GetChildren()) do
			if child.Name == "Seat" or child.Name == "Passenger" then
				local nameValue = child:FindFirstChild("PlayerName")
				if nameValue then
					packet.seatMaid:GiveTask(nameValue.Changed:Connect(updatePassengers))
				end
			end
		end

		-- license plate
		local vehicleModel = packet.Model:FindFirstChild("Model")
		if vehicleModel then
			local plate = vehicleModel:FindFirstChild("plate")
			if plate then
				local surfaceGui = plate:FindFirstChild("SurfaceGui")
				if surfaceGui then
					local label = surfaceGui.Frame.TextLabel
					self:setState({
						hasLicensePlate  = true,
						licensePlateText = label.Text,
					})
					packet.seatMaid:GiveTask(
						label:GetPropertyChangedSignal("Text"):Connect(function()
							self:setState({ licensePlateText = label.Text })
						end)
					)
				end
			end
		end

		-- missiles
		local function updateMissiles()
			self:setState({
				missileCount = Players.LocalPlayer:GetAttribute("MissileCount") or 0,
				missileMax   = packet.Model:GetAttribute("MissileMax") or 0,
			})
		end
		updateMissiles()
		packet.seatMaid:GiveTask(
			Players.LocalPlayer:GetAttributeChangedSignal("MissileCount"):Connect(updateMissiles)
		)
		packet.seatMaid:GiveTask(
			packet.Model:GetAttributeChangedSignal("MissileMax"):Connect(updateMissiles)
		)
	end))

	-- CCTV prompt
	self._maid:GiveTask(CCTVService.onRequestPrompt:Connect(function(_, _expireData)
		self:setState({
			cctvViewerEnabled       = true,
			cctvViewerExpireDistance = 20,
		})
	end))

	-- refs for console / settings panels
	self.consoleRef  = Roact.createRef()
	self.settingsRef = Roact.createRef()

	-- dev panel toggle from sidebar
	self._maid:GiveTask(SidebarUI.onDevPanelToggle:Connect(function()
		self:setState({
			devPanelVisible      = not self.state.devPanelVisible,
			devPanelCurrentPage  = self.settingsRef:getValue(),
		})
	end))

	-- garage open/close logic
	local garageInformRemote = ReplicatedStorage:FindFirstChild(GarageConsts2.INFORM_UI_IS_OPEN_REMOTE_NAME)

	local function setGarageUIOpen(open)
		local hasPremiumAccess = GarageUtils.hasPremium() or GarageUtils.inPhysicalGarage()

		if open then
			-- fire load-last-selection if premium garage
			if hasPremiumAccess then
				local loadLastRemote = ReplicatedStorage:FindFirstChild(GarageConsts2.LOAD_LAST_SELECTION_REMOTE_NAME)
				if loadLastRemote then
					loadLastRemote:FireServer()
				end
			end

			local state = store:getState()
			store:dispatch({
				type         = "setPage",
				pageName     = hasPremiumAccess and "Customize" or "Spawn",
				categoryName = SaleConsts.CATEGORY_NAME,
				sortId       = state.garageSort,
				garageOwned  = state.garageOwned,
			})
		end

		self:setState({ garageVisible = open })
	end

	garageInformRemote.OnClientEvent:Connect(setGarageUIOpen)

	self._maid:GiveTask(SidebarUI.onGarageToggle:Connect(function()
		if not self.state.garageVisible then
			local localPacket = VehicleUtils.GetLocalVehiclePacket()
			if localPacket then
				if localPacket.Passenger then
					Notification.new({ Title = "Garage", Text = "Cannot customize as passenger." })
					return
				end
				if localPacket.Model:GetAttribute("DisableGarage") then
					Notification.new({ Text = "Garage disabled on this vehicle." })
					return
				end
			end
		end
		garageInformRemote:FireServer(not self.state.garageVisible)
		setGarageUIOpen(not self.state.garageVisible)
	end))

	function self.onClickLeaveGarage()
		garageInformRemote:FireServer(false)
		self:setState({ garageVisible = false })
	end

	function self.onClickSpawnVehicle(vehicleData)
		local spawnRemote = ReplicatedStorage:FindFirstChild(GarageConsts2.SPAWN_VEHICLE_REMOTE_NAME)
		if spawnRemote then
			spawnRemote:FireServer(vehicleData.vehicleType, vehicleData.vehicleMake)
		end
		self.onClickLeaveGarage()
	end

	function self.onAttemptPurchaseVehicle(vehicleData, lockData)
		if vehicleData.limited then return end

		if lockData.locked then
			-- need pro garage to buy here, prompt upgrade
			local confirm = Confirmation.new(
				"You need the Pro Garage gamepass to buy this here. "
				.. "Otherwise, find it in the world and buy it there. Want to buy Pro Garage?"
			)
			self:setState({ garageVisible = false })
			confirm.Maid:GiveTask(function()
				self:setState({ garageVisible = true })
			end)
			confirm.Maid:GiveTask(confirm.OnYes:Connect(function()
				self.onRequestPremiumUpgrade()
			end))
			return
		end

		local make    = vehicleData.vehicleMake
		local title   = ItemUtils.getTranslatedTitleFromItemTable(ItemUtils.createVehicleItemTable(make))
		local confirm = Confirmation.new(string.format("Purchase the %s for $%s?", title, String.comma(vehicleData.price)))

		self:setState({ garageVisible = false })
		confirm.Maid:GiveTask(function()
			self:setState({ garageVisible = true })
		end)
		confirm.Maid:GiveTask(confirm.OnYes:Connect(function()
			ReplicatedStorage:FindFirstChild(GarageConsts2.PURCHASE_VEHICLE_REMOTE_NAME):FireServer(make)
		end))
	end

	function self.getRemainingDebounce()
		local state      = store:getState()
		local debounce
		if Players.LocalPlayer:GetAttribute(GarageConsts2.AERIAL_SPAWN_ATTR_NAME) then
			debounce = GarageConsts.SPAWN_DEBOUNCE_PHYSICAL
		elseif state.garagePremium then
			debounce = GarageConsts.SPAWN_DEBOUNCE_PREMIUM
		else
			debounce = GarageConsts.SPAWN_DEBOUNCE_NON_PREMIUM
		end
		return debounce - (workspace:GetServerTimeNow() - PlayerUtils.getLastVehicleSpawnedAt())
	end

	function self.onDeleteSlot(slotName)
		local confirm = Confirmation.new("Are you sure you want to delete this save slot?")
		self:setState({ garageVisible = false })
		confirm.Maid:GiveTask(function()
			self:setState({ garageVisible = true })
		end)
		confirm.Maid:GiveTask(confirm.OnYes:Connect(function()
			store:dispatch({ type = "deleteSaveSlot", name = slotName })
		end))
	end

	function self.attemptEquipGarageItem(itemId, itemType)
		local remote = ReplicatedStorage:FindFirstChild(GarageConsts2.EQUIP_ITEM_REMOTE_NAME)
		if remote then remote:FireServer(itemId, itemType) end
	end

	function self.attemptFavoriteGarageItem(itemId, itemType, favorited)
		local remote = ReplicatedStorage:FindFirstChild(GarageConsts2.UPDATE_FAVORITED_REMOTE_NAME)
		if remote then remote:FireServer(itemId, itemType, favorited) end
	end

	function self.attemptBuyGarageItem(itemId, itemType)
		local remote = ReplicatedStorage:FindFirstChild(GarageConsts2.PURCHASE_ITEM_REMOTE_NAME)
		if remote then remote:FireServer(itemId, itemType) end
	end

	function self.notify(text)
		Notification.new({ Text = text })
	end

	function self.onRequestPremiumUpgrade()
		GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.PremiumGarage)
	end

	function self.garagePromptCashPurchase()
		self.onClickLeaveGarage()
		CashBuyUI.Open()
	end

	-- minimap base props (shared by minimap + megamap)
	self.minimapBaseProps = {
		mapImageColor3  = MinimapService.mapImageColor3,
		mapImageId      = self.props.mapImageId,
		mapWorldWidth   = self.props.mapWorldWidth,
		mapWorldHeight  = self.props.mapWorldHeight,
		mapWorldCenterX = self.props.mapWorldCenterX,
		mapWorldCenterY = self.props.mapWorldCenterY,
		mapImageWidth   = self.props.mapImageWidth,
		mapImageHeight  = self.props.mapImageHeight,
		worldPosition   = MinimapService.mapWorldPosition,
		worldDirection  = MinimapService.mapWorldDirection,
	}

	function self.minimapOnToggle()
		self:setState({ minimapOpen = not self.state.minimapOpen })
	end

	function self.megamapOnToggle()
		self:setState({ megamapOpen = not self.state.megamapOpen })
	end

	-- minimap labels (main world only)
	if RunUtils.isMainWorld() then
		store:dispatch({
			type   = "addMinimapLabels",
			labels = {
				{ title = "TOWN",        position = Vector3.new( 621.013, 27.5249, -1267.4) },
				{ title = "PRISON",      position = Vector3.new(-1315.3,  14.6840, -1675.2) },
				{ title = "RISING CITY", position = Vector3.new(  26.5249, 14.9200,  1059.65) },
				{ title = "CRIME PORT",  position = Vector3.new(-450.30,  66.2979,  2057.05) },
				{ title = "VOLCANO",     position = Vector3.new(2163.95,  61.5509, -2597.8) },
				{ title = "CRATER CITY", position = Vector3.new(-403.71,  40.2350, -5835.2) },
				{ title = "TRADE PORT",  position = Vector3.new(2428.20,  20.7509, -3775.4) },
			},
		})
	end

	-- megamap M-key toggle
	self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard
			and input.KeyCode == Enum.KeyCode.M
		then
			self:setState({ megamapOpen = not self.state.megamapOpen })
		end
	end))

	function self.onSpawnSelectionSpawnPressed(spawnData)
		SpawnSelectionService.attemptSelect(spawnData.name)
		GameUtil.removeDeathLighting()
	end

	function self.onSpawnSelectionShowSpawns()
		SpawnSelectionService.requestShowSpawns()
		GameUtil.removeDeathGui()
	end

	-- tooltips setting
	local tooltipSetting = {
		name         = "showTooltips",
		title        = "Show Tooltips",
		type         = gameSettingType.Checkbox,
		defaultValue = true,
		order        = 52,
	}
	GameSettingsService.add(tooltipSetting)
	store:dispatch({ type = "setTooltipVisible", value = tooltipSetting:getValue() })
	tooltipSetting.onChanged:Connect(function(enabled)
		store:dispatch({ type = "setTooltipVisible", value = enabled })
	end)
end

-- ── render ────────────────────────────────────────────────────
function AppComp.render(self)
	local state    = self.state
	local isSmall  = state.isSmallScreen

	-- shared minimap props
	local minimapProps = Dictionary.merge(self.minimapBaseProps, {
		square         = true,
		mapScale       = 6,
		size           = UDim2.new(0.9, 0, 0.9, 0),
		anchorPoint    = Vector2.new(0.5, 0.5),
		isSmallScreen  = isSmall,
		color          = state.teamColor,
		open           = state.minimapOpen and state.controlsEnabled,
		showToggleButton = state.controlsEnabled,
		time           = SidebarUI.time,
		displayOrder   = 3,
		onToggle       = self.minimapOnToggle,
		onClick        = self.megamapOnToggle,
	})

	-- top-right frame children (bounty + minimap)
	local topRightChildren = {
		Padding = createElement("UIPadding", {
			PaddingTop = UDim.new(0, 61),
		}),
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment   = Enum.VerticalAlignment.Top,
			SortOrder           = Enum.SortOrder.LayoutOrder,
			FillDirection       = Enum.FillDirection.Vertical,
			Padding             = UDim.new(0, 8),
		}),
		Bounty = createElement(Bounty, {
			amount       = state.bounty,
			enabled      = state.bounty > 0,
			displayOrder = 2,
		}),
		Minimap = createElement(MinimapRodux, minimapProps),
	}

	-- top-right container
	local topRight = createElement("Frame", {
		BackgroundTransparency = 1,
		Size                   = UDim2.new(0.1, 0, 1, 0),
		AnchorPoint            = Vector2.new(1, 0),
		Position               = UDim2.new(1, 0, 0, 0),
	}, topRightChildren)

	-- HUD root frame
	local hudProps = {
		BackgroundTransparency = 1,
		Size                   = UDim2.new(1, 0, 0.4, 0),
	}
	if InputUtils.isGamepad() then
		-- gamepad layout adjustments handled by children
	end

	-- controls / action buttons
	local controls = createElement(Runtime, {
		enabled = state.controlsEnabled,
		color   = state.teamColor,
	})

	-- sidebar
	local sidebar = createElement(SidebarHolder, {
		inVehicle    = state.inVehicle,
		garageVisible = state.garageVisible,
	})

	-- speedometer
	local speedometer = nil
	if state.speedometerEnabled then
		speedometer = createElement(Speedometer, {
			spdSpeed         = self._spdSpeed,
			spdAccelRatio    = self._spdAccelRatio,
			spdDistance      = self._spdDistance,
			lockEnabled      = state.speedometerLockEnabled,
			vehicleLocked    = state.vehicleLocked,
			ejectEnabled     = state.speedometerEjectEnabled,
			passengers       = state.passengers,
			missileCount     = state.missileCount,
			missileMax       = state.missileMax,
			missilesEnabled  = state.missilesEnabled,
			smallUI          = state.speedometerSmallUI,
		})
	end

	-- license plate
	local licensePlate = nil
	if state.hasLicensePlate then
		licensePlate = createElement(LicensePlate, {
			text = state.licensePlateText,
		})
	end

	-- megamap
	local megamap = nil
	if state.megamapOpen then
		megamap = createElement(BigMinimap, Dictionary.merge(self.minimapBaseProps, {
			onClose = self.megamapOnToggle,
		}))
	end

	-- CCTV viewer
	local cctvViewer = nil
	if state.cctvViewerEnabled then
		cctvViewer = createElement(Viewer, {
			expireDistance = state.cctvViewerExpireDistance,
		})
	end

	-- garage
	local garage = nil
	if state.garageVisible then
		garage = createElement(Garage, {
			onClickLeave          = self.onClickLeaveGarage,
			onClickSpawnVehicle   = self.onClickSpawnVehicle,
			onAttemptPurchase     = self.onAttemptPurchaseVehicle,
			getRemainingDebounce  = self.getRemainingDebounce,
			onDeleteSlot          = self.onDeleteSlot,
			attemptEquipItem      = self.attemptEquipGarageItem,
			attemptFavoriteItem   = self.attemptFavoriteGarageItem,
			attemptBuyItem        = self.attemptBuyGarageItem,
			notify                = self.notify,
			onRequestPremiumUpgrade = self.onRequestPremiumUpgrade,
			promptCashPurchase    = self.garagePromptCashPurchase,
		})
	end

	-- dev panel
	local devPanel = nil
	if state.devPanelVisible then
		devPanel = createElement(TabContainer, {
			currentPage   = state.devPanelCurrentPage,
			settingsRef   = self.settingsRef,
			consoleRef    = self.consoleRef,
		})
	end

	-- spawn selection
	local spawnSelection = createElement(SpawnSelection, {
		onSpawnPressed  = self.onSpawnSelectionSpawnPressed,
		onShowSpawns    = self.onSpawnSelectionShowSpawns,
	})

	return createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn   = false,
		IgnoreGuiInset = true,
		DisplayOrder   = 8,
	}, {
		HUD = createElement("Frame", hudProps, {
			Controls     = controls,
			TopRight     = topRight,
			Sidebar      = sidebar,
		}),
		Speedometer      = speedometer,
		LicensePlate     = licensePlate,
		Megamap          = megamap,
		CCTVViewer       = cctvViewer,
		Garage           = garage,
		DevPanel         = devPanel,
		SpawnSelection   = spawnSelection,
		DamageIndicators = createElement(DamageIndicators),
		Trade            = createElement(Trade),
		TradeInitiations = createElement(TradeInitiations),
		TradeResult      = createElement(TradeResult),
		RewardSpinner    = createElement(RewardSpinner),
		Safes            = createElement(Safes),
		ChooseSpawn      = createElement(ChooseSpawn),
		CenterMessage    = createElement(CenterMessage),
		LikePrompt       = createElement(LikePromptRodux),
		Tooltip          = createElement(TooltipRodux),
		OtherTradeServerList = createElement(OtherTradeServerListRodux),
		BigButtonArea    = createElement("Frame", {
			BackgroundTransparency = 1,
			Size                   = UDim2.new(1, 0, 0.4, 0),
		}),
	})
end

-- ── didMount ──────────────────────────────────────────────────
function AppComp.didMount(self)
	-- wire up cmdr console once it's ready
	self._maid:GivePromise(CmdrExtSystem.promiseCmdr():andThen(function(cmdr, cmdrFrame)
		self.cmdr      = cmdr
		self.cmdrFrame = cmdrFrame

		cmdrFrame.Parent = self.consoleRef.current
		cmdr:SetEnabled(true)

		self._maid:GiveTask(function() cmdr:SetEnabled(false) end)
		self._maid:GiveTask(function() cmdrFrame.Parent = Players.LocalPlayer end)

		-- show/hide based on current panel state
		if self.state.devPanelVisible and self.state.devPanelCurrentPage == self.consoleRef:getValue() then
			cmdr:Show()
		else
			cmdr:Hide()
		end

		-- backtick toggles dev panel
		self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, processed)
			if input.UserInputType == Enum.UserInputType.Keyboard
				and input.KeyCode == Enum.KeyCode.Backquote
			then
				if processed and not self.state.devPanelVisible then return end
				self:setState({
					devPanelVisible     = not self.state.devPanelVisible,
					devPanelCurrentPage = self.consoleRef:getValue(),
				})
			end
		end))

		-- remote open cmdr event
		self._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(
			ReplicatedStorage, "OpenCmdrMenu",
			function(remote)
				remote.OnClientEvent:Connect(function()
					self:setState({
						devPanelVisible     = true,
						devPanelCurrentPage = self.consoleRef:getValue(),
					})
				end)
			end
		))
	end))
end

-- ── didUpdate ─────────────────────────────────────────────────
function AppComp.didUpdate(self, _prevProps, prevState)
	-- cmdr show/hide when dev panel page changes
	if self.state.devPanelCurrentPage ~= prevState.devPanelCurrentPage then
		if self.state.devPanelVisible and self.state.devPanelCurrentPage == self.consoleRef:getValue() then
			if self.cmdr then
				self.cmdr:Show()
			end
		elseif self.cmdr then
			self.cmdr:Hide()
			-- release focus from any text boxes inside cmdr frame
			if self.cmdrFrame then
				for _, child in self.cmdrFrame:GetChildren() do
					if child:IsA("TextBox") and child:IsFocused() then
						child:ReleaseFocus()
					end
				end
			end
		end
	end

	-- garage open/close — lock vehicle movement, toggle action buttons + chat
	if self.state.garageVisible ~= prevState.garageVisible then
		local localPacket = VehicleUtils.GetLocalVehiclePacket()
		if localPacket then
			localPacket.LockMovement = self.state.garageVisible
		end
		if self.state.garageVisible then
			ActionButtonService.hide()
			ChatUtils.setEnabled(false)
		else
			ActionButtonService.show()
			ChatUtils.setEnabled(true)
		end
	end
end

-- ── willUnmount ───────────────────────────────────────────────
function AppComp.willUnmount(self)
	self._maid:DoCleaning()
end

-- ── Mount ─────────────────────────────────────────────────────
Roact.mount(
	createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn   = false,
		IgnoreGuiInset = true,
		DisplayOrder   = 8,
	}, { createElement(AppComp) }),
	Players.LocalPlayer.PlayerGui,
	"AppUI"
)

-- remove the mobile jump button (it conflicts with the HUD)
RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer.PlayerGui, "TouchGui", function(touchGui, outerMaid)
	outerMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(touchGui, "TouchControlFrame", function(frame, innerMaid)
		innerMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(frame, "JumpButton", function(btn)
			task.defer(btn.Destroy, btn)
		end))
	end))
end)
