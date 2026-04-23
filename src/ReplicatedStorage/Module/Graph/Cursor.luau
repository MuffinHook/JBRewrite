local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 6 | Upvalues: t (copy) ]]
	assert(p1)
	assert(p2)
	local t2 = {}
	setmetatable(t2, t)
	t2.Graph = p1
	t2.Node = p2
	return t2
end
function t.GetOnWalkedSignal(p1) --[[ Line: 18 | Upvalues: Signal (copy) ]]
	if p1._onWalkedSignal == nil then
		p1._onWalkedSignal = Signal.new()
	end
	return p1._onWalkedSignal
end
function t.WalkTo(p1, p2) --[[ Line: 24 ]]
	assert(p2)
	if p1.Graph:HasEdge(p1.Node, p2) then
		p1.Node = p2
		if p1._onWalkedSignal then
			p1._onWalkedSignal:Fire(p2)
		end
		return true
	else
		return false
	end
end
return t