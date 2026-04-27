local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
return function(parentContainer)
	local maid = Maid.new()
	maid:GiveTask(GameSettingsService.add({
		name = "playerMarkers",
		title = "Player Markers",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 42
	}))
	local mountedComponent = Roact.mount(Roact.createElement(require(script.Parent.GameSettings), {
		size = UDim2.new(0.8, 0, 0.8, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		anchorPoint = Vector2.new(0.5, 0.5)
	}), parentContainer)
	return function()
		maid:DoCleaning()
		Roact.unmount(mountedComponent)
	end
end
