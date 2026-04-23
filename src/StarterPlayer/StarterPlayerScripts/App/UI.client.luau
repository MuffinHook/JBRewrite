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
local v1 = RunUtils.getWorld()
local v2 = Roact.Component:extend("App")
local t = {}
t.mapImageId = assert(MinimapConsts.MAP_IMAGE_ID[v1], "missing mapImageId")
t.mapWorldWidth = assert(MinimapConsts.MAP_WORLD_WIDTH[v1], "missing mapWorldWidth")
t.mapWorldHeight = assert(MinimapConsts.MAP_WORLD_HEIGHT[v1], "missing mapWorldHeight")
t.mapWorldCenterX = assert(MinimapConsts.MAP_WORLD_CENTER_X[v1], "missing mapWorldCenterX")
t.mapWorldCenterY = assert(MinimapConsts.MAP_WORLD_CENTER_Y[v1], "missing mapWorldCenterY")
t.mapImageWidth = 512
t.mapImageHeight = 512
v2.defaultProps = t
function v2.init(p1) --[[ Line: 94 | Upvalues: Maid (copy), Settings (copy), GameUtil (copy), Utils (copy), RxInstanceUtils (copy), Players (copy), Roact (copy), gameSettingType (copy), GameSettingsService (copy), VehicleUtils (copy), HotbarSystem (copy), AdminPermUtils (copy), UserInputService (copy), store (copy), RunService (copy), SpeedometerUtils (copy), TableUtils (copy), CCTVService (copy), SidebarUI (copy), GarageUtils (copy), ReplicatedStorage (copy), GarageConsts (copy), SaleConsts (copy), Notification (copy), Confirmation (copy), ItemUtils (copy), String (copy), PlayerUtils (copy), GarageConsts_2 (copy), GamepassUtils (copy), CashBuyUI (copy), MinimapService (copy), RunUtils (copy), SpawnSelectionService (copy) ]]
	p1._maid = Maid.new()
	p1:setState({
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
	p1._maid:GiveTask(Utils.getViewportSizeChangedSignal():Connect(function() --[[ Line: 111 | Upvalues: p1 (copy), Utils (ref) ]]
		p1:setState({
			isSmallScreen = Utils.isSmallScreen()
		})
	end))
	p1._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer, "ChoosingTeam", function(p12, p2) --[[ Line: 120 | Upvalues: p1 (copy) ]]
		local function handler(p12) --[[ Line: 121 | Upvalues: p1 (ref) ]]
			p1:setState({
				controlsEnabled = not p12
			})
		end
		p2:GiveTask(p12.Changed:Connect(handler))
		p1:setState({
			controlsEnabled = not p12.Value
		})
	end))
	p1._maid:GiveTask(GameUtil.OnTeamChanged:Connect(function(p12) --[[ Line: 131 | Upvalues: p1 (copy), Settings (ref) ]]
		p1:setState({
			teamColor = Settings.TeamColor[p12]
		})
	end))
	local function updateBounty() --[[ Line: 137 | Upvalues: p1 (copy), GameUtil (ref) ]]
		p1:setState({
			bounty = GameUtil.bounty
		})
	end
	p1:setState({
		bounty = GameUtil.bounty
	})
	p1._maid:GiveTask(GameUtil.onBountyChanged:Connect(updateBounty))
	local v1, v2 = Roact.createBinding(123456)
	p1._spdDistance = v1
	p1._updateSpdDistance = v2
	local v3, v4 = Roact.createBinding(878)
	p1._spdSpeed = v3
	p1._updateSpdSpeed = v4
	local v5, v6 = Roact.createBinding(0)
	p1._spdAccelRatio = v5
	p1._updateSpdAccelRatio = v6
	local t = {
		name = "hotbarWithSpeedometer",
		title = "Hotbar With Speedometer",
		type = gameSettingType.Checkbox,
		defaultValue = false,
		order = 51
	}
	GameSettingsService.add(t)
	local function handleSetting(p1) --[[ Line: 157 | Upvalues: VehicleUtils (ref), HotbarSystem (ref) ]]
		if VehicleUtils.GetLocalVehiclePacket and VehicleUtils.GetLocalVehiclePacket() then
			if p1 then
				HotbarSystem.show()
				return
			end
			HotbarSystem.hide()
		end
	end
	local v7 = t:getValue()
	if VehicleUtils.GetLocalVehiclePacket and VehicleUtils.GetLocalVehiclePacket() then
		if v7 then
			HotbarSystem.show()
		else
			HotbarSystem.hide()
		end
	end
	t.onChanged:Connect(handleSetting)
	if AdminPermUtils.hasPerms(Players.LocalPlayer) then
		p1._maid:GiveTask(UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 170 | Upvalues: UserInputService (ref), p1 (copy) ]]
			if not p2 and (p12.KeyCode == Enum.KeyCode.G and (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and p1.state.inVehicle)) then
				p1:setState({
					speedometerEnabled = not p1.state.speedometerEnabled
				})
			end
		end))
	end
	p1._maid:GiveTask(VehicleUtils.OnVehicleEntered:Connect(function(p12, p2) --[[ Line: 182 | Upvalues: p1 (copy), store (ref), t (copy), HotbarSystem (ref), VehicleUtils (ref), RunService (ref), SpeedometerUtils (ref), Players (ref), RxInstanceUtils (ref), TableUtils (ref) ]]
		if not p2 then
			if p1.state.garageVisible then
				p12.LockMovement = true
			end
			store:dispatch({
				type = "setInVehicle",
				inVehicle = true
			})
			store:dispatch({
				type = "setLocalVehiclePacket",
				packet = p12
			})
			p1:setState({
				inVehicle = true
			})
			p12.seatMaid:GiveTask(function() --[[ Line: 200 | Upvalues: store (ref), p1 (ref) ]]
				store:dispatch({
					type = "setInVehicle",
					inVehicle = false
				})
				p1:setState({
					inVehicle = false,
					garageVisible = false
				})
			end)
			local BoundingBox = p12.Model:FindFirstChild("BoundingBox")
			if BoundingBox then
				if not t:getValue() then
					HotbarSystem.hide()
				end
				p12.seatMaid:GiveTask(function() --[[ Line: 216 | Upvalues: t (ref), HotbarSystem (ref) ]]
					if not t:getValue() then
						HotbarSystem.show()
					end
				end)
				local t2 = {
					speedometerEnabled = true,
					hasLicensePlate = false
				}
				t2.missilesEnabled = (p12.Bombs or p12.Rockets) and true or false
				t2.speedometerSmallUI = p12.Make == "Bionic"
				p1:setState(t2)
				p12.seatMaid:GiveTask(function() --[[ Line: 227 | Upvalues: p1 (ref) ]]
					p1:setState({
						speedometerEnabled = false,
						licensePromptEnabled = false
					})
				end)
				p1._updateSpdDistance(0)
				VehicleUtils.updateSpdBarRatio(0)
				VehicleUtils._forceUpdateNitroBar = true
				p12.seatMaid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 236 | Upvalues: BoundingBox (copy), SpeedometerUtils (ref), VehicleUtils (ref), p1 (ref), p12 (copy) ]]
					local v2 = math.abs((BoundingBox.Velocity:Dot(BoundingBox.CFrame.LookVector)))
					local v3 = SpeedometerUtils.sToH(SpeedometerUtils.studsToMi(v2))
					VehicleUtils.LastMPHClient = v3
					p1._updateSpdSpeed(v3)
					if p12.rpmVisual and p12.rpmVisualMax then
						p1._updateSpdAccelRatio(p12.rpmVisual / p12.rpmVisualMax)
					else
						p1._updateSpdAccelRatio(v2 / 100)
					end
				end))
				local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
				if PlayerGui then
					local MapMakeOdometer = PlayerGui:FindFirstChild("MapMakeOdometer")
					p12.seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(MapMakeOdometer, p12.Make, function(p12, p2) --[[ Line: 256 | Upvalues: p1 (ref), SpeedometerUtils (ref) ]]
						p1._updateSpdDistance(SpeedometerUtils.studsToMi(p12.Value))
						p2:GiveTask(p12.Changed:Connect(function(p12) --[[ Line: 258 | Upvalues: p1 (ref), SpeedometerUtils (ref) ]]
							p1._updateSpdDistance(SpeedometerUtils.studsToMi(p12))
						end))
					end))
				end
				local function updateLocked() --[[ Line: 267 | Upvalues: p1 (ref), p12 (copy), VehicleUtils (ref) ]]
					local t = {}
					t.vehicleLocked = p12.Model:GetAttribute("Locked") == true
					t.speedometerLockEnabled = VehicleUtils.canLocalLock()
					p1:setState(t)
				end
				local t3 = {}
				t3.vehicleLocked = p12.Model:GetAttribute("Locked") == true
				t3.speedometerLockEnabled = VehicleUtils.canLocalLock()
				p1:setState(t3)
				p12.seatMaid:GiveTask(p12.Model:GetAttributeChangedSignal("Locked"):Connect(updateLocked))
				local function updatePassengers() --[[ Line: 277 | Upvalues: VehicleUtils (ref), p12 (copy), TableUtils (ref), Players (ref), p1 (ref) ]]
					local v3 = TableUtils.map(TableUtils.filter(VehicleUtils.getSeats(p12.Model), function(p1) --[[ Line: 279 | Upvalues: Players (ref) ]]
						return p1.Player ~= Players.LocalPlayer
					end), function(p1) --[[ Line: 282 ]]
						return p1.Player
					end)
					local t = {
						passengers = v3
					}
					t.speedometerEjectEnabled = if #v3 > 0 then VehicleUtils.canLocalEject() else false
					p1:setState(t)
				end
				updatePassengers()
				for i, v in ipairs(p12.Model:GetChildren()) do
					if v.Name == "Seat" or v.Name == "Passenger" then
						local PlayerName = v:FindFirstChild("PlayerName")
						p12.seatMaid:GiveTask(PlayerName.Changed:Connect(updatePassengers))
					end
				end
				local Model = p12.Model:FindFirstChild("Model")
				if Model then
					local plate = Model:FindFirstChild("plate")
					if plate then
						local SurfaceGui = plate:FindFirstChild("SurfaceGui")
						if SurfaceGui then
							local TextLabel = SurfaceGui.Frame.TextLabel
							p1:setState({
								hasLicensePlate = true,
								licensePlateText = TextLabel.Text
							})
							p12.seatMaid:GiveTask(TextLabel:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 311 | Upvalues: p1 (ref), TextLabel (copy) ]]
								p1:setState({
									licensePlateText = TextLabel.Text
								})
							end))
						end
					end
				end
				local function updateMissiles() --[[ Line: 321 | Upvalues: Players (ref), p12 (copy), p1 (ref) ]]
					p1:setState({
						missileCount = Players.LocalPlayer:GetAttribute("MissileCount") or 0,
						missileMax = p12.Model:GetAttribute("MissileMax") or 0
					})
				end
				updateMissiles()
				p12.seatMaid:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal("MissileCount"):Connect(updateMissiles))
				p12.seatMaid:GiveTask(p12.Model:GetAttributeChangedSignal("MissileMax"):Connect(updateMissiles))
			end
		end
	end))
	p1._maid:GiveTask(CCTVService.onRequestPrompt:Connect(function(p12, p2) --[[ Line: 338 | Upvalues: p1 (copy) ]]
		if p12 == nil then
			p12 = true
		end
		local t = {
			cctvViewerEnabled = p12
		}
		t.cctvViewerExpireDistance = if p2 then 9999 else 20
		p1:setState(t)
	end))
	p1.consoleRef = Roact.createRef()
	p1.settingsRef = Roact.createRef()
	p1._maid:GiveTask(SidebarUI.onDevPanelToggle:Connect(function() --[[ Line: 350 | Upvalues: p1 (copy) ]]
		p1:setState({
			devPanelVisible = not p1.state.devPanelVisible,
			devPanelCurrentPage = p1.settingsRef:getValue()
		})
	end))
	local function setGarageUIOpen(p12) --[[ Line: 356 | Upvalues: GarageUtils (ref), ReplicatedStorage (ref), GarageConsts (ref), store (ref), SaleConsts (ref), p1 (copy) ]]
		local v1 = GarageUtils.inVehicle() and (GarageUtils.hasPremium() or GarageUtils.inPhysicalGarage())
		if p12 then
			if v1 then
				local v2 = ReplicatedStorage:FindFirstChild(GarageConsts.LOAD_LAST_SELECTION_REMOTE_NAME)
				if v2 then
					v2:FireServer()
				end
			end
			local v3 = store:getState()
			local t = {
				type = "setPage"
			}
			t.pageName = if v1 then "Customize" else "Spawn"
			t.categoryName = SaleConsts.CATEGORY_NAME
			t.sortId = v3.garageSort
			t.garageOwned = v3.garageOwned
			store:dispatch(t)
		end
		p1:setState({
			garageVisible = p12
		})
	end
	local v8 = ReplicatedStorage:FindFirstChild(GarageConsts.INFORM_UI_IS_OPEN_REMOTE_NAME)
	v8.OnClientEvent:Connect(setGarageUIOpen)
	p1._maid:GiveTask(SidebarUI.onGarageToggle:Connect(function() --[[ Line: 382 | Upvalues: p1 (copy), VehicleUtils (ref), Notification (ref), v8 (copy), setGarageUIOpen (copy) ]]
		if p1.state.garageVisible then
			v8:FireServer(not p1.state.garageVisible)
			setGarageUIOpen(not p1.state.garageVisible)
			return
		end
		local v1 = VehicleUtils.GetLocalVehiclePacket()
		if v1 and v1.Passenger then
			Notification.new({
				Title = "Garage",
				Text = "Cannot customize as passenger."
			})
		elseif v1 and v1.Model:GetAttribute("DisableGarage") then
			Notification.new({
				Text = "Garage disabled on this vehicle."
			})
		else
			v8:FireServer(not p1.state.garageVisible)
			setGarageUIOpen(not p1.state.garageVisible)
		end
	end))
	function p1.onClickLeaveGarage() --[[ Line: 400 | Upvalues: v8 (copy), p1 (copy) ]]
		v8:FireServer(false)
		p1:setState({
			garageVisible = false
		})
	end
	function p1.onClickSpawnVehicle(p12) --[[ Line: 406 | Upvalues: ReplicatedStorage (ref), GarageConsts (ref), p1 (copy) ]]
		local v1 = ReplicatedStorage:FindFirstChild(GarageConsts.SPAWN_VEHICLE_REMOTE_NAME)
		if v1 then
			v1:FireServer(p12.vehicleType, p12.vehicleMake)
		end
		p1.onClickLeaveGarage()
	end
	function p1.onAttemptPurchaseVehicle(p12, p2) --[[ Line: 414 | Upvalues: Confirmation (ref), p1 (copy), ItemUtils (ref), String (ref), ReplicatedStorage (ref), GarageConsts (ref) ]]
		if p12.limited then
		elseif p2.locked then
			local v1 = Confirmation.new("You need the Pro Garage gamepass to buy this here. Otherwise, find it in the world and buy it there. Want to buy Pro Garage?")
			p1:setState({
				garageVisible = false
			})
			v1.Maid:GiveTask(function() --[[ Line: 427 | Upvalues: p1 (ref) ]]
				p1:setState({
					garageVisible = true
				})
			end)
			v1.Maid:GiveTask(v1.OnYes:Connect(function() --[[ Line: 432 | Upvalues: p1 (ref) ]]
				p1.onRequestPremiumUpgrade()
			end))
		else
			local vehicleMake = p12.vehicleMake
			local v3 = ItemUtils.getTranslatedTitleFromItemTable((ItemUtils.createVehicleItemTable(vehicleMake)))
			local v4 = Confirmation.new("Purchase the " .. v3 .. " for $" .. String.comma(p12.price) .. "?")
			p1:setState({
				garageVisible = false
			})
			v4.Maid:GiveTask(function() --[[ Line: 446 | Upvalues: p1 (ref) ]]
				p1:setState({
					garageVisible = true
				})
			end)
			v4.Maid:GiveTask(v4.OnYes:Connect(function() --[[ Line: 451 | Upvalues: ReplicatedStorage (ref), GarageConsts (ref), vehicleMake (copy) ]]
				ReplicatedStorage:FindFirstChild(GarageConsts.PURCHASE_VEHICLE_REMOTE_NAME):FireServer(vehicleMake)
			end))
		end
	end
	function p1.getRemainingDebounce() --[[ Line: 455 | Upvalues: store (ref), PlayerUtils (ref), Players (ref), GarageConsts (ref), GarageConsts_2 (ref) ]]
		local v1 = store:getState()
		local v2 = workspace:GetServerTimeNow() - PlayerUtils.getLastVehicleSpawnedAt()
		return if v1.garageInPhysical or Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) then GarageConsts_2.SPAWN_DEBOUNCE_PHYSICAL elseif v1.garagePremium then GarageConsts_2.SPAWN_DEBOUNCE_PREMIUM else GarageConsts_2.SPAWN_DEBOUNCE_NON_PREMIUM - v2
	end
	function p1.onDeleteSlot(p12) --[[ Line: 470 | Upvalues: Confirmation (ref), p1 (copy), store (ref) ]]
		local v1 = Confirmation.new("Are you sure you want to delete this save slot?")
		p1:setState({
			garageVisible = false
		})
		v1.Maid:GiveTask(function() --[[ Line: 477 | Upvalues: p1 (ref) ]]
			p1:setState({
				garageVisible = true
			})
		end)
		v1.Maid:GiveTask(v1.OnYes:Connect(function() --[[ Line: 482 | Upvalues: store (ref), p12 (copy) ]]
			store:dispatch({
				type = "deleteSaveSlot",
				name = p12
			})
		end))
	end
	function p1.attemptEquipGarageItem(p1, p2) --[[ Line: 490 | Upvalues: ReplicatedStorage (ref), GarageConsts (ref) ]]
		local v1 = ReplicatedStorage:FindFirstChild(GarageConsts.EQUIP_ITEM_REMOTE_NAME)
		if v1 then
			v1:FireServer(p1, p2)
		end
	end
	function p1.attemptFavoriteGarageItem(p1, p2, p3) --[[ Line: 496 | Upvalues: ReplicatedStorage (ref), GarageConsts (ref) ]]
		local v1 = ReplicatedStorage:FindFirstChild(GarageConsts.UPDATE_FAVORITED_REMOTE_NAME)
		if v1 then
			v1:FireServer(p1, p2, p3)
		end
	end
	function p1.attemptBuyGarageItem(p1, p2) --[[ Line: 502 | Upvalues: ReplicatedStorage (ref), GarageConsts (ref) ]]
		local v1 = ReplicatedStorage:FindFirstChild(GarageConsts.PURCHASE_ITEM_REMOTE_NAME)
		if v1 then
			v1:FireServer(p1, p2)
		end
	end
	function p1.notify(p1) --[[ Line: 508 | Upvalues: Notification (ref) ]]
		Notification.new({
			Text = p1
		})
	end
	function p1.onRequestPremiumUpgrade() --[[ Line: 511 | Upvalues: GamepassUtils (ref) ]]
		GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.PremiumGarage)
	end
	function p1.garagePromptCashPurchase() --[[ Line: 514 | Upvalues: p1 (copy), CashBuyUI (ref) ]]
		p1.onClickLeaveGarage()
		CashBuyUI.Open()
	end
	p1.minimapBaseProps = {
		mapImageColor3 = MinimapService.mapImageColor3,
		mapImageId = p1.props.mapImageId,
		mapWorldWidth = p1.props.mapWorldWidth,
		mapWorldHeight = p1.props.mapWorldHeight,
		mapWorldCenterX = p1.props.mapWorldCenterX,
		mapWorldCenterY = p1.props.mapWorldCenterY,
		mapImageWidth = p1.props.mapImageWidth,
		mapImageHeight = p1.props.mapImageHeight,
		worldPosition = MinimapService.mapWorldPosition,
		worldDirection = MinimapService.mapWorldDirection
	}
	function p1.minimapOnToggle() --[[ Line: 531 | Upvalues: p1 (copy) ]]
		p1:setState({
			minimapOpen = not p1.state.minimapOpen
		})
	end
	function p1.megamapOnToggle() --[[ Line: 536 | Upvalues: p1 (copy) ]]
		p1:setState({
			megamapOpen = not p1.state.megamapOpen
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
	p1._maid:GiveTask(UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 578 | Upvalues: p1 (copy) ]]
		if not p2 and p12.UserInputType == Enum.UserInputType.Keyboard then
			if p12.KeyCode == Enum.KeyCode.M then
				p1.megamapOnToggle()
			end
		elseif not p2 and (p12.UserInputType == Enum.UserInputType.Gamepad1 and p12.KeyCode == Enum.KeyCode.DPadRight) then
			p1.megamapOnToggle()
		end
	end))
	function p1.onSpawnSelectionSpawnPressed(p1) --[[ Line: 593 | Upvalues: SpawnSelectionService (ref), GameUtil (ref) ]]
		SpawnSelectionService.attemptSelect(p1.name)
		GameUtil.removeDeathLighting()
	end
	function p1.onSpawnSelectionShowSpawns() --[[ Line: 597 | Upvalues: SpawnSelectionService (ref), GameUtil (ref) ]]
		SpawnSelectionService.requestShowSpawns()
		GameUtil.removeDeathGui()
	end
	local t2 = {
		name = "showTooltips",
		title = "Show Tooltips",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 52
	}
	GameSettingsService.add(t2)
	local function handleTooltips(p1) --[[ Line: 610 | Upvalues: store (ref) ]]
		store:dispatch({
			type = "setTooltipVisible",
			value = p1
		})
	end
	store:dispatch({
		type = "setTooltipVisible",
		value = t2:getValue()
	})
	t2.onChanged:Connect(handleTooltips)
