-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local Tracer = require(ReplicatedStorage.Game.Tracer)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local function computePosition(p1, p2)
	return CFrame.fromAxisAngle(p1.axis, p2 + p1.angle0) * p1.origin
end
local module = {
	list = {}
}
function module.init()
	Interval.every(10):Connect(function()
		local circlePoint = GeomUtils.randomPointOnCircle()
		local spawnPosition = Vector3.new(circlePoint.x, 0, circlePoint.y) * 5000
		local direction = spawnPosition:Cross(Vector3.new(0, 1, 0))
		local lifetime = math.random() * 0.5 + 1
		for i = 1, 4 do
			module.create(spawnPosition + GeomUtils.randomPointOnSphere() * 50, direction, lifetime + math.random() * 0.2)
			task.wait()
		end
	end)
	RunService.Heartbeat:Connect(function()
		local currentTime = os.clock()
		for i = #module.list, 1, -1 do
			local star = module.list[i]
			local elapsedTime = currentTime - star.bornAt
			local previousFrame = star.lastPosition or CFrame.fromAxisAngle(star.axis, 0 + star.angle0) * star.origin
			local currentFrame = CFrame.fromAxisAngle(star.axis, elapsedTime + star.angle0) * star.origin
			star.lastPosition = currentFrame
			star.tracer:Draw(previousFrame, currentFrame)
			if star.lifetime < elapsedTime then
				table.remove(module.list, i)
				star.tracer:Destroy()
			end
		end
	end)
end
function module.create(p1, p2, p3)
	local tracer = Tracer.new()
	tracer:SetColor(Color3.new(255/255, 255/255, 255/255))
	tracer:SetThickness(1)
	table.insert(module.list, {
		bornAt = os.clock(),
		tracer = tracer,
		origin = p1,
		axis = p2,
		lifetime = p3,
		angle0 = math.random() * math.pi
	})
end
return module