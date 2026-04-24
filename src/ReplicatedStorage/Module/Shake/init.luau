-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Trove = require(script.Trove)
local instance = Random.new()
local table2 = 0
local t = {}
t.__index = t
function t.new()
	local table2 = setmetatable({}, t)
	table2.Amplitude = 1
	table2.Frequency = 1
	table2.FadeInTime = 1
	table2.FadeOutTime = 1
	table2.SustainTime = 0
	table2.Sustain = false
	table2.PositionInfluence = Vector3.new(1, 1, 1)
	table2.RotationInfluence = Vector3.new(1, 1, 1)
	table2.TimeFunction = if RunService:IsRunning() then time else os.clock
	table2._timeOffset = instance:NextNumber(-1000000000, 1000000000)
	table2._startTime = 0
	table2._trove = Trove.new()
	table2._running = false
	return table2
end
function t.InverseSquare(p1, p2)
	if p2 < 1 then
		p2 = 1
	end
	return p1 * (1 / (p2 * p2))
end
function t.NextRenderName()
	table2 = table2 + 1
	return ("__shake_%.4i__"):format(table2)
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
	local instance = p1.TimeFunction()
	p1.Sustain = false
	p1.SustainTime = instance - p1._startTime - p1.FadeInTime
end
function t.Update(p1)
	local instance = false
	local table2 = p1.TimeFunction()
	local var3 = table2 - p1._startTime
	local var4 = (table2 + p1._timeOffset) / p1.Frequency % 1000000
	local var5 = 1
	local var6 = if var3 < p1.FadeInTime then var3 / p1.FadeInTime else 1
	if not p1.Sustain and p1.FadeInTime + p1.SustainTime < var3 then
		if p1.FadeOutTime == 0 then
			instance = true
		else
			var5 = 1 - (var3 - p1.FadeInTime - p1.SustainTime) / p1.FadeOutTime
			if not p1.Sustain and p1.FadeInTime + p1.SustainTime + p1.FadeOutTime <= var3 then
				instance = true
			end
		end
	end
	local var7 = math.noise(var4, 0) / 2
	local var8 = math.noise(0, var4) / 2
	local var9 = math.noise(var4, var4) / 2
	local vector10 = Vector3.new(var7, var8, var9) * p1.Amplitude * math.min(var6, var5)
	if instance then
		p1:Stop()
	end
	return p1.PositionInfluence * vector10, p1.RotationInfluence * vector10, instance
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
	local instance = t.new()
	for table2, var3 in {
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
		instance[var3] = p1[var3]
	end
	return instance
end
function t.Destroy(p1)
	p1:Stop()
end
return t
