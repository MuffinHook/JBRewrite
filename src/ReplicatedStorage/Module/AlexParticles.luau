local RunService = game:GetService("RunService")
local cframe = CFrame.new
local Angles = CFrame.Angles
local vector2 = Vector3.new
cframe(0, 0, 0)
local vector3 = Vector3.new(0, 0, 0)
local Dot = vector3.Dot
local Cross = vector3.Cross
local sin = math.sin
local cos = math.cos
local atan = math.atan
local atan2 = math.atan2
local tanh = math.tanh
local floor = math.floor
local abs = math.abs
local log = math.log
local max = math.max
local random = math.random
local deg = math.deg
local insert = table.insert
local remove = table.remove
local function RandomVector(magnitude)
	local randomX = random()
	local randomY = random()
	local maxRandom
	if randomY < randomX then
		maxRandom, randomY = randomX, randomY
	else
		maxRandom = randomX
	end
	return vector2(randomY * magnitude * cos(6.283185307179586 * maxRandom / randomY), randomY * magnitude * sin(6.283185307179586 * maxRandom / randomY), 0)
end
local function MakeState()
	return {
		Frame = nil,
		Simulate = {},
		Fireworks = {}
	}
end
local function MakeParticle()
	return {
		Frame = nil,
		position = Vector3.new(0, 0, 0),
		velocity = Vector3.new(0, 0, 0),
		acceleration = Vector3.new(0, 0, 0),
		createdTime = tick(),
		ttl = 4,
		Fake = false
	}
end
local function Single(state, position, velocity, acceleration)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, 2, 0, 2)
	Frame.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 8
	Frame.Parent = state.Frame
	local particle = {
		Frame = nil,
		position = Vector3.new(0, 0, 0),
		velocity = Vector3.new(0, 0, 0),
		acceleration = Vector3.new(0, 0, 0),
		createdTime = tick(),
		ttl = 4,
		Fake = false,
		Frame = Frame,
		position = position,
		velocity = velocity,
		acceleration = acceleration
	}
	insert(state.Simulate, particle)
	return particle
end
local function Firework(state, position, velocity, acceleration)
	local fireworkParticle = Single(state, position, velocity, acceleration)
	fireworkParticle.Frame.Visible = false
	insert(state.Fireworks, fireworkParticle)
	return fireworkParticle
end
local function Explosion(state, position)
	local explosionColor = Color3.fromHSV(random(), 0.9, 0.9)
	for i = 1, 30 do
		local angleRadians
		local speed = 200 + random() * 100
		local randomValue1 = random()
		local randomValue2 = random()
		if randomValue2 < randomValue1 then
			randomValue2, angleRadians = randomValue1, randomValue2
		else
			angleRadians = randomValue1
		end
		local primaryParticle = Single(state, position, vector2(randomValue2 * speed * cos(6.283185307179586 * angleRadians / randomValue2), randomValue2 * speed * sin(6.283185307179586 * angleRadians / randomValue2), 0), Vector3.new(0, 0, 0))
		primaryParticle.ttl = 1
		primaryParticle.Frame.BackgroundColor3 = explosionColor
	end
	local secondaryColor = Color3.fromHSV(random(), 0.9, 0.9)
	for j = 1, 10 do
		local secondaryAngle
		local randomComponent1 = random()
		local randomComponent2 = random()
		if randomComponent2 < randomComponent1 then
			randomComponent2, secondaryAngle = randomComponent1, randomComponent2
		else
			secondaryAngle = randomComponent1
		end
		local secondaryParticle = Single(state, position, vector2(randomComponent2 * 100 * cos(6.283185307179586 * secondaryAngle / randomComponent2), randomComponent2 * 100 * sin(6.283185307179586 * secondaryAngle / randomComponent2), 0), Vector3.new(0, 0, 0))
		secondaryParticle.ttl = 1.5
		secondaryParticle.Frame.BackgroundColor3 = secondaryColor
	end
