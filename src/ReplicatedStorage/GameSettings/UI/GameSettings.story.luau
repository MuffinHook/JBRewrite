-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
return function(p1)
	local v1 = Maid.new()
	v1:GiveTask(GameSettingsService.add({
		name = "playerMarkers",
		title = "Player Markers",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 42
	}))
	local v2 = Roact.mount(Roact.createElement(require(script.Parent.GameSettings), {
		size = UDim2.new(0.8, 0, 0.8, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5)
	}), p1)
	return function()
		v1:DoCleaning()
		Roact.unmount(v2)
	end
end
