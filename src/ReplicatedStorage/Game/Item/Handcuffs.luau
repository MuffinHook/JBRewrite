local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Basic = require(script.Parent.Basic)
local Handcuffs = require(ReplicatedStorage.Game.ItemConfig.Handcuffs)
local t = {
	__ClassName = "Handcuffs"
}
t.__index = t
setmetatable(t, Basic)
function t.new(p1, p2, p3) --[[ Line: 11 | Upvalues: Basic (copy), Handcuffs (copy), t (copy) ]]
	local v1 = Basic.new(p1, p2, Handcuffs, p3)
	setmetatable(v1, t)
	v1.SpringItemOffset:SetTarget(Vector3.new(0, 0.3, -1))
	return v1
end
function t.InputBegan(p1, ...) --[[ Line: 19 | Upvalues: Basic (copy) ]]
	Basic.InputBegan(p1, ...)
end
function t.InputEnded(p1) --[[ Line: 22 ]] end
return t