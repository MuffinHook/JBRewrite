-- Reviewed by Claude
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
local t = {}
local t2 = {
	[RobberyConsts.ENUM_ROBBERY.MONEY_TRUCK] = Settings.EnumTeam.Police
}
local t3 = {
	[RobberyConsts.ENUM_ROBBERY.MONEY_TRUCK] = true
}
t._enabled = true
function t.init()
	local v1 = os.clock()
	local t4 = {}
	local t5 = {}
	for i, v in ipairs(RobberyConsts.LIST_ROBBERY) do
		local v2 = RobberyConsts.ENUM_ROBBERY[v]
		local v3 = RobberyConsts.DATA_ROBBERY[v2]
		if v3.markerName then
			local t6 = {
				RobberyId = v2
			}
			t6.Name = assert(v3.markerName, "missing markerName")
			t6.ImageId = assert(v3.imageId, "missing imageId")
			t6._stateId = RobberyConsts.ENUM_STATUS.CLOSED
			t6._stateIncr = 0
			t4[t6.Name] = t6
			t5[t6.RobberyId] = t6
		end
	end
	local v4 = WorldMarkerGroup.new()
	local function setRobberyMarkerState(p1, p2)
		local v12 = t5[p1]
		if v12 then
			local v2 = v12._stateIncr + 1
			v12._stateIncr = v2
			local _listWorldMarker = v12._listWorldMarker
			if _listWorldMarker then
				for k, v in pairs(_listWorldMarker) do
					if v._maid.robberyMarkerFx ~= nil then
						v._maid.robberyMarkerFx = nil
						v.Frame.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
					end
				end
				local minimapLabels = store:getState().minimapLabels
				local v3 = nil
				for i, v in ipairs(minimapLabels) do
					if v.title == v12.Name then
						v3 = v
						break
					end
				end
				local _enabled = t._enabled
				local v4 = t2[p1]
				if v4 and (PlayerUtils.getTeamId(Players.LocalPlayer) ~= v4 and p2 == RobberyConsts.ENUM_STATUS.OPENED) then
					v4 = false
					_enabled = false
				end
				local v5 = false
				if p2 == RobberyConsts.ENUM_STATUS.OPENED then
					local function func()
						if v12._stateIncr == v2 then
							v5 = true
							for v1, v22 in _listWorldMarker do
								v22:SetEnabled(_enabled)
								v22.FrameInner.ImageColor3 = Color3.new(0/255, 255/255, 0/255)
							end
							if v3 then
								v3.updateMarkerColor(Color3.new(0/255, 255/255, 0/255))
							end
						end
					end
					if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.BOSS) or (os.clock() - v1 < 66 or t3[p1]) then
						func()
					else
						Promise.delay(RobberyConsts.NON_BOSS_DELAY):andThen(func)
					end
				elseif p2 == RobberyConsts.ENUM_STATUS.CLOSED then
					for v6, v7 in _listWorldMarker do
						v7:SetEnabled(false)
						v7.FrameInner.ImageColor3 = Color3.new(255/255, 0/255, 0/255)
					end
					if v3 then
						v3.updateMarkerColor(Color3.new(255/255, 0/255, 0/255))
					end
				elseif p2 == RobberyConsts.ENUM_STATUS.STARTED then
					local function func()
						if v12._stateIncr == v2 then
							v5 = true
							for i, v in ipairs(_listWorldMarker) do
								v:SetEnabled(_enabled)
								v.FrameInner.ImageColor3 = Color3.new(0/255, 255/255, 0/255)
								if v3 then
									v3.updateMarkerColor(Color3.new(0/255, 255/255, 0/255))
								end
								v._maid.robberyMarkerFx = RunService.Heartbeat:Connect(function()
									local v2 = math.cos(os.clock() * 3) * 0.5 + 0.5
									v.Frame.ImageColor3 = Color3.new(0, v2, 0)
									v.FrameInner.ImageColor3 = Color3.new(v2, 1, v2)
									if v3 then
										v3.updateMarkerColor(Color3.new(v2, 1, v2))
									end
								end)
							end
						end
					end
					if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.BOSS) or (os.clock() - v1 < 66 or t3[p1]) then
						func()
					else
						Promise.delay(RobberyConsts.NON_BOSS_DELAY):andThen(func)
					end
				end
				return v5 and v4 ~= false
			end
		end
	end
	local function addRobberyMarker(p1)
		local v1 = t4[p1.Name]
		if not v1 then
			error(("Missing robbery marker entry for: %s"):format(p1.Name))
		end
		local ImageId = v1.ImageId
		assert(ImageId)
		local v2 = WorldMarker.new()
		v2:SetScreenGui(WorldMarkerSystem.gui)
		v2:SetAdornee(p1)
		v2:SetIcon(ImageId, Color3.fromRGB(0, 0, 0))
		v2.FrameInner.ImageColor3 = Color3.new(255/255, 0/255, 0/255)
		if v1._listWorldMarker then
			table.insert(v1._listWorldMarker, v2)
		else
			v1._listWorldMarker = { v2 }
		end
		v4:Add(v2)
		local v3, v42 = Roact.createBinding(v2:GetPosition())
		local v5, v6 = Roact.createBinding(Color3.new(255/255, 0/255, 0/255))
		store:dispatch({
			type = "addMinimapLabel",
			title = p1.Name,
			imageId = ImageId,
			position = v3,
			updatePosition = v42,
			markerColor = v5,
			updateMarkerColor = v6
		})
		v2._maid:GiveTask(function()
			store:dispatch({
				type = "removeMinimapLabel",
				title = p1.Name
			})
		end)
		v2._maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
			v42(p1.Position)
		end))
		local v7 = ReplicatedStorage:FindFirstChild(ROBBERY_STATE_FOLDER_NAME)
		local v8 = false
		if v7 then
			local v9 = v7:FindFirstChild(v1.RobberyId)
			if v9 and setRobberyMarkerState(tonumber(v9.Name), v9.Value) == true then
				v8 = true
			end
		end
		if not v8 then
			v2:SetEnabled(false)
		end
	end
	for i, v in ipairs(CollectionService:GetTagged("RobberyMarker")) do
		addRobberyMarker(v)
	end
	CollectionService:GetInstanceAddedSignal("RobberyMarker"):Connect(addRobberyMarker)
	local function cleanupAfterRobberyMarker(p1)
		local v1 = t4[p1.Name]
		for i = #v1._listWorldMarker, 1, -1 do
			local v2 = v1._listWorldMarker[i]
			if v2:GetAdornee() == p1 then
				v4:Remove(v2)
				v2:Destroy()
				table.remove(v1._listWorldMarker, i)
				if #v1._listWorldMarker == 0 then
					v1._listWorldMarker = nil
				end
			end
		end
	end
	CollectionService:GetInstanceRemovedSignal("RobberyMarker"):Connect(cleanupAfterRobberyMarker)
	WorldMarkerSystem.addGroup(v4)
	RxInstanceUtils.waitForChild(ReplicatedStorage, ROBBERY_STATE_FOLDER_NAME):andThen(function(p1)
		RxInstanceUtils.observeChildren(p1, function(p1, p2)
			local v2 = tonumber(p1.Name)
			assert(v2)
			local function update(p1)
				assert(p1)
				assert(typeof(p1) == "number")
				setRobberyMarkerState(v2, p1)
			end
			p2:GiveTask(p1.Changed:Connect(update))
			local v3 = p1.Value
			assert(v3)
			assert(typeof(v3) == "number")
			setRobberyMarkerState(v2, v3)
		end)
	end)
	local function updateAllRobberyStatus()
		local v1 = ReplicatedStorage:FindFirstChild(ROBBERY_STATE_FOLDER_NAME)
		if v1 then
			for v2, v3 in v1:GetChildren() do
				local v5 = tonumber(v3.Name)
				assert(v5)
				setRobberyMarkerState(v5, v3.Value)
			end
		end
	end
	local t6 = {
		name = "robberyMarkers",
		title = "Robbery Markers",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 41
	}
	GameSettingsService.add(t6)
	local function handleSetting(p1)
		t._enabled = p1
		updateAllRobberyStatus()
	end
	t._enabled = t6:getValue()
	updateAllRobberyStatus()
	t6.onChanged:Connect(handleSetting)
	GameUtil.OnTeamChanged:Connect(updateAllRobberyStatus)
end
return t
