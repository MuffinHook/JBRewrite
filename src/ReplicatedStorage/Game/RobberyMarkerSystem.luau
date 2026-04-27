local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local GameUtil = require(script.Parent.GameUtil)
local PlayerUtils = require(script.Parent.PlayerUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Promise = require(ReplicatedStorage.Std.Promise)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local WorldMarkerGroup = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local WorldMarkerSystem = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local WorldMarker = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local store = require(ReplicatedStorage.App.store)
local Settings = require(ReplicatedStorage.Resource.Settings)
local ROBBERY_STATE_FOLDER_NAME = RobberyConsts.ROBBERY_STATE_FOLDER_NAME
local robberyMarkerSystem = {}
local robberyTeamMap = {
	[RobberyConsts.ENUM_ROBBERY.MONEY_TRUCK] = Settings.EnumTeam.Police
}
local instantShowRobberyMap = {
	[RobberyConsts.ENUM_ROBBERY.MONEY_TRUCK] = true
}
robberyMarkerSystem._enabled = true
function robberyMarkerSystem.init()
	local initStartTime = os.clock()
	local markerConfigByName = {}
	local markerConfigById = {}
	for i, v in ipairs(RobberyConsts.LIST_ROBBERY) do
		local robberyEnumId = RobberyConsts.ENUM_ROBBERY[v]
		local robberyData = RobberyConsts.DATA_ROBBERY[robberyEnumId]
		if robberyData.markerName then
			local markerConfig = {
				RobberyId = robberyEnumId
			}
			markerConfig.Name = assert(robberyData.markerName, "missing markerName")
			markerConfig.ImageId = assert(robberyData.imageId, "missing imageId")
			markerConfig._stateId = RobberyConsts.ENUM_STATUS.CLOSED
			markerConfig._stateIncr = 0
			markerConfigByName[markerConfig.Name] = markerConfig
			markerConfigById[markerConfig.RobberyId] = markerConfig
		end
	end
	local markerGroup = WorldMarkerGroup.new()
	local function setRobberyMarkerState(robberyId, newStatus)
		local markerConfigInfo = markerConfigById[robberyId]
		if markerConfigInfo then
			local nextStateIncr = markerConfigInfo._stateIncr + 1
			markerConfigInfo._stateIncr = nextStateIncr
			local _listWorldMarker = markerConfigInfo._listWorldMarker
			if _listWorldMarker then
				for k, v in pairs(_listWorldMarker) do
					if v._maid.robberyMarkerFx ~= nil then
						v._maid.robberyMarkerFx = nil
						v.Frame.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
					end
				end
				local minimapLabels = store:getState().minimapLabels
				local matchingMinimapLabel = nil
				for i, v in ipairs(minimapLabels) do
					if v.title == markerConfigInfo.Name then
						matchingMinimapLabel = v
						break
					end
				end
				local _enabled = robberyMarkerSystem._enabled
				local requiredTeam = robberyTeamMap[robberyId]
				if requiredTeam and (PlayerUtils.getTeamId(Players.LocalPlayer) ~= requiredTeam and newStatus == RobberyConsts.ENUM_STATUS.OPENED) then
					requiredTeam = false
					_enabled = false
				end
				local didUpdateMarker = false
				if newStatus == RobberyConsts.ENUM_STATUS.OPENED then
					local function func()
						if markerConfigInfo._stateIncr == nextStateIncr then
							didUpdateMarker = true
							for v1, worldMarker in _listWorldMarker do
								worldMarker:SetEnabled(_enabled)
								worldMarker.FrameInner.ImageColor3 = Color3.new(0/255, 255/255, 0/255)
							end
							if matchingMinimapLabel then
								matchingMinimapLabel.updateMarkerColor(Color3.new(0/255, 255/255, 0/255))
							end
						end
					end
					if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.BOSS) or (os.clock() - initStartTime < 66 or instantShowRobberyMap[robberyId]) then
						func()
					else
						Promise.delay(RobberyConsts.NON_BOSS_DELAY):andThen(func)
					end
				elseif newStatus == RobberyConsts.ENUM_STATUS.CLOSED then
					for v6, worldMarkerItem in _listWorldMarker do
						worldMarkerItem:SetEnabled(false)
						worldMarkerItem.FrameInner.ImageColor3 = Color3.new(255/255, 0/255, 0/255)
					end
					if matchingMinimapLabel then
						matchingMinimapLabel.updateMarkerColor(Color3.new(255/255, 0/255, 0/255))
					end
				elseif newStatus == RobberyConsts.ENUM_STATUS.STARTED then
					local function func()
						if markerConfigInfo._stateIncr == nextStateIncr then
							didUpdateMarker = true
							for i, v in ipairs(_listWorldMarker) do
								v:SetEnabled(_enabled)
								v.FrameInner.ImageColor3 = Color3.new(0/255, 255/255, 0/255)
								if matchingMinimapLabel then
									matchingMinimapLabel.updateMarkerColor(Color3.new(0/255, 255/255, 0/255))
								end
								v._maid.robberyMarkerFx = RunService.Heartbeat:Connect(function()
									local colorValue = math.cos(os.clock() * 3) * 0.5 + 0.5
									v.Frame.ImageColor3 = Color3.new(0, colorValue, 0)
									v.FrameInner.ImageColor3 = Color3.new(colorValue, 1, colorValue)
									if matchingMinimapLabel then
										matchingMinimapLabel.updateMarkerColor(Color3.new(colorValue, 1, colorValue))
									end
								end)
							end
						end
					end
					if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.BOSS) or (os.clock() - initStartTime < 66 or instantShowRobberyMap[robberyId]) then
						func()
					else
						Promise.delay(RobberyConsts.NON_BOSS_DELAY):andThen(func)
					end
				end
				return didUpdateMarker and requiredTeam ~= false
			end
		end
	end
	local function addRobberyMarker(robberyMarkerInstance)
		local markerInfo = markerConfigByName[robberyMarkerInstance.Name]
		if not markerInfo then
			error(("Missing robbery marker entry for: %s"):format(robberyMarkerInstance.Name))
		end
		local ImageId = markerInfo.ImageId
		assert(ImageId)
		local newWorldMarker = WorldMarker.new()
		newWorldMarker:SetScreenGui(WorldMarkerSystem.gui)
		newWorldMarker:SetAdornee(robberyMarkerInstance)
		newWorldMarker:SetIcon(ImageId, Color3.fromRGB(0, 0, 0))
		newWorldMarker.FrameInner.ImageColor3 = Color3.new(255/255, 0/255, 0/255)
		if markerInfo._listWorldMarker then
			table.insert(markerInfo._listWorldMarker, newWorldMarker)
		else
			markerInfo._listWorldMarker = { newWorldMarker }
		end
		markerGroup:Add(newWorldMarker)
		local positionBinding, updatePosition = Roact.createBinding(newWorldMarker:GetPosition())
		local colorBinding, updateMarkerColor = Roact.createBinding(Color3.new(255/255, 0/255, 0/255))
		store:dispatch({
			type = "addMinimapLabel",
			title = robberyMarkerInstance.Name,
			imageId = ImageId,
			position = positionBinding,
			updatePosition = updatePosition,
			markerColor = colorBinding,
			updateMarkerColor = updateMarkerColor
		})
		newWorldMarker._maid:GiveTask(function()
			store:dispatch({
				type = "removeMinimapLabel",
				title = robberyMarkerInstance.Name
			})
		end)
		newWorldMarker._maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
			updatePosition(robberyMarkerInstance.Position)
		end))
		local stateFolder = ReplicatedStorage:FindFirstChild(ROBBERY_STATE_FOLDER_NAME)
		local markerHasValidState = false
		if stateFolder then
			local robberyStateObject = stateFolder:FindFirstChild(markerInfo.RobberyId)
			if robberyStateObject and setRobberyMarkerState(tonumber(robberyStateObject.Name), robberyStateObject.Value) == true then
				markerHasValidState = true
			end
		end
		if not markerHasValidState then
			newWorldMarker:SetEnabled(false)
		end
	end
	for i, v in ipairs(CollectionService:GetTagged("RobberyMarker")) do
		addRobberyMarker(v)
	end
	CollectionService:GetInstanceAddedSignal("RobberyMarker"):Connect(addRobberyMarker)
	local function cleanupAfterRobberyMarker(robberyMarkerInstance)
		local markerConfigInfo = markerConfigByName[robberyMarkerInstance.Name]
		for i = #markerConfigInfo._listWorldMarker, 1, -1 do
			local worldMarkerToRemove = markerConfigInfo._listWorldMarker[i]
			if worldMarkerToRemove:GetAdornee() == robberyMarkerInstance then
				markerGroup:Remove(worldMarkerToRemove)
				worldMarkerToRemove:Destroy()
				table.remove(markerConfigInfo._listWorldMarker, i)
				if #markerConfigInfo._listWorldMarker == 0 then
					markerConfigInfo._listWorldMarker = nil
				end
			end
		end
	end
	CollectionService:GetInstanceRemovedSignal("RobberyMarker"):Connect(cleanupAfterRobberyMarker)
	WorldMarkerSystem.addGroup(markerGroup)
	RxInstanceUtils.waitForChild(ReplicatedStorage, ROBBERY_STATE_FOLDER_NAME):andThen(function(stateFolderWaitResult)
		RxInstanceUtils.observeChildren(stateFolderWaitResult, function(stateObject, maid)
			local robberyIdFromState = tonumber(stateObject.Name)
			assert(robberyIdFromState)
			local function update(newStatus)
				assert(newStatus)
				assert(typeof(newStatus) == "number")
				setRobberyMarkerState(robberyIdFromState, newStatus)
			end
			maid:GiveTask(stateObject.Changed:Connect(update))
			local currentStatus = stateObject.Value
			assert(currentStatus)
			assert(typeof(currentStatus) == "number")
			setRobberyMarkerState(robberyIdFromState, currentStatus)
		end)
	end)
	local function updateAllRobberyStatus()
		local stateFolder = ReplicatedStorage:FindFirstChild(ROBBERY_STATE_FOLDER_NAME)
		if stateFolder then
			for v2, robberyStateChild in stateFolder:GetChildren() do
				local robberyId = tonumber(robberyStateChild.Name)
				assert(robberyId)
				setRobberyMarkerState(robberyId, robberyStateChild.Value)
			end
		end
	end
	local robberyMarkersSetting = {
		name = "robberyMarkers",
		title = "Robbery Markers",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 41
	}
	GameSettingsService.add(robberyMarkersSetting)
	local function handleSetting(settingValue)
		robberyMarkerSystem._enabled = settingValue
		updateAllRobberyStatus()
	end
	robberyMarkerSystem._enabled = robberyMarkersSetting:getValue()
	updateAllRobberyStatus()
	robberyMarkersSetting.onChanged:Connect(handleSetting)
	GameUtil.OnTeamChanged:Connect(updateAllRobberyStatus)
end
return robberyMarkerSystem
