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
Maid.new():GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 28 | Upvalues: CharacterUtils (copy), Players (copy), MinimapService (copy) ]]
	local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	if v1 then
		MinimapService.mapUpdateWorldPosition(v1.Position)
		MinimapService.mapUpdateWorldDirection(v1.CFrame.LookVector)
	end
end))
require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadService)
local function getColorFromTeam(p1) --[[ Line: 38 | Upvalues: Settings (copy) ]]
	if p1 == Settings.Team.Police then
		return Settings.TeamColor[Settings.EnumTeam.Police]
	else
		return Settings.TeamColor[Settings.EnumTeam.Criminal]
	end
end
CharacterUtils.observeLocalCharacterAdded(function(p1, p2) --[[ Line: 46 | Upvalues: HapticEffect (copy) ]]
	local Humanoid = p1:FindFirstChild("Humanoid")
	local Health = Humanoid.Health
	p2:GiveTask(Humanoid:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 49 | Upvalues: Humanoid (copy), HapticEffect (ref), Health (ref) ]]
		if Humanoid.Health <= 0 then
			HapticEffect.basic(1, 1)
		elseif Humanoid.Health < Health then
			HapticEffect.basic(1, 0.2)
		end
		Health = Humanoid.Health
	end))
end)
CharacterUtils.observeCharacterAdded(function(p1, p2) --[[ Line: 59 | Upvalues: Players (copy), RxInstanceUtils (copy), Promise (copy), Roact (copy), Settings (copy), MinimapService (copy), Interval (copy), HumanoidUnloadConsts (copy) ]]
	local Humanoid = p1:FindFirstChild("Humanoid")
	assert(Humanoid)
	local v1 = Players:GetPlayerFromCharacter(p1)
	if v1 ~= Players.LocalPlayer then
		local t = {
			name = v1.Name,
			flash = false
		}
		p2:GivePromise(Promise.all({ RxInstanceUtils.waitForChild(v1, "TeamValue", 5), RxInstanceUtils.waitForChild(Players.LocalPlayer, "TeamValue", 5) }):andThen(function(p1) --[[ Line: 77 | Upvalues: t (copy), Roact (ref), Settings (ref), Players (ref), p2 (copy), MinimapService (ref) ]]
			local v1 = p1[1]
			local v2 = p1[2]
			local v6, v7 = Roact.createBinding(if v1.Value == Settings.Team.Police then Settings.TeamColor[Settings.EnumTeam.Police] else Settings.TeamColor[Settings.EnumTeam.Criminal])
			t.color = v6
			t.updateColor = v7
			local function updateFlash() --[[ Line: 83 | Upvalues: t (ref), v2 (copy), v1 (copy), Players (ref) ]]
				t.flash = if v2.Value == v1.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end
			p2:GiveTask(v1.Changed:Connect(function(p1) --[[ Line: 87 | Upvalues: t (ref), Settings (ref), v2 (copy), v1 (copy), Players (ref) ]]
				t.updateColor(if p1 == Settings.Team.Police then Settings.TeamColor[Settings.EnumTeam.Police] else Settings.TeamColor[Settings.EnumTeam.Criminal])
				t.flash = if v2.Value == v1.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			p2:GiveTask(v2.Changed:Connect(function() --[[ Line: 91 | Upvalues: t (ref), v2 (copy), v1 (copy), Players (ref) ]]
				t.flash = if v2.Value == v1.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			p2:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers"):Connect(function() --[[ Line: 94 | Upvalues: t (ref), v2 (copy), v1 (copy), Players (ref) ]]
				t.flash = if v2.Value == v1.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			end))
			t.flash = if v2.Value == v1.Value then Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true else true
			p2:GiveTask(MinimapService.add(t))
		end))
		p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "HumanoidRootPart", function(p1, p2) --[[ Line: 102 | Upvalues: t (copy) ]]
			t.part = p1
			p2:GiveTask(function() --[[ Line: 104 | Upvalues: t (ref) ]]
				t.part = nil
			end)
		end))
		p2:GiveTask(Interval.every(0.1):Connect(function() --[[ Line: 108 | Upvalues: Humanoid (copy), HumanoidUnloadConsts (ref), t (copy) ]]
			local v1 = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
			if t._position and (not t.part and v1) then
				t._updatePosition((t._position:getValue():Lerp(v1.Value, 0.3333333333333333)))
			end
		end))
	end
end)
local store = require(ReplicatedStorage.App.store)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local t = {
	type = "setPremium"
}
t.premium = GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage) or PrivateServerUtils.getIsBattleServer()
store:dispatch(t)
GamepassSystem.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.PremiumGarage):Connect(function() --[[ Line: 130 | Upvalues: store (copy) ]]
	store:dispatch({
		type = "setPremium",
		premium = true
	})
end)
for v2, v3 in GamepassUtils.EnumGamepass:GetEnumItems() do
	local v4 = GamepassUtils.EnumGamepass[v3]
	store:dispatch({
		type = "setGamepassOwned",
		gamepassEnum = v4,
		gamepassOwned = GamepassSystem.DoesPlayerOwn(v4)
	})
	GamepassSystem.GetGamepassOwnedSignal(v4):Connect(function() --[[ Line: 144 | Upvalues: store (copy), v4 (copy), GamepassSystem (copy) ]]
		store:dispatch({
			type = "setGamepassOwned",
			gamepassEnum = v4,
			gamepassOwned = GamepassSystem.DoesPlayerOwn(v4)
		})
	end)
