local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local service = {
	triggerUpdate = Signal.new(),
	active = {},
	enabled = true
}
function service.add(button)
	table.insert(service.active, button)
	service.triggerUpdate:Fire()
	return function()
		local foundIndex = table.find(service.active, button)
		if not foundIndex then
			error("Could not find ActionButton, already removed?")
		end
		table.remove(service.active, foundIndex)
		if button._pressed then
			button._pressed = nil
			if button.onReleased then
				button.onReleased()
			end
		end
		service.triggerUpdate:Fire()
	end
end
function service.pushHide()
	service.enabled = false
	service.triggerUpdate:Fire()
	return function()
		service.enabled = true
		service.triggerUpdate:Fire()
	end
end
function service.hide()
	service.enabled = false
	service.triggerUpdate:Fire()
end
function service.show()
	service.enabled = true
	service.triggerUpdate:Fire()
end
function service.setButtonPrimary(button, value)
	button.primary = value
	service.triggerUpdate:Fire()
end
function service.setButtonPriority(button, value)
	button.priority = value
	service.triggerUpdate:Fire()
end
function service.setButtonKeyCodes(button, value)
	button.keyCodes = value
	service.triggerUpdate:Fire()
end
function service.addButtonKeyCode(button, value)
	if not table.find(button.keyCodes, value) then
		table.insert(button.keyCodes, value)
		service.triggerUpdate:Fire()
	end
end
function service.removeButtonKeyCode(button, value)
	local foundIndex = table.find(button.keyCodes, value)
	if foundIndex then
		table.remove(button.keyCodes, foundIndex)
		service.triggerUpdate:Fire()
	end
end
function service.setButtonEnabled(button, value)
	button.disabled = not value
	if button._pressed then
		button._pressed = nil
		if button.onReleased then
			button.onReleased()
		end
	end
	service.triggerUpdate:Fire()
end
function service.getDataInner()
	local filtered = TableUtils.filter(service.active, function(button)
		return not button.disabled and button.primary
	end)
	table.sort(filtered, function(button1, button2)
		return (button1.priority or 1) > (button2.priority or 1)
	end)
	return filtered
end
function service.getDataOuter()
	local filtered = TableUtils.filter(service.active, function(button)
		return not button.disabled and not button.primary
	end)
	table.sort(filtered, function(button1, button2)
		return (button1.priority or 1) > (button2.priority or 1)
	end)
	return filtered
end
return service