end
function v2.render(p1) --[[ Line: 619 | Upvalues: createElement (copy), Runtime (copy), Bounty (copy), MinimapRodux (copy), Dictionary (copy), SidebarUI (copy), InputUtils (copy), SidebarHolder (copy), BigButtonService (copy), BigMinimap (copy), CenterMessage (copy), TrackService (copy), LikePromptRodux (copy), TooltipRodux (copy), Utils (copy), Speedometer (copy), VehicleUtils (copy), LicensePlate (copy), Viewer (copy), TabContainer (copy), Roact (copy), ReplicatedStorage (copy), Garage (copy), CasinoKeypad (copy), DamageIndicators (copy), Trade (copy), TradeInitiations (copy), TradeResult (copy), RewardSpinner (copy), Safes (copy), SpawnSelection (copy), SpawnSelectionConsts (copy), ChooseSpawn (copy), Settings (copy), OtherTradeServerListRodux (copy), RoactRodux (copy), store (copy) ]]
	local t = {
		Controls = createElement(Runtime, {
			enabled = p1.state.controlsEnabled,
			color = p1.state.teamColor
		})
	}
	if p1.state.isSmallScreen then
		local t2 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.1, 0, 1, 0),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0)
		}
		local t3 = {
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
		local t4 = {
			amount = p1.state.bounty
		}
		t4.enabled = p1.state.bounty > 0
		t4.displayOrder = 2
		t3.Bounty = createElement(Bounty, t4)
		local t5 = {
			square = true,
			mapScale = 6,
			size = UDim2.new(0.9, 0, 0.9, 0),
			anchorPoint = Vector2.new(0.5, 0.5),
			isSmallScreen = p1.state.isSmallScreen,
			color = p1.state.teamColor
		}
		t5.open = p1.state.minimapOpen and p1.state.controlsEnabled
		t5.showToggleButton = p1.state.controlsEnabled
		t5.time = SidebarUI.time
		t5.displayOrder = 3
		t5.onToggle = p1.minimapOnToggle
		t5.onClick = p1.megamapOnToggle
		t3.Minimap = createElement(MinimapRodux, Dictionary.merge(p1.minimapBaseProps, t5))
		t.TopRight = createElement("Frame", t2, t3)
	else
		local v9 = InputUtils.isGamepad()
		local t2 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.4, 0)
		}
		t2.Position = UDim2.new(0, 0, if v9 then 0.74 else 0.6, 0)
		t2.AnchorPoint = Vector2.new(0, 0.5)
		local t3 = {
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
				color = p1.state.teamColor,
				buttons = BigButtonService.active,
				size = UDim2.new(1, 0, 1, 0),
				anchorPoint = Vector2.new(0, 1),
				position = UDim2.new(0, 0, 0, 0),
				displayOrder = 1
			})
		}
		local t4 = {
			amount = p1.state.bounty
		}
		t4.enabled = p1.state.bounty > 0
		t4.displayOrder = 2
		t3.Bounty = createElement(Bounty, t4)
		local t5 = {
			square = true,
			mapScale = 6,
			size = UDim2.new(0.9, 0, 0.9, 0),
			anchorPoint = Vector2.new(0.5, 0.5),
			isSmallScreen = p1.state.isSmallScreen,
			color = p1.state.teamColor
		}
		t5.open = p1.state.minimapOpen and p1.state.controlsEnabled
		t5.showToggleButton = p1.state.controlsEnabled
		t5.time = SidebarUI.time
		t5.displayOrder = 3
		t5.onToggle = p1.minimapOnToggle
		t5.onClick = p1.megamapOnToggle
		t3.Minimap = createElement(MinimapRodux, Dictionary.merge(p1.minimapBaseProps, t5))
		t.Buttons = createElement("Frame", t2, t3)
	end
	t.Minimap = createElement(BigMinimap, Dictionary.merge(p1.minimapBaseProps, {
		visible = p1.state.megamapOpen,
		open = true,
		size = UDim2.new(0.7, 0, 0.7, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5),
		labels = p1.state.minimapLabels,
		color = p1.state.teamColor,
		displayOrder = 1,
		onToggle = p1.megamapOnToggle,
		isSmallScreen = p1.state.isSmallScreen,
		square = true
	}))
	t.TrackCountdown = createElement(CenterMessage, {
		text = TrackService.screenText
	})
	t.LikePrompt = createElement(LikePromptRodux, {
		size = UDim2.fromScale(0.35, 0.5),
		anchorPoint = Vector2.new(0.5, 1),
		position = UDim2.fromScale(0.5, 0.8)
	})
	local t2 = {}
	t2.size = UDim2.fromScale(0.6, if p1.state.isSmallScreen then 0.025 else 0.015)
	t2.anchorPoint = Vector2.new(0.5, 1)
	t2.position = if Utils.isSmallScreen() then UDim2.fromScale(0.5, 0.95) else UDim2.fromScale(0.5, 1)
	t2.visible = not p1.state.inVehicle
	t.Tooltip = createElement(TooltipRodux, t2)
	if p1.state.speedometerEnabled then
		local t3 = {
			enabled = true,
			color = p1.state.teamColor,
			distance = p1._spdDistance,
			speed = p1._spdSpeed,
			barRatio = VehicleUtils.spdBarRatio,
			accelRatio = p1._spdAccelRatio,
			size = UDim2.new(0.25, 0, 0.5, 0)
		}
		t3.position = UDim2.new(0.5, 0, if p1.state.speedometerSmallUI then 0.93 else 0.95, 0)
		t3.anchorPoint = Vector2.new(0.5, 1)
		t3.locked = p1.state.vehicleLocked
		t3.lockEnabled = p1.state.speedometerLockEnabled
		t3.hasLicensePlate = p1.state.hasLicensePlate
		t3.licensePlate = p1.state.licensePlateText
		t3.ejectEnabled = p1.state.speedometerEjectEnabled
		t3.missilesEnabled = p1.state.missilesEnabled
		t3.missileCount = p1.state.missileCount
		t3.missileMax = p1.state.missileMax
		t3.passengers = p1.state.passengers
		t3.smallUI = p1.state.speedometerSmallUI
		function t3.onClickBar() --[[ Line: 769 | Upvalues: VehicleUtils (ref) ]]
			VehicleUtils.NitroShopVisible(true, true)
		end
		function t3.onClickLock() --[[ Line: 772 | Upvalues: VehicleUtils (ref) ]]
			VehicleUtils.toggleLocalLocked()
		end
		function t3.onClickEjectName(p1) --[[ Line: 775 | Upvalues: VehicleUtils (ref) ]]
			VehicleUtils.attemptPassengerEject(p1)
		end
		function t3.onClickPlate() --[[ Line: 778 | Upvalues: p1 (copy) ]]
			p1:setState({
				licensePromptEnabled = true
			})
		end
		t3.onClickMissileBuy = VehicleUtils.promptMissileBuy
		t.Speedometer = createElement(Speedometer, t3)
	end
	if p1.state.licensePromptEnabled then
		t.LicensePlate = createElement(LicensePlate, {
			text = p1.state.licensePlateText,
			size = UDim2.new(0.2, 0, 0.5, 0),
			position = UDim2.new(0.5, 0, 0.5, 0),
			onClickClose = function() --[[ Name: onClickClose | Line: 791 | Upvalues: p1 (copy) ]]
				p1:setState({
					licensePromptEnabled = false
				})
			end,
			onClickApply = function(p12) --[[ Name: onClickApply | Line: 796 | Upvalues: p1 (copy) ]]
				p1:setState({
					licensePromptEnabled = false
				})
				if #p12 ~= 0 then
					p1.attemptBuyGarageItem("LicensePlate", p12)
				end
			end
		})
	end
	if p1.state.cctvViewerEnabled then
		t.CCTVViewer = createElement(Viewer, {
			size = UDim2.new(0.5, 0, 0.5, 0),
			position = UDim2.new(0.5, 0, 0.5, 0),
			distance = 96,
			aspectRatio = 1.7777777777777777,
			expireDistance = p1.state.cctvViewerExpireDistance,
			cameraTag = "CCTVCamera",
			fieldOfView = 70,
			onClickClose = function() --[[ Name: onClickClose | Line: 816 | Upvalues: p1 (copy) ]]
				p1:setState({
					cctvViewerEnabled = false
				})
			end
		})
	end
	t.DevPanel = createElement(TabContainer, {
		color = p1.state.teamColor,
		visible = p1.state.devPanelVisible,
		isSmallScreen = p1.state.isSmallScreen,
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
				[Roact.Ref] = p1.consoleRef
			},
			{
				title = "SETTINGS",
				tabColor = Color3.new(0/255, 255/255, 0/255),
				layoutOrder = 2,
				backgroundColor = Color3.fromRGB(17, 17, 17),
				backgroundTransparency = 0.4,
				[Roact.Ref] = p1.settingsRef,
				[Roact.Children] = createElement(require(ReplicatedStorage.GameSettings.UI.GameSettings), {
					size = UDim2.new(1, 0, 1, 0),
					color = p1.state.teamColor
				})
			}
		},
		currentPage = p1.state.devPanelCurrentPage,
		updatePage = function(p12) --[[ Name: updatePage | Line: 854 | Upvalues: p1 (copy) ]]
			p1:setState({
				devPanelCurrentPage = p12
			})
		end
	})
	local t3 = {}
	t3.size = if p1.state.isSmallScreen then UDim2.new(0.65, 0, 0.6, 0) else UDim2.new(0.65, 0, 0.7, 0) or UDim2.new(0.65, 0, 0.6, 0)
	t3.anchorPoint = Vector2.new(0.5, 0.5)
	t3.position = if p1.state.isSmallScreen then UDim2.new(0.5, 0, 0.35, 0) else UDim2.new(0.5, 0, 0.25, 0) or UDim2.new(0.5, 0, 0.35, 0)
	t3.disabled = not p1.state.garageVisible
	t3.onClickLeaveGarage = p1.onClickLeaveGarage
	t3.onClickSpawnVehicle = p1.onClickSpawnVehicle
	t3.onAttemptPurchaseVehicle = p1.onAttemptPurchaseVehicle
	t3.getRemainingDebounce = p1.getRemainingDebounce
	t3.attemptEquipItem = p1.attemptEquipGarageItem
	t3.attemptBuyItem = p1.attemptBuyGarageItem
	t3.attemptFavoriteItem = p1.attemptFavoriteGarageItem
	t3.notify = p1.notify
	t3.onRequestPremiumUpgrade = p1.onRequestPremiumUpgrade
	t3.promptCashPurchase = p1.garagePromptCashPurchase
	t3.colsPerRow = if p1.state.isSmallScreen then 6 else 7
	t3.rowsPerPage = if p1.state.isSmallScreen then 2 else 2.5
	t3.categoriesPerPage = if p1.state.isSmallScreen then 7 else 10
	t3.onDeleteSlot = p1.onDeleteSlot
	t.Garage = createElement(Garage, t3)
	t.CasinoKeypad = createElement(CasinoKeypad)
	t.DamageIndicators = createElement(DamageIndicators, {
		size = UDim2.new(0.5, 0, 0.5, 0)
	})
	local t4 = {}
	t4.size = p1.state.isSmallScreen and UDim2.new(0.75, 0, 0.75, 0) or UDim2.new(0.6, 0, 0.6, 0)
	t4.position = p1.state.isSmallScreen and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.55, 0)
	t.Trade = createElement(Trade, t4)
	local t5 = {
		size = UDim2.new(0.3333333333333333, 0, 0.3333333333333333, 0)
	}
	t5.position = if p1.state.isSmallScreen then UDim2.new(0.5, 0, 0.6666666666666666, 0) else UDim2.new(1, 0, 0.7, 0)
	t5.anchorPoint = if p1.state.isSmallScreen then Vector2.new(0.5, 0.5) else Vector2.new(1, 0.5)
	t.TradeInitiations = createElement(TradeInitiations, t5)
	t.TradeResult = createElement(TradeResult, {
		size = UDim2.new(0.25, 0, 0.25, 0),
		position = UDim2.new(0.5, 0, 0.3333333333333333, 0),
		anchorPoint = Vector2.new(0.5, 0.5)
	})
	t.RewardSpinner = createElement(RewardSpinner, {
		size = UDim2.new(0.3333333333333333, 0, 0.25, 0),
		position = UDim2.new(0.5, 0, 0.03125, 0),
		anchorPoint = Vector2.new(0.5, 0)
	})
	t.Safes = createElement(Safes, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5)
	})
	t.SpawnSelection = createElement(SpawnSelection, Dictionary.merge(p1.minimapBaseProps, {
		visible = true,
		open = true,
		size = UDim2.new(0.7, 0, 0.7, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5),
		color = p1.state.teamColor,
		displayOrder = 1,
		isSmallScreen = p1.state.isSmallScreen,
		square = true,
		duration = SpawnSelectionConsts.MAX_WAIT_TIME,
		onSpawnPressed = p1.onSpawnSelectionSpawnPressed
	}))
	t.ChooseSpawn = createElement(ChooseSpawn, {
		duration = Settings.Time.Respawn,
		size = UDim2.new(0.5, 0, 0.08, 0),
		position = UDim2.new(0.5, 0, 0.7, 0),
		onSelect = p1.onSpawnSelectionShowSpawns
	})
	t.OtherTradeServerListRodux = createElement(OtherTradeServerListRodux, {
		verticalPaddingRatio = 128,
		aspectRatio = 2,
		size = UDim2.fromScale(0.8, 0.7),
		position = UDim2.fromScale(0.5, 0.5),
		anchorPoint = Vector2.new(0.5, 0.5)
	})
	return Roact.createElement(RoactRodux.StoreProvider, {
		store = store
	}, { Roact.createFragment(t) })
