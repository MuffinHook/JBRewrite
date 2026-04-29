local Players = game:GetService("Players")
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Promise = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Settings = require(ReplicatedStorage.Resource.Settings)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local HumanoidUnloadConsts = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
local ChatUtils = require(ReplicatedStorage.Chat.ChatUtils)
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local WorldMarkerGroup = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local WorldMarkerSystem = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local WorldMarker = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
local MinimapService = require(ReplicatedStorage.App.MinimapService)
Maid.new():GiveTask(RunService.Heartbeat:Connect(function()
	local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	if localPlayer then
		MinimapService.mapUpdateWorldPosition(localPlayer.Position)
		MinimapService.mapUpdateWorldDirection(localPlayer.CFrame.LookVector)
	end
end))
require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadService)
local function getColorFromTeam(team)
	if team == Settings.Team.Police then
		return Settings.TeamColor[Settings.EnumTeam.Police]
	else
		return Settings.TeamColor[Settings.EnumTeam.Criminal]
	end
end
CharacterUtils.observeLocalCharacterAdded(function(character, maid)
	local Humanoid = character:FindFirstChild("Humanoid")
	local Health = Humanoid.Health
	maid:GiveTask(Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		if Humanoid.Health <= 0 then
			HapticEffect.basic(1, 1)
		elseif Humanoid.Health < Health then
			HapticEffect.basic(1, 0.2)
		end
		Health = Humanoid.Health
	end))
