-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	triggerUpdate = require(ReplicatedStorage.Std.Signal).new(),
	active = {}
}
function t.add(p1)
	table.insert(t.active, p1)
	t.triggerUpdate:Fire()
	return function()
		table.remove(t.active, (table.find(t.active, p1)))
		t.triggerUpdate:Fire()
	end
end
return t