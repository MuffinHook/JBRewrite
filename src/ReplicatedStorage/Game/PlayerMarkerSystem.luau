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
local markerSizes = {
	4,
	{ 24, 0 },
	{ (1 / 0), 8 }
}
local markerStates = Enumer({ "Police", "Criminal", "Friend", "Spotted" })
local stateColors = {
	[markerStates.Police] = Color3.fromRGB(84, 215, 253),
	[markerStates.Criminal] = Color3.fromRGB(253, 148, 81),
	[markerStates.Friend] = Color3.fromRGB(240, 240, 240),
	[markerStates.Spotted] = Color3.fromRGB(220, 220, 10)
}
local PlayerMarkerSystem = {
	_mapPlayerIdPlayerMarker = {},
	_playerMarkerGroup = nil,
	_setting = nil
}
function PlayerMarkerSystem.init()
	local newMarkerGroup = WorldMarkerGroup.new()
	WorldMarkerSystem.addGroup(newMarkerGroup)
	PlayerMarkerSystem._playerMarkerGroup = newMarkerGroup
	RxInstanceUtils.observeChildren(Players, PlayerMarkerSystem._rxChildAdded)
	RunService.Heartbeat:Connect(PlayerMarkerSystem._draw)
	local playerMarkerSetting = {
		name = "playerMarkers",
		title = "Player Markers",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 42
	}
	PlayerMarkerSystem._setting = playerMarkerSetting
	GameSettingsService.add(playerMarkerSetting)
	PlayerMarkerSystem.updateEnabled()
	playerMarkerSetting.onChanged:Connect(PlayerMarkerSystem.updateEnabled)
	Players.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers"):Connect(PlayerMarkerSystem.updateEnabled)
end
function PlayerMarkerSystem.updateEnabled()
	local settingValue = PlayerMarkerSystem._setting:getValue()
	PlayerMarkerSystem._playerMarkerGroup:SetEnabled(settingValue and Players.LocalPlayer:GetAttribute("DisablePlayerMarkers") ~= true)
end
function PlayerMarkerSystem._draw()
	debug.profilebegin("PlayerMarker draw")
	for k, markerRecord in pairs(PlayerMarkerSystem._mapPlayerIdPlayerMarker) do
		local _player = markerRecord._player
		if _player then
			local Character = _player.Character
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				local PrimaryPart = Character.PrimaryPart
				local _worldMarker = markerRecord._worldMarker
				if PrimaryPart then
					_worldMarker:SetPosition(PrimaryPart.Position)
				elseif Humanoid then
					local positionObj = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
					if positionObj then
						local positionValue = positionObj.Value
						_worldMarker:SetPosition(((markerRecord._worldMarker:GetPosition() or positionValue):Lerp(positionValue, 0.3333333333333333)))
					end
				end
			end
		end
	end
	debug.profileend()
end
function PlayerMarkerSystem._rxChildAdded(player, observableTask)
	assert(player:IsA("Player"))
	if player ~= Players.LocalPlayer then
		observableTask:GiveTask(RxInstanceUtils.observeOneChildNamed(player, "TeamValue", function(teamValue, connectionTask)
			local function update()
				local currentPlayerTeam = if GameUtil.Team == Settings.EnumTeam.Police then Settings.EnumTeam.Police else Settings.EnumTeam.Criminal
				local playerTeam = if teamValue.Value == Settings.Team.Police then Settings.EnumTeam.Police else Settings.EnumTeam.Criminal
				local markerState = if playerTeam == currentPlayerTeam then if playerTeam == Settings.EnumTeam.Police then markerStates.Police else markerStates.Criminal else nil
				if FriendsService.getIsFriendsWith(Players.LocalPlayer, player.UserId, true) and playerTeam == currentPlayerTeam then
					markerState = markerStates.Friend
				end
				if player:GetAttribute("CCTVSpotted") == true then
					markerState = markerStates.Spotted
				end
				if markerState then
					if not PlayerMarkerSystem._doesMarkerExist(player) then
						PlayerMarkerSystem._constructMarker(player)
					end
					PlayerMarkerSystem._setColor(player, stateColors[markerState])
				elseif PlayerMarkerSystem._doesMarkerExist(player) then
					PlayerMarkerSystem._destructMarker(player)
				end
			end
			update()
			connectionTask._listenTeamChange = teamValue.Changed:Connect(update)
			connectionTask._listenMyTeamChange = GameUtil.OnTeamChanged:Connect(update)
			connectionTask._listenMyFriendsChange = FriendsService.friendsUpdated:Connect(update)
			connectionTask:GiveTask(player:GetAttributeChangedSignal("CCTVSpotted"):Connect(update))
		end))
		observableTask:GiveTask(function()
			if PlayerMarkerSystem._doesMarkerExist(player) then
				PlayerMarkerSystem._destructMarker(player)
			end
		end)
	end
end
function PlayerMarkerSystem._doesMarkerExist(player)
	return PlayerMarkerSystem._mapPlayerIdPlayerMarker[player.UserId] ~= nil
end
function PlayerMarkerSystem._constructMarker(player)
	assert(player ~= nil)
	assert(player ~= Players.LocalPlayer)
	if PlayerMarkerSystem._mapPlayerIdPlayerMarker[player.UserId] then
		error(("Player marker already exists for: %s"):format(player.Name))
	end
	local newWorldMarker = WorldMarker.new()
	newWorldMarker:SetScreenGui(WorldMarkerSystem.gui)
	newWorldMarker:SetSizes(markerSizes)
	newWorldMarker:SetIcon(7028057307)
	PlayerMarkerSystem._playerMarkerGroup:Add(newWorldMarker)
	PlayerMarkerSystem._mapPlayerIdPlayerMarker[player.UserId] = {
		_worldMarker = newWorldMarker,
		_player = player
	}
end
function PlayerMarkerSystem._setColor(player, color)
	PlayerMarkerSystem._mapPlayerIdPlayerMarker[player.UserId]._worldMarker.FrameInner.ImageColor3 = color
end
function PlayerMarkerSystem._destructMarker(player)
	assert(player ~= nil)
	local markerRecord = PlayerMarkerSystem._mapPlayerIdPlayerMarker[player.UserId]
	if markerRecord then
		PlayerMarkerSystem._mapPlayerIdPlayerMarker[player.UserId] = nil
		PlayerMarkerSystem._playerMarkerGroup:Remove(markerRecord._worldMarker)
		markerRecord._worldMarker:Destroy()
		markerRecord._worldMarker = nil
		markerRecord._player = nil
	else
		error(("Player marker does not exist for: %s"):format(player.Name))
	end
end
return PlayerMarkerSystem
