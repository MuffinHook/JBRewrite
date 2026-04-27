local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
	triggerUpdate = require(ReplicatedStorage.Std.Signal).new(),
	active = {}
}
function module.add(button)
	table.insert(module.active, button)
	module.triggerUpdate:Fire()
	return function()
		table.remove(module.active, (table.find(module.active, button)))
		module.triggerUpdate:Fire()
	end
end
return module