end
local function Update(state, deltaTime)
	local currentTime = tick()
	local simulateList = state.Simulate
	for i = #simulateList, 1, -1 do
		local particle = simulateList[i]
		local currentPos = particle.position
		local newVelocity = particle.velocity + particle.acceleration * deltaTime
		local newPos = currentPos + newVelocity * deltaTime
		local newX = newPos.x
		local newY = newPos.y
		local deltaX = newX - currentPos.x
		local deltaY = newY - currentPos.y
		local distance = (deltaX * deltaX + deltaY * deltaY) ^ 0.5
		particle.position = newPos
		particle.velocity = newVelocity
		local Frame = particle.Frame
		if not particle.Fake then
			if distance < 2 then
				Frame.Position = UDim2.new(0, newX - 1, 0, newY - 1)
				Frame.Size = UDim2.new(0, 2, 0, 2)
			else
				Frame.Position = UDim2.new(0, newX + (deltaX - distance) * 0.5, 0, newY + (deltaY - distance) * 0.5)
				Frame.Size = UDim2.new(0, distance, 0, 3)
				Frame.Rotation = deg((atan2(deltaY, deltaX)))
			end
		end
		local elapsedTime = currentTime - particle.createdTime
		local ttl = particle.ttl
		if ttl <= elapsedTime then
			remove(simulateList, i)
			particle.Frame:Destroy()
		elseif ttl * 0.5 <= elapsedTime then
			particle.Frame.Transparency = tanh((elapsedTime - ttl * 0.5) / (ttl * 0.5)) * 1.313
		end
	end
	local fireworksList = state.Fireworks
	for j = #fireworksList, 1, -1 do
		local fireworkTrailAngle
		local firework = fireworksList[j]
		if currentTime - firework.createdTime >= firework.ttl then
			remove(fireworksList, j)
			firework.Frame:Destroy()
			if firework.OnDestroy then
				firework:OnDestroy()
			end
			local burstColor = Color3.fromHSV(random(), 0.9, 0.9)
			for k = 1, 30 do
				local burstAngle
				local burstSpeed = 200 + random() * 100
				local burstRand1 = random()
				local burstRand2 = random()
				if burstRand2 < burstRand1 then
					burstRand2, burstAngle = burstRand1, burstRand2
				else
					burstAngle = burstRand1
				end
				local burstParticle = Single(state, firework.position, vector2(burstRand2 * burstSpeed * cos(6.283185307179586 * burstAngle / burstRand2), burstRand2 * burstSpeed * sin(6.283185307179586 * burstAngle / burstRand2), 0), Vector3.new(0, 0, 0))
				burstParticle.ttl = 1
				burstParticle.Frame.BackgroundColor3 = burstColor
			end
			local trailColor = Color3.fromHSV(random(), 0.9, 0.9)
			for n = 1, 10 do
				local trailAngle
				local trailRand1 = random()
				local trailRand2 = random()
				if trailRand2 < trailRand1 then
					trailRand2, trailAngle = trailRand1, trailRand2
				else
					trailAngle = trailRand1
				end
				local trailParticle = Single(state, firework.position, vector2(trailRand2 * 100 * cos(6.283185307179586 * trailAngle / trailRand2), trailRand2 * 100 * sin(6.283185307179586 * trailAngle / trailRand2), 0), Vector3.new(0, 0, 0))
				trailParticle.ttl = 1.5
				trailParticle.Frame.BackgroundColor3 = trailColor
			end
		end
		local streamRand1 = random()
		local streamRand2 = random()
		if streamRand2 < streamRand1 then
			streamRand2, fireworkTrailAngle = streamRand1, streamRand2
		else
			fireworkTrailAngle = streamRand1
		end
		Single(state, firework.position, vector2(streamRand2 * 60 * cos(6.283185307179586 * fireworkTrailAngle / streamRand2), streamRand2 * 60 * sin(6.283185307179586 * fireworkTrailAngle / streamRand2), 0), Vector3.new(0, 400, 0)).ttl = 0.8
	end
end
local function Clear(state)
	for index, particle in next, state.Simulate do
		particle.Frame:Destroy()
	end
	state.Simulate = {}
end
return {
	MakeState = MakeState,
	Single = Single,
	Firework = Firework,
	Explosion = Explosion,
	EasySimulate = function(state, duration)
		local function Heartbeat(deltaTime)
			Update(state, deltaTime)
		end
		local heartbeatConnection = RunService.Heartbeat:Connect(Heartbeat)
		local function Finish()
			heartbeatConnection:Disconnect()
			Clear(state)
		end
		delay(duration, Finish)
	end,
	Update = Update,
	Clear = Clear
}
