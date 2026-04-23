local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local function Ease_InOutQuad(p1) --[[ Line: 5 ]]
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 11 | Upvalues: t (copy) ]]
	assert(p1 ~= nil)
	assert(p2 ~= nil)
	local t2 = {}
	setmetatable(t2, t)
	t2.HingeCF = p2.CFrame
	t2.Model = p1
	t2.Model.PrimaryPart = p2
	t2.Event = nil
	t2.Angle = 0
	return t2
end
function t.AnimateToAngle(p1, p2, p3) --[[ Line: 27 | Upvalues: RunService (copy) ]]
	assert(p2 ~= nil)
	assert(p3 ~= nil)
	if p1.Event ~= nil then
		p1.Event:Disconnect()
		p1.Event = nil
	end
	local Angle = p1.Angle
	local v3 = tick()
	p1.Event = RunService.Heartbeat:Connect(function() --[[ Line: 37 | Upvalues: v3 (copy), p3 (copy), p1 (copy), Angle (copy), p2 (copy) ]]
		local v1 = (tick() - v3) / p3
		if v1 > 1 then
			p1.Event:Disconnect()
			p1.Event = nil
			v1 = 1
		end
		local v2, v32
		if v1 < 0.5 then
			v2 = 2 * v1 * v1
			if not v2 then
				v32 = v1
				v2 = -1 - 2 * (v1 - 2) * v1
			end
		else
			v32 = v1
			v2 = -1 - 2 * (v1 - 2) * v1
		end
		p1.Angle = Angle * (1 - v2) + p2 * v2
		p1.Model:PivotTo(p1.HingeCF * CFrame.Angles(p1.Angle, 0, 0))
	end)
end
local t2 = {
	_initSpawned = function(p1) --[[ Name: _initSpawned | Line: 53 | Upvalues: RunUtils (copy), RunService (copy), t (copy) ]]
		p1.Model = workspace:WaitForChild("Drawbridge", 5)
		if p1.Model == nil then
			if RunUtils.isMainWorld() and not RunService:IsStudio() then
				error("Missing `Drawbridge` in Workspace.")
			else
				return
			end
		end
		p1.Door0 = t.new(p1.Model.Model.RoadA.Bridge, p1.Model.Model.RoadA.Hinge)
	end
}
function t2.Init(p1) --[[ Line: 66 | Upvalues: t2 (copy) ]]
	task.spawn(t2._initSpawned, t2)
	function p1.em.fbs2dwjk(p1) --[[ Line: 71 | Upvalues: t2 (ref) ]]
		if p1 then
			t2.Open()
		else
			t2.Close()
		end
	end
end
function t2.Open() --[[ Line: 79 | Upvalues: t2 (copy) ]]
	t2.Door0:AnimateToAngle(0.9424777960769379, 10)
end
function t2.Close() --[[ Line: 83 | Upvalues: t2 (copy) ]]
	t2.Door0:AnimateToAngle(0, 10)
end
return t2