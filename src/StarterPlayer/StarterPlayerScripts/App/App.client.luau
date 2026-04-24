-- Reviewed by Claude
-- variables reassigned
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
local function getColorFromTeam(p1)
	if p1 == Settings.Team.Police then
		return Settings.TeamColor[Settings.EnumTeam.Police]
	else
		return Settings.TeamColor[Settings.EnumTeam.Criminal]
	end
end
CharacterUtils.observeLocalCharacterAdded(function(p1, p2)
	local Humanoid = p1:FindFirstChild("Humanoid")
	local Health = Humanoid.Health
	p2:GiveTask(Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		if Humanoid.Health <= 0 then
			HapticEffect.basic(1, 1)
		elseif Humanoid.Health < Health then
			HapticEffect.basic(1, 0.2)
		end
		Health = Humanoid.Health
	end))
end)
CharacterUtils.observeCharacterAdded(function(p1, p2)
	local Humanoid = p1:FindFirstChild("Humanoid")
	assert(Humanoid)
	local localPlayer = Players:GetPlayerFromCharacter(p1)
	if localPlayer ~= Players.LocalPlayer then
		local configTable = {
			name = localPlayer.Name,
			flash = false
		}
		p2:GivePromise(Promise.all({ RxInstanceUtils.waitForChild(localPlayer, "TeamValue", 5), RxInstanceUtils.waitForChild(Players.LocalPlayer, "TeamValue", 5) }):andThen(function(p1)
			local localPlayer = p1[1]
			local v2 = p1[2]
			local v6, v7 = Roact.createBinding(if localPlayer.Value == Settings.Team.Police then Settings.TeamColor[Settings.EnumTeam.Police] else Settings.TeamColor[Settings.EnumTeam.Criminal])
			configTable.color = v6
			configTable.updateColor = v7
			local function updateFlash()
				configTable.flash = if v2.Value == localPlayer.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end
			p2:GiveTask(localPlayer.Changed:Connect(function(p1)
				configTable.updateColor(if p1 == Settings.Team.Police then Settings.TeamColor[Settings.EnumTeam.Police] else Settings.TeamColor[Settings.EnumTeam.Criminal])
				configTable.flash = if v2.Value == localPlayer.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			p2:GiveTask(v2.Changed:Connect(function()
				configTable.flash = if v2.Value == localPlayer.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			p2:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers"):Connect(function()
				configTable.flash = if v2.Value == localPlayer.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			configTable.flash = if v2.Value == localPlayer.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			p2:GiveTask(MinimapService.add(configTable))
		end))
		p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "HumanoidRootPart", function(p1, p2)
			configTable.part = p1
			p2:GiveTask(function()
				configTable.part = nil
			end)
		end))
		p2:GiveTask(Interval.every(0.1):Connect(function()
			local localPlayer = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
			if configTable._position and (not configTable.part and localPlayer) then
				configTable._updatePosition((configTable._position:getValue():Lerp(localPlayer.Value, 0.3333333333333333)))
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
for v2, v3 in GamepassUtils.EnumGamepass:GetEnumItems() do
	local localPlayer = GamepassUtils.EnumGamepass[v3]
	store:dispatch({
		type = "setGamepassOwned",
		gamepassEnum = localPlayer,
		gamepassOwned = GamepassSystem.DoesPlayerOwn(localPlayer)
	})
	GamepassSystem.GetGamepassOwnedSignal(localPlayer):Connect(function()
		store:dispatch({
			type = "setGamepassOwned",
			gamepassEnum = localPlayer,
			gamepassOwned = GamepassSystem.DoesPlayerOwn(localPlayer)
		})
	end)
end
local v5 = Maid.new()
local v6 = WorldMarkerGroup.new()
WorldMarkerSystem.addGroup(v6)
local function setWaypoint(p1)
	v5:DoCleaning()
	if p1 then
		local position = p1.position
		local part = p1.part
		local minDist = p1.minDist
		local localPlayer = ReplicatedStorage.App.Res:FindFirstChild("WaypointMarker"):Clone()
		if position then
			localPlayer:PivotTo(CFrame.new(position))
		elseif part then
			position = part.Position
			localPlayer:PivotTo(CFrame.new(position))
			v5:GiveTask(Interval.every(0.5):Connect(function()
				if part and part:IsDescendantOf(workspace) then
					position = part.Position
					localPlayer:PivotTo(CFrame.new(position))
				else
					store:dispatch({
						type = "removeWaypointByName",
						name = p1.name
					})
				end
			end))
		end
		localPlayer.Parent = workspace
		v5:GiveTask(RunService.Heartbeat:Connect(function()
			localPlayer.Arrow.CFrame = localPlayer.ArrowRoot.CFrame * CFrame.Angles(0, os.clock() % 6.283185307179586, 0)
		end))
		v5:GiveTask(localPlayer)
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = localPlayer.PrimaryPart
		local v2 = ReplicatedStorage.App.Res:FindFirstChild("SlowArrowBeam"):Clone()
		v2.Attachment0 = Attachment
		v2.Parent = localPlayer
		v5:GiveTask(v2)
		local v3 = WorldMarker.new()
		v3:SetScreenGui(WorldMarkerSystem.gui)
		if position then
			v3:SetPosition(position)
		elseif part then
			v3:SetAdornee(part)
		end
		v3:SetIcon(5920742944)
		v3.FrameInner.ImageColor3 = Color3.fromRGB(255, 108, 98)
		v6:Add(v3)
		v5:GiveTask(function()
			v6:Remove(v3)
			v3:Destroy()
		end)
		store:dispatch({
			type = "addMinimapLabel",
			title = p1.name .. "_",
			imageId = 5920742944,
			position = v3:GetPosition(),
			markerColor = v3.FrameInner.ImageColor3,
			scale = 1.5
		})
		v3._maid:GiveTask(function()
			store:dispatch({
				type = "removeMinimapLabel",
				title = p1.name .. "_"
			})
		end)
		local function update()
			local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if localPlayer then
				v2.Attachment1 = localPlayer:FindFirstChildOfClass("Attachment")
				if ((localPlayer.PrimaryPart.Position - localPlayer.Position) * Vector3.new(1, 0, 1)).Magnitude < minDist then
					store:dispatch({
						type = "removeWaypointByName",
						name = p1.name
					})
				end
			end
		end
		update()
		v5:GiveTask(Interval.every(1):Connect(update))
		if p1.message then
			local function getComponent()
				local localPlayer = EzUtils.isSmallScreen()
				local configTable = {
					ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
					ResetOnSpawn = false,
					IgnoreGuiInset = true
				}
				local configTable = {}
				local configTable = {
					LayoutOrder = 1,
					BackgroundTransparency = 1
				}
				configTable.Size = UDim2.fromScale(0.6, if localPlayer then 0.07500000000000001 else 0.045)
				configTable.AnchorPoint = Vector2.new(0.5, 1)
				configTable.Position = UDim2.fromScale(0.5, 0.75)
				configTable.Message = createElement("Frame", configTable, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Font = Enum.Font.FredokaOne,
						Text = p1.message,
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
				return createElement("ScreenGui", configTable, configTable)
			end
			local localPlayer = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "WaypointGui")
			v5:GiveTask(function()
				Roact.unmount(localPlayer)
			end)
		end
	end
end
store.changed:connect(function(p1, p2)
	if p1.minimapWaypoints == p2.minimapWaypoints then
		if p1.otherTradeServerListConfig ~= p2.otherTradeServerListConfig then
			if p1.otherTradeServerListConfig.visible then
				ChatUtils.setEnabled(false)
				return
			end
			ChatUtils.setEnabled(true)
		end
	else
		local minimapWaypoints = p1.minimapWaypoints
		setWaypoint(minimapWaypoints[#minimapWaypoints])
	end
end)
if RunUtils.isTradeWorld() then
	require(ReplicatedStorage.App.TradeWorldApp).init()
end
