-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local Tracer = require(ReplicatedStorage.Game.Tracer)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local function computePosition(p1, p2)
	return CFrame.fromAxisAngle(p1.axis, p2 + p1.angle0) * p1.origin
end
local t = {
	list = {}
}
function t.init()
	Interval.every(10):Connect(function()
		local v1 = GeomUtils.randomPointOnCircle()
		local v2 = Vector3.new(v1.x, 0, v1.y) * 5000
		local v3 = v2:Cross(Vector3.new(0, 1, 0))
		local v4 = math.random() * 0.5 + 1
		for i = 1, 4 do
			t.create(v2 + GeomUtils.randomPointOnSphere() * 50, v3, v4 + math.random() * 0.2)
			task.wait()
		end
	end)
	RunService.Heartbeat:Connect(function()
		local v1 = os.clock()
		for i = #t.list, 1, -1 do
			local v2 = t.list[i]
			local v3 = v1 - v2.bornAt
			local v4 = v2.lastPosition or CFrame.fromAxisAngle(v2.axis, 0 + v2.angle0) * v2.origin
			local v5 = CFrame.fromAxisAngle(v2.axis, v3 + v2.angle0) * v2.origin
			v2.lastPosition = v5
			v2.tracer:Draw(v4, v5)
			if v2.lifetime < v3 then
				table.remove(t.list, i)
				v2.tracer:Destroy()
			end
		end
	end)
end
function t.create(p1, p2, p3)
	local v1 = Tracer.new()
	v1:SetColor(Color3.new(255/255, 255/255, 255/255))
	v1:SetThickness(1)
	table.insert(t.list, {
		bornAt = os.clock(),
		tracer = v1,
		origin = p1,
		axis = p2,
		lifetime = p3,
		angle0 = math.random() * math.pi
	})
end
return t