end
function v2.didMount(p1) --[[ Line: 953 | Upvalues: CmdrExtSystem (copy), Players (copy), UserInputService (copy), RxInstanceUtils (copy), ReplicatedStorage (copy) ]]
	p1._maid:GivePromise(CmdrExtSystem.promiseCmdr():andThen(function(p12, p2) --[[ Line: 954 | Upvalues: p1 (copy), Players (ref), UserInputService (ref), RxInstanceUtils (ref), ReplicatedStorage (ref) ]]
		p1.cmdr = p12
		p1.cmdrFrame = p2
		p2.Parent = p1.consoleRef.current
		p12:SetEnabled(true)
		p1._maid:GiveTask(function() --[[ Line: 960 | Upvalues: p12 (copy) ]]
			p12:SetEnabled(false)
		end)
		p1._maid:GiveTask(function() --[[ Line: 963 | Upvalues: p2 (copy), Players (ref) ]]
			p2.Parent = Players.LocalPlayer
		end)
		if p1.state.devPanelVisible and p1.state.devPanelCurrentPage == p1.consoleRef:getValue() then
			p12:Show()
		else
			p12:Hide()
		end
		p1._maid:GiveTask(UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 972 | Upvalues: p1 (ref) ]]
			if p12.UserInputType == Enum.UserInputType.Keyboard and p12.KeyCode == Enum.KeyCode.Backquote and (not p2 or p1.state.devPanelVisible) then
				p1:setState({
					devPanelVisible = not p1.state.devPanelVisible,
					devPanelCurrentPage = p1.consoleRef:getValue()
				})
			end
		end))
		p1._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(ReplicatedStorage, "OpenCmdrMenu", function(p12) --[[ Line: 986 | Upvalues: p1 (ref) ]]
			p12.OnClientEvent:Connect(function() --[[ Line: 987 | Upvalues: p1 (ref) ]]
				p1:setState({
					devPanelVisible = true,
					devPanelCurrentPage = p1.consoleRef:getValue()
				})
			end)
		end))
	end))