end)
CharacterUtils.observeCharacterAdded(function(character, maid)
	local Humanoid = character:FindFirstChild("Humanoid")
	assert(Humanoid)
	local teammate = Players:GetPlayerFromCharacter(character)
	if teammate ~= Players.LocalPlayer then
		local configTable = {
			name = teammate.Name,
			flash = false
		}
		maid:GivePromise(Promise.all({ RxInstanceUtils.waitForChild(teammate, "TeamValue", 5), RxInstanceUtils.waitForChild(Players.LocalPlayer, "TeamValue", 5) }):andThen(function(teamValues)
			local teammateTeamValue = teamValues[1]
			local localPlayerTeamValue = teamValues[2]
			local colorBinding, updateColor = Roact.createBinding(if teammateTeamValue.Value == Settings.Team.Police then Settings.TeamColor[Settings.EnumTeam.Police] else Settings.TeamColor[Settings.EnumTeam.Criminal])
			configTable.color = colorBinding
			configTable.updateColor = updateColor
			local function updateFlash()
				configTable.flash = if localPlayerTeamValue.Value == teammateTeamValue.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end
			maid:GiveTask(teammateTeamValue.Changed:Connect(function(newValue)
				configTable.updateColor(if newValue == Settings.Team.Police then Settings.TeamColor[Settings.EnumTeam.Police] else Settings.TeamColor[Settings.EnumTeam.Criminal])
				configTable.flash = if localPlayerTeamValue.Value == teammateTeamValue.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			maid:GiveTask(localPlayerTeamValue.Changed:Connect(function()
				configTable.flash = if localPlayerTeamValue.Value == teammateTeamValue.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			maid:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers"):Connect(function()
				configTable.flash = if localPlayerTeamValue.Value == teammateTeamValue.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			configTable.flash = if localPlayerTeamValue.Value == teammateTeamValue.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			maid:GiveTask(MinimapService.add(configTable))
		end))
		maid:GiveTask(RxInstanceUtils.observeOneChildNamed(character, "HumanoidRootPart", function(humanoidRoot, rootMaid)
			configTable.part = humanoidRoot
			rootMaid:GiveTask(function()
				configTable.part = nil
			end)
		end))
		maid:GiveTask(Interval.every(0.1):Connect(function()
			local serverPosition = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
			if configTable._position and (not configTable.part and serverPosition) then
				configTable._updatePosition((configTable._position:getValue():Lerp(serverPosition.Value, 1/3)))
			end
		end))
	end
end)
local store = require(ReplicatedStorage.App.store)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local configTable = {
	type = "setPremium"
}
configTable.premium = GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage) or PrivateServerUtils.getIsBattleServer()
store:dispatch(configTable)
GamepassSystem.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.PremiumGarage):Connect(function()
	store:dispatch({
		type = "setPremium",
		premium = true
	})
end)
for enumIndex, gamepassName in GamepassUtils.EnumGamepass:GetEnumItems() do
	local gamepassEnum = GamepassUtils.EnumGamepass[gamepassName]
	store:dispatch({
		type = "setGamepassOwned",
		gamepassEnum = gamepassEnum,
		gamepassOwned = GamepassSystem.DoesPlayerOwn(gamepassEnum)
	})
	GamepassSystem.GetGamepassOwnedSignal(gamepassEnum):Connect(function()
		store:dispatch({
			type = "setGamepassOwned",
			gamepassEnum = gamepassEnum,
			gamepassOwned = GamepassSystem.DoesPlayerOwn(gamepassEnum)
		})
	end)
end
local waypointMaid = Maid.new()
local markerGroup = WorldMarkerGroup.new()
WorldMarkerSystem.addGroup(markerGroup)
local function setWaypoint(waypointConfig)
	waypointMaid:DoCleaning()
	if waypointConfig then
		local position = waypointConfig.position
		local part = waypointConfig.part
		local minDist = waypointConfig.minDist
		local waypointMarker = ReplicatedStorage.App.Res:FindFirstChild("WaypointMarker"):Clone()
		if position then
			waypointMarker:PivotTo(CFrame.new(position))
		elseif part then
			position = part.Position
			waypointMarker:PivotTo(CFrame.new(position))
			waypointMaid:GiveTask(Interval.every(0.5):Connect(function()
				if part and part:IsDescendantOf(workspace) then
					position = part.Position
					waypointMarker:PivotTo(CFrame.new(position))
				else
					store:dispatch({
						type = "removeWaypointByName",
						name = waypointConfig.name
					})
				end
			end))
		end
		waypointMarker.Parent = workspace
		waypointMaid:GiveTask(RunService.Heartbeat:Connect(function()
			waypointMarker.Arrow.CFrame = waypointMarker.ArrowRoot.CFrame * CFrame.Angles(0, os.clock() % math.tau, 0)
		end))
		waypointMaid:GiveTask(waypointMarker)
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = waypointMarker.PrimaryPart
		local beamClone = ReplicatedStorage.App.Res:FindFirstChild("SlowArrowBeam"):Clone()
		beamClone.Attachment0 = Attachment
		beamClone.Parent = waypointMarker
		waypointMaid:GiveTask(beamClone)
		local worldMarker = WorldMarker.new()
		worldMarker:SetScreenGui(WorldMarkerSystem.gui)
		if position then
			worldMarker:SetPosition(position)
		elseif part then
			worldMarker:SetAdornee(part)
		end
		worldMarker:SetIcon(5920742944)
		worldMarker.FrameInner.ImageColor3 = Color3.fromRGB(255, 108, 98)
		markerGroup:Add(worldMarker)
		waypointMaid:GiveTask(function()
			markerGroup:Remove(worldMarker)
			worldMarker:Destroy()
		end)
		store:dispatch({
			type = "addMinimapLabel",
			title = waypointConfig.name .. "_",
			imageId = 5920742944,
			position = worldMarker:GetPosition(),
			markerColor = worldMarker.FrameInner.ImageColor3,
			scale = 1.5
		})
		worldMarker._maid:GiveTask(function()
			store:dispatch({
				type = "removeMinimapLabel",
				title = waypointConfig.name .. "_"
			})
		end)
		local function update()
			local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if localPlayer then
				beamClone.Attachment1 = localPlayer:FindFirstChildOfClass("Attachment")
				if ((localPlayer.PrimaryPart.Position - localPlayer.Position) * Vector3.new(1, 0, 1)).Magnitude < minDist then
					store:dispatch({
						type = "removeWaypointByName",
						name = waypointConfig.name
					})
				end
			end
		end
		update()
		waypointMaid:GiveTask(Interval.every(1):Connect(update))
		if waypointConfig.message then
			local function getComponent()
				local isSmallScreen = EzUtils.isSmallScreen()
				local screenGuiProps = {
					ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
					ResetOnSpawn = false,
					IgnoreGuiInset = true
				}
				local messageFrameChildren = {}
				local messageFrameProps = {
					LayoutOrder = 1,
					BackgroundTransparency = 1
				}
				messageFrameProps.Size = UDim2.fromScale(0.6, if isSmallScreen then 0.07500000000000001 else 0.045)
				messageFrameProps.AnchorPoint = Vector2.new(0.5, 1)
				messageFrameProps.Position = UDim2.fromScale(0.5, 0.75)
				messageFrameProps.Message = createElement("Frame", messageFrameProps, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Font = Enum.Font.FredokaOne,
						Text = waypointConfig.message,
						TextColor3 = Color3.new(0.95, 0.05, 0.05),
						TextScaled = true
					}, {
						Stroke = createElement("UIStroke", {
							Thickness = 1,
							Color = Color3.new(0.1, 0.1, 0.1),
							Transparency = 0.2
						})
					})
				})
				return createElement("ScreenGui", messageFrameProps, messageFrameChildren)
			end
			local waypointGui = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "WaypointGui")
			waypointMaid:GiveTask(function()
				Roact.unmount(waypointGui)
			end)
		end
	end
end
store.changed:connect(function(oldState, newState)
	if oldState.minimapWaypoints == newState.minimapWaypoints then
		if oldState.otherTradeServerListConfig ~= newState.otherTradeServerListConfig then
			if oldState.otherTradeServerListConfig.visible then
				ChatUtils.setEnabled(false)
				return
			end
			ChatUtils.setEnabled(true)
		end
	else
		local minimapWaypoints = oldState.minimapWaypoints
		setWaypoint(minimapWaypoints[#minimapWaypoints])
	end
end)
if RunUtils.isTradeWorld() then
	require(ReplicatedStorage.App.TradeWorldApp).init()
end
