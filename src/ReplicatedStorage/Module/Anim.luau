local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 13 | Upvalues: t (copy), Maid (copy), Signal (copy) ]]
	assert(p1)
	assert(p1 > 0)
	local t2 = {}
	setmetatable(t2, t)
	t2.Maid = Maid.new()
	t2.Duration = p1
	t2.BornAt = os.clock()
	t2.OnCompleted = Signal.new()
	t2.Maid:GiveTask(t2.OnCompleted)
	t2.OnCanceled = Signal.new()
	t2.Maid:GiveTask(t2.OnCanceled)
	t2.IsCompleted = false
	return t2
end
function t.Update(p1) --[[ Line: 33 ]]
	local v1 = (os.clock() - p1.BornAt) / p1.Duration
	if v1 >= 1 and p1.IsCompleted == false then
		p1.IsCompleted = true
		p1.OnCompleted:Fire()
	end
	return math.clamp(v1, 0, 1)
end
function t.Destroy(p1) --[[ Line: 45 ]]
	if p1.Maid ~= nil then
		local Maid = p1.Maid
		p1.Maid = nil
		if p1.IsCompleted == false then
			p1.OnCanceled:Fire()
		end
		Maid:Destroy()
	end
end
return t