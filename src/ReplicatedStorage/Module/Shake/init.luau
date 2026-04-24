-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Trove = require(script.Trove)
local v1 = Random.new()
local v2 = 0
local t = {}
t.__index = t
function t.new()
	local v2 = setmetatable({}, t)
	v2.Amplitude = 1
	v2.Frequency = 1
	v2.FadeInTime = 1
	v2.FadeOutTime = 1
	v2.SustainTime = 0
	v2.Sustain = false
	v2.PositionInfluence = Vector3.new(1, 1, 1)
	v2.RotationInfluence = Vector3.new(1, 1, 1)
	v2.TimeFunction = if RunService:IsRunning() then time else os.clock
	v2._timeOffset = v1:NextNumber(-1000000000, 1000000000)
	v2._startTime = 0
	v2._trove = Trove.new()
	v2._running = false
	return v2
end
function t.InverseSquare(p1, p2)
	if p2 < 1 then
		p2 = 1
	end
	return p1 * (1 / (p2 * p2))
end
function t.NextRenderName()
	v2 = v2 + 1
	return ("__shake_%.4i__"):format(v2)
end
function t.Start(p1)
	p1._startTime = p1.TimeFunction()
	p1._running = true
	p1._trove:Add(function()
		p1._running = false
	end)
end
function t.Stop(p1)
	p1._trove:Clean()
end
function t.IsShaking(p1)
	return p1._running
end
function t.StopSustain(p1)
	local v1 = p1.TimeFunction()
	p1.Sustain = false
	p1.SustainTime = v1 - p1._startTime - p1.FadeInTime
end
function t.Update(p1)
	local v1 = false
	local v2 = p1.TimeFunction()
	local v3 = v2 - p1._startTime
	local v4 = (v2 + p1._timeOffset) / p1.Frequency % 1000000
	local v5 = 1
	local v6 = if v3 < p1.FadeInTime then v3 / p1.FadeInTime else 1
	if not p1.Sustain and p1.FadeInTime + p1.SustainTime < v3 then
		if p1.FadeOutTime == 0 then
			v1 = true
		else
			v5 = 1 - (v3 - p1.FadeInTime - p1.SustainTime) / p1.FadeOutTime
			if not p1.Sustain and p1.FadeInTime + p1.SustainTime + p1.FadeOutTime <= v3 then
				v1 = true
			end
		end
	end
	local v7 = math.noise(v4, 0) / 2
	local v8 = math.noise(0, v4) / 2
	local v9 = math.noise(v4, v4) / 2
	local v10 = Vector3.new(v7, v8, v9) * p1.Amplitude * math.min(v6, v5)
	if v1 then
		p1:Stop()
	end
	return p1.PositionInfluence * v10, p1.RotationInfluence * v10, v1
end
function t.OnSignal(p1, p2, p3)
	return p1._trove:Connect(p2, function()
		p3(p1:Update())
	end)
end
function t.BindToRenderStep(p1, p2, p3, p4)
	p1._trove:BindToRenderStep(p2, p3, function()
		p4(p1:Update())
	end)
end
function t.Clone(p1)
	local v1 = t.new()
	for v2, v3 in {
		"Amplitude",
		"Frequency",
		"FadeInTime",
		"FadeOutTime",
		"SustainTime",
		"Sustain",
		"PositionInfluence",
		"RotationInfluence",
		"TimeFunction"
	} do
		v1[v3] = p1[v3]
	end
	return v1
end
function t.Destroy(p1)
	p1:Stop()
end
return t
