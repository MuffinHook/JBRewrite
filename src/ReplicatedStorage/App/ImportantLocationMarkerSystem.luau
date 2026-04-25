-- Reviewed by Claude
-- variables reassigned
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
	init = function()
		local isLocationMarkerEnabled = true
		local localTable = {
			Gun = {
				ImageId = 15632538723,
				Color = Color3.fromRGB(141, 81, 255)
			},
			Garage = {
				ImageId = 117787277684275,
				Color = Color3.fromRGB(217, 66, 120)
			}
		}
		local markerGroup = WorldMarkerGroup.new()
		WorldMarkerSystem.addGroup(markerGroup)
		local ImportantLocationMarkerClass = {}
		ImportantLocationMarkerClass.__index = ImportantLocationMarkerClass
		setmetatable(ImportantLocationMarkerClass, BaseObject)
		function ImportantLocationMarkerClass.new(markerInstance)
			local marker = BaseObject.new(markerInstance)
			setmetatable(marker, ImportantLocationMarkerClass)
			local markerConfig = localTable[markerInstance.Name]
			if not markerConfig then
				error(("Missing important location marker entry for: %s"):format(markerInstance.Name))
			end
			local ImageId = markerConfig.ImageId
			local markerId = markerInstance.Name .. String.base85UUID(10)
			assert(ImageId)
			local worldMarker = WorldMarker.new()
			worldMarker:SetScreenGui(WorldMarkerSystem.gui)
			worldMarker:SetAdornee(markerInstance)
			worldMarker:SetIcon(ImageId)
			worldMarker.FrameInner.ImageColor3 = markerConfig.Color
			markerGroup:Add(worldMarker)
			marker.maid:GiveTask(function()
				markerGroup:Remove(worldMarker)
			end)
			marker.worldMarker = worldMarker
			local positionBinding, updatePositionBinding = Roact.createBinding(worldMarker:GetPosition())
			local colorBinding, updateColorBinding = Roact.createBinding(markerConfig.Color)
			store:dispatch({
				type = "addMinimapLabel",
				title = markerId,
				imageId = ImageId,
				position = positionBinding,
				updatePosition = updatePositionBinding,
				markerColor = colorBinding,
				updateMarkerColor = updateColorBinding
			})
			worldMarker._maid:GiveTask(function()
				store:dispatch({
					type = "removeMinimapLabel",
					title = markerId
				})
			end)
			worldMarker._maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
				updatePositionBinding(markerInstance.Position)
			end))
			worldMarker:SetEnabled(isLocationMarkerEnabled)
			return marker
		end
		Binder.new("ImportantLocationMarker", ImportantLocationMarkerClass):Start()
		local function setEnabled()
			markerGroup:SetEnabled(isLocationMarkerEnabled)
		end
		local markerSettingConfig = {
			name = "locationMarkers",
			title = "Location Markers",
			type = gameSettingType.Checkbox,
			defaultValue = true,
			order = 41
		}
		GameSettingsService.add(markerSettingConfig)
		local function handleSetting(settingValue)
			isLocationMarkerEnabled = settingValue
			markerGroup:SetEnabled(settingValue)
		end
		isLocationMarkerEnabled = markerSettingConfig:getValue()
		markerGroup:SetEnabled(isLocationMarkerEnabled)
		markerSettingConfig.onChanged:Connect(handleSetting)
	end
}
