local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local WorldMarker = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
local WorldMarkerGroup = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local WorldMarkerSystem = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local Roact = require(ReplicatedStorage.Roact)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Interval = require(ReplicatedStorage.Std.Interval)
local String = require(ReplicatedStorage.Std.String)
return {
	init = function() --[[ Name: init | Line: 16 | Upvalues: WorldMarkerGroup (copy), WorldMarkerSystem (copy), BaseObject (copy), String (copy), WorldMarker (copy), Roact (copy), store (copy), Interval (copy), Binder (copy), gameSettingType (copy), GameSettingsService (copy) ]]
		local v1 = true
		local t = {
			Gun = {
				ImageId = 15632538723,
				Color = Color3.fromRGB(141, 81, 255)
			},
			Garage = {
				ImageId = 117787277684275,
				Color = Color3.fromRGB(217, 66, 120)
			}
		}
		local v2 = WorldMarkerGroup.new()
		WorldMarkerSystem.addGroup(v2)
		local t2 = {}
		t2.__index = t2
		setmetatable(t2, BaseObject)
		function t2.new(p1) --[[ Line: 30 | Upvalues: BaseObject (ref), t2 (copy), t (copy), String (ref), WorldMarker (ref), WorldMarkerSystem (ref), v2 (copy), Roact (ref), store (ref), Interval (ref), v1 (ref) ]]
			local v12 = BaseObject.new(p1)
			setmetatable(v12, t2)
			local v3 = t[p1.Name]
			if not v3 then
				error(("Missing important location marker entry for: %s"):format(p1.Name))
			end
			local ImageId = v3.ImageId
			local v4 = p1.Name .. String.base85UUID(10)
			assert(ImageId)
			local v5 = WorldMarker.new()
			v5:SetScreenGui(WorldMarkerSystem.gui)
			v5:SetAdornee(p1)
			v5:SetIcon(ImageId)
			v5.FrameInner.ImageColor3 = v3.Color
			v2:Add(v5)
			v12.maid:GiveTask(function() --[[ Line: 48 | Upvalues: v2 (ref), v5 (copy) ]]
				v2:Remove(v5)
			end)
			v12.worldMarker = v5
			local v6, v7 = Roact.createBinding(v5:GetPosition())
			local v8, v9 = Roact.createBinding(v3.Color)
			store:dispatch({
				type = "addMinimapLabel",
				title = v4,
				imageId = ImageId,
				position = v6,
				updatePosition = v7,
				markerColor = v8,
				updateMarkerColor = v9
			})
			v5._maid:GiveTask(function() --[[ Line: 64 | Upvalues: store (ref), v4 (copy) ]]
				store:dispatch({
					type = "removeMinimapLabel",
					title = v4
				})
			end)
			v5._maid:GiveTask(Interval.every(0.3333333333333333):Connect(function() --[[ Line: 70 | Upvalues: v7 (copy), p1 (copy) ]]
				v7(p1.Position)
			end))
			v5:SetEnabled(v1)
			return v12
		end
		Binder.new("ImportantLocationMarker", t2):Start()
		local function setEnabled() --[[ Line: 81 | Upvalues: v2 (copy), v1 (ref) ]]
			v2:SetEnabled(v1)
		end
		local t3 = {
			name = "locationMarkers",
			title = "Location Markers",
			type = gameSettingType.Checkbox,
			defaultValue = true,
			order = 41
		}
		GameSettingsService.add(t3)
		local function handleSetting(p1) --[[ Line: 93 | Upvalues: v1 (ref), v2 (copy) ]]
			v1 = p1
			v2:SetEnabled(p1)
		end
		v1 = t3:getValue()
		v2:SetEnabled(v1)
		t3.onChanged:Connect(handleSetting)
	end
}