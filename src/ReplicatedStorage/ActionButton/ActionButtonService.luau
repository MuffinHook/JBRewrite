local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	triggerUpdate = Signal.new(),
	active = {},
	enabled = true
}
function t.add(p1) --[[ Line: 9 | Upvalues: t (copy) ]]
	table.insert(t.active, p1)
	t.triggerUpdate:Fire()
	return function() --[[ Line: 16 | Upvalues: t (ref), p1 (copy) ]]
		local v1 = table.find(t.active, p1)
		if not v1 then
			error("Could not find ActionButton, already removed?")
		end
		table.remove(t.active, v1)
		if p1._pressed then
			p1._pressed = nil
			if p1.onReleased then
				p1.onReleased()
			end
		end
		t.triggerUpdate:Fire()
	end
end
function t.pushHide() --[[ Line: 31 | Upvalues: t (copy) ]]
	t.enabled = false
	t.triggerUpdate:Fire()
	return function() --[[ Line: 34 | Upvalues: t (ref) ]]
		t.enabled = true
		t.triggerUpdate:Fire()
	end
end
function t.hide() --[[ Line: 39 | Upvalues: t (copy) ]]
	t.enabled = false
	t.triggerUpdate:Fire()
end
function t.show() --[[ Line: 43 | Upvalues: t (copy) ]]
	t.enabled = true
	t.triggerUpdate:Fire()
end
function t.setButtonPrimary(p1, p2) --[[ Line: 47 | Upvalues: t (copy) ]]
	p1.primary = p2
	t.triggerUpdate:Fire()
end
function t.setButtonPriority(p1, p2) --[[ Line: 51 | Upvalues: t (copy) ]]
	p1.priority = p2
	t.triggerUpdate:Fire()
end
function t.setButtonKeyCodes(p1, p2) --[[ Line: 55 | Upvalues: t (copy) ]]
	p1.keyCodes = p2
	t.triggerUpdate:Fire()
end
function t.addButtonKeyCode(p1, p2) --[[ Line: 59 | Upvalues: t (copy) ]]
	if not table.find(p1.keyCodes, p2) then
		table.insert(p1.keyCodes, p2)
		t.triggerUpdate:Fire()
	end
end
function t.removeButtonKeyCode(p1, p2) --[[ Line: 65 | Upvalues: t (copy) ]]
	local v1 = table.find(p1.keyCodes, p2)
	if v1 then
		table.remove(p1.keyCodes, v1)
		t.triggerUpdate:Fire()
	end
end
function t.setButtonEnabled(p1, p2) --[[ Line: 72 | Upvalues: t (copy) ]]
	p1.disabled = not p2
	if p1._pressed then
		p1._pressed = nil
		if p1.onReleased then
			p1.onReleased()
		end
	end
	t.triggerUpdate:Fire()
end
function t.getDataInner() --[[ Line: 82 | Upvalues: TableUtils (copy), t (copy) ]]
	local v1 = TableUtils.filter(t.active, function(p1) --[[ Line: 83 ]]
		return not p1.disabled and p1.primary
	end)
	table.sort(v1, function(p1, p2) --[[ Line: 86 ]]
		return (p1.priority or 1) > (p2.priority or 1)
	end)
	return v1
end
function t.getDataOuter() --[[ Line: 91 | Upvalues: TableUtils (copy), t (copy) ]]
	local v1 = TableUtils.filter(t.active, function(p1) --[[ Line: 92 ]]
		return not p1.disabled and not p1.primary
	end)
	table.sort(v1, function(p1, p2) --[[ Line: 95 ]]
		return (p1.priority or 1) > (p2.priority or 1)
	end)
	return v1
end
return t