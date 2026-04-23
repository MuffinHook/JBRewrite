local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Anim = require(ReplicatedStorage.Module.Anim)
local function Ease_InOutQuad(p1) --[[ Line: 6 ]]
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 12 | Upvalues: t (copy), Signal (copy) ]]
	assert(p1 ~= nil)
	local t2 = {}
	setmetatable(t2, t)
	t2.Model = p1
	t2.Door1CF = t2.Model.Door1.CFrame
	t2.Door2CF = t2.Model.Door2.CFrame
	t2.OnOpened = Signal.new()
	t2.Anim = nil
	t2.IsOpen = false
	return t2
end
function t.Transition(p1, p2, p3) --[[ Line: 28 | Upvalues: Anim (copy), RunService (copy) ]]
	if p1.Anim ~= nil then
		p1.Anim:Destroy()
	end
	p1.Anim = Anim.new(p2 or 6)
	p1.Anim.OnCompleted:Connect(function() --[[ Line: 34 | Upvalues: p1 (copy) ]]
		p1.Anim:Destroy()
		p1.Anim = nil
	end)
	p1.Anim.OnCanceled:Connect(function() --[[ Line: 38 | Upvalues: p1 (copy) ]]
		p1.Anim:Destroy()
		p1.Anim = nil
	end)
	p1.Anim.Maid:GiveTask(RunService.RenderStepped:Connect(function() --[[ Line: 42 | Upvalues: p1 (copy), p3 (copy) ]]
		p3(p1, (p1.Anim:Update()))
	end))
end
function t.Open(p1, p2) --[[ Line: 47 ]]
	p1.IsOpen = true
	return p1:Transition(p2, p1.SeqOpen)
end
function t.Close(p1, p2) --[[ Line: 51 ]]
	p1.IsOpen = false
	return p1:Transition(p2, p1.SeqClose)
end
function t.SetDoorOpen(p1, p2) --[[ Line: 55 ]]
	local Model = p1.Model
	local Door1 = Model.Door1
	local v1 = CFrame.new(0, 0, -Door1.Size.Z * 0.5)
	Door1.CFrame = p1.Door1CF * v1 * CFrame.Angles(p2 * math.pi * 0.5, 0, 0) * v1:Inverse()
	local Door2 = Model.Door2
	local v2 = CFrame.new(0, 0, -Door2.Size.Z * 0.5)
	Door2.CFrame = p1.Door2CF * v2 * CFrame.Angles(p2 * math.pi * 0.5, 0, 0) * v2:Inverse()
end
function t.SeqOpen(p1, p2) --[[ Line: 65 ]]
	if p2 == 1 then
		p1.OnOpened:Fire()
	end
	local v1, v2
	if p2 < 0.5 then
		v1 = 2 * p2 * p2
		if not v1 then
			v2 = p2
			v1 = -1 - 2 * (p2 - 2) * p2
		end
	else
		v2 = p2
		v1 = -1 - 2 * (p2 - 2) * p2
	end
	p1:SetDoorOpen(v1)
end
function t.SeqClose(p1, p2) --[[ Line: 72 ]]
	local v1 = 1 - p2
	p1:SetDoorOpen(v1 < 0.5 and 2 * v1 * v1 or -1 - 2 * (v1 - 2) * v1)
end
function t.Destroy(p1) --[[ Line: 76 ]]
	if p1.Anim ~= nil then
		p1.Anim:Destroy()
		p1.Anim = nil
	end
	p1.OnOpened:Destroy()
	p1.OnOpened = nil
end
return t