local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	triggerUpdate = require(ReplicatedStorage.Std.Signal).new(),
	active = {}
}
function t.add(p1) --[[ Line: 7 | Upvalues: t (copy) ]]
	table.insert(t.active, p1)
	t.triggerUpdate:Fire()
	return function() --[[ Line: 10 | Upvalues: t (ref), p1 (copy) ]]
		table.remove(t.active, (table.find(t.active, p1)))
		t.triggerUpdate:Fire()
	end
end
return t