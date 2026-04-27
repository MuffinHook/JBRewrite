local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Signal = require(ReplicatedStorage.Std.Signal)
local gameSettingType = require(script.Parent.gameSettingType)
local gameSettingsService = {
	onUpdate = Signal.new(),
	_list = {},
	onAdded = Signal.new()
}
function gameSettingsService.add(settingData)
	assert(settingData.name, "missing name")
	assert(settingData.type, "missing gameSettingType")
	assert(settingData.defaultValue ~= nil, "missing defaultValue")
	assert(settingData.order, "missing order")
	if not settingData.onChanged then
		settingData.onChanged = Signal.new()
	end
	if settingData.type == gameSettingType.Checkbox then
		if not settingData._value then
			settingData._value = settingData.defaultValue
		end
	elseif settingData.type == gameSettingType.Slider and not settingData._value then
		local binding, updateBinding = Roact.createBinding(settingData.defaultValue)
		settingData._value = binding
		settingData._updateValue = updateBinding
	end
	function settingData.getValue(setting)
		return gameSettingsService.getValue(setting)
	end
	table.insert(gameSettingsService._list, settingData)
	gameSettingsService.onUpdate:Fire()
	gameSettingsService.onAdded:Fire(settingData)
	return function()
		for i = #gameSettingsService._list, 1, -1 do
			if gameSettingsService._list[i] == settingData then
				table.remove(gameSettingsService._list, i)
				gameSettingsService.onUpdate:Fire()
				return true
			end
		end
		return false
	end
end
function gameSettingsService.getAll()
	return gameSettingsService._list
end
function gameSettingsService.getSettingByName(name)
	for i, setting in ipairs(gameSettingsService._list) do
		if setting.name == name then
			return setting
		end
	end
end
function gameSettingsService.getValueByName(name)
	assert(name, "missing name")
	return gameSettingsService.getValue((gameSettingsService.getSettingByName(name)))
end
function gameSettingsService.getValue(setting)
	assert(setting, "missing setting")
	if setting.type == gameSettingType.Checkbox then
		return setting._value
	end
	if setting.type == gameSettingType.Slider then
		return setting._value:getValue()
	end
end
function gameSettingsService.setValueByName(name, value)
	assert(name, "missing name")
	gameSettingsService.setValue(gameSettingsService.getSettingByName(name), value)
end
function gameSettingsService.setValue(setting, value)
	assert(setting, "missing setting")
	if setting.type == gameSettingType.Checkbox then
		setting._value = value
	elseif setting.type == gameSettingType.Slider then
		setting._updateValue(value)
	end
	setting.onChanged:Fire(value)
	gameSettingsService.onUpdate:Fire()
end
return gameSettingsService
