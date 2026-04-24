-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Signal = require(ReplicatedStorage.Std.Signal)
local gameSettingType = require(script.Parent.gameSettingType)
local t = {
	onUpdate = Signal.new(),
	_list = {},
	onAdded = Signal.new()
}
function t.add(p1)
	assert(p1.name, "missing name")
	assert(p1.type, "missing gameSettingType")
	assert(p1.defaultValue ~= nil, "missing defaultValue")
	assert(p1.order, "missing order")
	if not p1.onChanged then
		p1.onChanged = Signal.new()
	end
	if p1.type == gameSettingType.Checkbox then
		if not p1._value then
			p1._value = p1.defaultValue
		end
	elseif p1.type == gameSettingType.Slider and not p1._value then
		local v2, v3 = Roact.createBinding(p1.defaultValue)
		p1._value = v2
		p1._updateValue = v3
	end
	function p1.getValue(p1)
		return t.getValue(p1)
	end
	table.insert(t._list, p1)
	t.onUpdate:Fire()
	t.onAdded:Fire(p1)
	return function()
		for i = #t._list, 1, -1 do
			if t._list[i] == p1 then
				table.remove(t._list, i)
				t.onUpdate:Fire()
				return true
			end
		end
		return false
	end
end
function t.getAll()
	return t._list
end
function t.getSettingByName(p1)
	for i, v in ipairs(t._list) do
		if v.name == p1 then
			return v
		end
	end
end
function t.getValueByName(p1)
	assert(p1, "missing name")
	return t.getValue((t.getSettingByName(p1)))
end
function t.getValue(p1)
	assert(p1, "missing setting")
	if p1.type == gameSettingType.Checkbox then
		return p1._value
	end
	if p1.type == gameSettingType.Slider then
		return p1._value:getValue()
	end
end
function t.setValueByName(p1, p2)
	assert(p1, "missing name")
	t.setValue(t.getSettingByName(p1), p2)
end
function t.setValue(p1, p2)
	assert(p1, "missing setting")
	if p1.type == gameSettingType.Checkbox then
		p1._value = p2
	elseif p1.type == gameSettingType.Slider then
		p1._updateValue(p2)
	end
	p1.onChanged:Fire(p2)
	t.onUpdate:Fire()
end
return t
