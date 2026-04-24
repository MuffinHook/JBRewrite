-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
	triggerUpdate = require(ReplicatedStorage.Std.Signal).new(),
	active = {}
}
function module.add(p1)
	table.insert(module.active, p1)
	module.triggerUpdate:Fire()
	return function()
		table.remove(module.active, (table.find(module.active, p1)))
		module.triggerUpdate:Fire()
	end
end
return module