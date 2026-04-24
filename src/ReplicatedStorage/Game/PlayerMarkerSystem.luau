-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorldMarker = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
local WorldMarkerGroup = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local WorldMarkerSystem = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Players = game:GetService("Players")
local FriendsService = require(ReplicatedStorage.Friends.FriendsService)
local HumanoidUnloadConsts = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
local t = {
	4,
	{ 24, 0 },
	{ (1 / 0), 8 }
}
local v1 = Enumer({ "Police", "Criminal", "Friend", "Spotted" })
local t2 = {
	[v1.Police] = Color3.fromRGB(84, 215, 253),
	[v1.Criminal] = Color3.fromRGB(253, 148, 81),
	[v1.Friend] = Color3.fromRGB(240, 240, 240),
	[v1.Spotted] = Color3.fromRGB(220, 220, 10)
}
local t3 = {
	_mapPlayerIdPlayerMarker = {},
	_playerMarkerGroup = nil,
	_setting = nil
}
function t3.init()
	local v1 = WorldMarkerGroup.new()
	WorldMarkerSystem.addGroup(v1)
	t3._playerMarkerGroup = v1
	RxInstanceUtils.observeChildren(Players, t3._rxChildAdded)
	RunService.Heartbeat:Connect(t3._draw)
	local t = {
		name = "playerMarkers",
		title = "Player Markers",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 42
	}
	t3._setting = t
	GameSettingsService.add(t)
	t3.updateEnabled()
	t.onChanged:Connect(t3.updateEnabled)
	Players.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers"):Connect(t3.updateEnabled)
end
function t3.updateEnabled()
	local v1 = t3._setting:getValue()
	t3._playerMarkerGroup:SetEnabled(v1 and Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") ~= true)
end
function t3._draw()
	debug.profilebegin("PlayerMarker draw")
	for k, v in pairs(t3._mapPlayerIdPlayerMarker) do
		local _player = v._player
		if _player then
			local Character = _player.Character
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				local PrimaryPart = Character.PrimaryPart
				local _worldMarker = v._worldMarker
				if PrimaryPart then
					_worldMarker:SetPosition(PrimaryPart.Position)
				elseif Humanoid then
					local v1 = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
					if v1 then
						local v2 = v1.Value
						_worldMarker:SetPosition(((v._worldMarker:GetPosition() or v2):Lerp(v2, 0.3333333333333333)))
					end
				end
			end
		end
	end
	debug.profileend()
end
function t3._rxChildAdded(p1, p2)
	assert(p1:IsA("Player"))
	if p1 ~= Players.LocalPlayer then
		p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "TeamValue", function(p12, p2)
			local function update()
				local v12 = if GameUtil.Team == Settings.EnumTeam.Police then Settings.EnumTeam.Police else Settings.EnumTeam.Criminal
				local v2 = if p12.Value == Settings.Team.Police then Settings.EnumTeam.Police else Settings.EnumTeam.Criminal
				local v3 = if v2 == v12 then if v2 == Settings.EnumTeam.Police then v1.Police else v1.Criminal else nil
				if FriendsService.getIsFriendsWith(Players.LocalPlayer, p1.UserId, true) and v2 == v12 then
					v3 = v1.Friend
				end
				if p1:GetAttribute("CCTVSpotted") == true then
					v3 = v1.Spotted
				end
				if v3 then
					if not t3._doesMarkerExist(p1) then
						t3._constructMarker(p1)
					end
					t3._setColor(p1, t2[v3])
				elseif t3._doesMarkerExist(p1) then
					t3._destructMarker(p1)
				end
			end
			update()
			p2._listenTeamChange = p12.Changed:Connect(update)
			p2._listenMyTeamChange = GameUtil.OnTeamChanged:Connect(update)
			p2._listenMyFriendsChange = FriendsService.friendsUpdated:Connect(update)
			p2:GiveTask(p1:GetAttributeChangedSignal("CCTVSpotted"):Connect(update))
		end))
		p2:GiveTask(function()
			if t3._doesMarkerExist(p1) then
				t3._destructMarker(p1)
			end
		end)
	end
end
function t3._doesMarkerExist(p1)
	return t3._mapPlayerIdPlayerMarker[p1.UserId] ~= nil
end
function t3._constructMarker(p1)
	assert(p1 ~= nil)
	assert(p1 ~= Players.LocalPlayer)
	if t3._mapPlayerIdPlayerMarker[p1.UserId] then
		error(("Player marker already exists for: %s"):format(p1.Name))
	end
	local v2 = WorldMarker.new()
	v2:SetScreenGui(WorldMarkerSystem.gui)
	v2:SetSizes(t)
	v2:SetIcon(7028057307)
	t3._playerMarkerGroup:Add(v2)
	t3._mapPlayerIdPlayerMarker[p1.UserId] = {
		_worldMarker = v2,
		_player = p1
	}
end
function t3._setColor(p1, p2)
	t3._mapPlayerIdPlayerMarker[p1.UserId]._worldMarker.FrameInner.ImageColor3 = p2
end
function t3._destructMarker(p1)
	assert(p1 ~= nil)
	local v2 = t3._mapPlayerIdPlayerMarker[p1.UserId]
	if v2 then
		t3._mapPlayerIdPlayerMarker[p1.UserId] = nil
		t3._playerMarkerGroup:Remove(v2._worldMarker)
		v2._worldMarker:Destroy()
		v2._worldMarker = nil
		v2._player = nil
	else
		error(("Player marker does not exist for: %s"):format(p1.Name))
	end
end
return t3
