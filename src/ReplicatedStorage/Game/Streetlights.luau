local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 8 | Upvalues: t (copy), Maid (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	return t2
end
function t.SetValue(p1, p2) --[[ Line: 17 ]]
	local Light = p1._obj:FindFirstChild("Light")
	Light:FindFirstChildWhichIsA("Light", true).Enabled = p2
	Light.Material = p2 and Enum.Material.Neon or Enum.Material.SmoothPlastic
end
function t.Destroy(p1) --[[ Line: 22 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
	setmetatable(p1, nil)
end
local t2 = {
	_enabled = false
}
function t2.init() --[[ Line: 31 | Upvalues: Binder (copy), t (copy), t2 (copy) ]]
	local v1 = Binder.new("Streetlight", t)
	t2._binder = v1
	v1:GetClassAddedSignal():Connect(function(p1) --[[ Line: 34 | Upvalues: t2 (ref) ]]
		p1:SetValue(t2._enabled)
	end)
	v1:Start()
end
function t2.SetEnabled(p1) --[[ Line: 39 | Upvalues: t2 (copy) ]]
	t2._enabled = p1
	for i, v in ipairs(t2._binder:GetAll()) do
		if v.SetValue then
			v:SetValue(p1)
		end
		wait(math.random() * 0.1)
	end
end
function t2.Flicker() --[[ Line: 48 | Upvalues: t2 (copy) ]]
	local v1 = true
	for i = 1, 10 do
		v1 = not v1
		for i2, v in ipairs(t2._binder:GetAll()) do
			v:SetValue(v1)
		end
		wait(0.2)
	end
	for i, v in ipairs(t2._binder:GetAll()) do
		v:SetValue(t2._enabled)
	end
end
return t2