end
local v5 = Maid.new()
local v6 = WorldMarkerGroup.new()
WorldMarkerSystem.addGroup(v6)
local function setWaypoint(p1) --[[ Line: 162 | Upvalues: v5 (copy), ReplicatedStorage (copy), Interval (copy), store (copy), RunService (copy), WorldMarker (copy), WorldMarkerSystem (copy), v6 (copy), CharacterUtils (copy), Players (copy), EzUtils (copy), createElement (copy), Roact (copy) ]]
	v5:DoCleaning()
	if p1 then
		local position = p1.position
		local part = p1.part
		local minDist = p1.minDist
		local v1 = ReplicatedStorage.App.Res:FindFirstChild("WaypointMarker"):Clone()
		if position then
			v1:PivotTo(CFrame.new(position))
		elseif part then
			position = part.Position
			v1:PivotTo(CFrame.new(position))
			v5:GiveTask(Interval.every(0.5):Connect(function() --[[ Line: 176 | Upvalues: part (copy), position (ref), v1 (ref), store (ref), p1 (copy) ]]
				if part and part:IsDescendantOf(workspace) then
					position = part.Position
					v1:PivotTo(CFrame.new(position))
				else
					store:dispatch({
						type = "removeWaypointByName",
						name = p1.name
					})
				end
			end))
		end
		v1.Parent = workspace
		v5:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 189 | Upvalues: v1 (ref) ]]
			v1.Arrow.CFrame = v1.ArrowRoot.CFrame * CFrame.Angles(0, os.clock() % 6.283185307179586, 0)
		end))
		v5:GiveTask(v1)
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = v1.PrimaryPart
		local v2 = ReplicatedStorage.App.Res:FindFirstChild("SlowArrowBeam"):Clone()
		v2.Attachment0 = Attachment
		v2.Parent = v1
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
		v5:GiveTask(function() --[[ Line: 216 | Upvalues: v6 (ref), v3 (copy) ]]
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
		v3._maid:GiveTask(function() --[[ Line: 229 | Upvalues: store (ref), p1 (copy) ]]
			store:dispatch({
				type = "removeMinimapLabel",
				title = p1.name .. "_"
			})
		end)
		local function update() --[[ Line: 237 | Upvalues: CharacterUtils (ref), Players (ref), v2 (ref), v1 (ref), minDist (copy), store (ref), p1 (copy) ]]
			local v12 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if v12 then
				v2.Attachment1 = v12:FindFirstChildOfClass("Attachment")
				if ((v1.PrimaryPart.Position - v12.Position) * Vector3.new(1, 0, 1)).Magnitude < minDist then
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
			local function getComponent() --[[ Line: 255 | Upvalues: EzUtils (ref), createElement (ref), p1 (copy) ]]
				local v1 = EzUtils.isSmallScreen()
				local t = {
					ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
					ResetOnSpawn = false,
					IgnoreGuiInset = true
				}
				local t2 = {}
				local t3 = {
					LayoutOrder = 1,
					BackgroundTransparency = 1
				}
				t3.Size = UDim2.fromScale(0.6, if v1 then 0.07500000000000001 else 0.045)
				t3.AnchorPoint = Vector2.new(0.5, 1)
				t3.Position = UDim2.fromScale(0.5, 0.75)
				t2.Message = createElement("Frame", t3, {
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
				return createElement("ScreenGui", t, t2)
			end
			local v4 = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "WaypointGui")
			v5:GiveTask(function() --[[ Line: 334 | Upvalues: Roact (ref), v4 (copy) ]]
				Roact.unmount(v4)
			end)
		end
	end
end
store.changed:connect(function(p1, p2) --[[ Line: 340 | Upvalues: setWaypoint (copy), ChatUtils (copy) ]]
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