end
function v2.didUpdate(p1, p2, p3) --[[ Line: 997 | Upvalues: VehicleUtils (copy), ActionButtonService (copy), ChatUtils (copy) ]]
	if p1.state.devPanelVisible ~= p3.devPanelVisible or p1.state.devPanelCurrentPage ~= p3.devPanelCurrentPage then
		if p1.state.devPanelVisible and p1.state.devPanelCurrentPage == p1.consoleRef:getValue() then
			if p1.cmdr then
				p1.cmdr:Show()
			end
		elseif p1.cmdr then
			p1.cmdr:Hide()
			if p1.cmdrFrame then
				for v1, v2 in p1.cmdrFrame:GetChildren() do
					if v2:IsA("TextBox") and v2:IsFocused() then
						v2:ReleaseFocus()
					end
				end
			end
		end
	end
	if p1.state.garageVisible ~= p3.garageVisible then
		local v3 = VehicleUtils.GetLocalVehiclePacket()
		if v3 then
			v3.LockMovement = p1.state.garageVisible
		end
		if p1.state.garageVisible then
			ActionButtonService.hide()
			ChatUtils.setEnabled(false)
			return
		end
		ActionButtonService.show()
		ChatUtils.setEnabled(true)
	end
end
function v2.willUnmount(p1) --[[ Line: 1034 ]]
	p1._maid:DoCleaning()
end
Roact.mount(createElement("ScreenGui", {
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 8
}, { createElement(v2) }), Players.LocalPlayer.PlayerGui, "AppUI")
RxInstanceUtils.observeOneChildNamed(Players.LocalPlayer.PlayerGui, "TouchGui", function(p1, p2) --[[ Line: 1050 | Upvalues: RxInstanceUtils (copy) ]]
	p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "TouchControlFrame", function(p1, p2) --[[ Line: 1055 | Upvalues: RxInstanceUtils (ref) ]]
		p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "JumpButton", function(p1) --[[ Line: 1057 ]]
			task.defer(p1.Destroy, p1)
		end))
	end))
end)