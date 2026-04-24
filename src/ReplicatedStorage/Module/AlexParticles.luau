-- Reviewed by Claude
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
local function RandomVector(p1)
	local cframe = random()
	local var22 = random()
	local vector3
	if var22 < cframe then
		var22, vector3 = cframe, var22
	else
		vector3 = cframe
	end
	return vector2(var22 * p1 * cos(6.283185307179586 * vector3 / var22), var22 * p1 * sin(6.283185307179586 * vector3 / var22), 0)
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
		p = Vector3.new(0, 0, 0),
		v = Vector3.new(0, 0, 0),
		a = Vector3.new(0, 0, 0),
		t = tick(),
		ttl = 4,
		Fake = false
	}
end
local function Single(p1, p2, p3, p4)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, 2, 0, 2)
	Frame.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 8
	Frame.Parent = p1.Frame
	local t = {
		Frame = nil,
		p = Vector3.new(0, 0, 0),
		v = Vector3.new(0, 0, 0),
		a = Vector3.new(0, 0, 0),
		t = tick(),
		ttl = 4,
		Fake = false,
		Frame = Frame,
		p = p2,
		v = p3,
		a = p4
	}
	insert(p1.Simulate, t)
	return t
end
local function Firework(p1, p2, p3, p4)
	local cframe = Single(p1, p2, p3, p4)
	cframe.Frame.Visible = false
	insert(p1.Fireworks, cframe)
	return cframe
end
local function Explosion(p1, p2)
	local cframe = Color3.fromHSV(random(), 0.9, 0.9)
	for i = 1, 30 do
		local var22
		local var4 = 200 + random() * 100
		local var5 = random()
		local var6 = random()
		if var6 < var5 then
			var6, var22 = var5, var6
		else
			var22 = var5
		end
		local vector7 = Single(p1, p2, vector2(var6 * var4 * cos(6.283185307179586 * var22 / var6), var6 * var4 * sin(6.283185307179586 * var22 / var6), 0), Vector3.new(0, 0, 0))
		vector7.ttl = 1
		vector7.Frame.BackgroundColor3 = cframe
	end
	local color8 = Color3.fromHSV(random(), 0.9, 0.9)
	for j = 1, 10 do
		local v9
		local var11 = random()
		local var12 = random()
		if var12 < var11 then
			var12, v9 = var11, var12
		else
			v9 = var11
		end
		local vector13 = Single(p1, p2, vector2(var12 * 100 * cos(6.283185307179586 * v9 / var12), var12 * 100 * sin(6.283185307179586 * v9 / var12), 0), Vector3.new(0, 0, 0))
		vector13.ttl = 1.5
		vector13.Frame.BackgroundColor3 = color8
	end
end
local function Update(p1, p2)
	local cframe = tick()
	local Simulate = p1.Simulate
	for i = #Simulate, 1, -1 do
		local var22 = Simulate[i]
		local p = var22.p
		local vector3 = var22.v + var22.a * p2
		local var4 = p + vector3 * p2
		local x_2 = var4.x
		local y_2 = var4.y
		local var5 = x_2 - p.x
		local var6 = y_2 - p.y
		local vector7 = (var5 * var5 + var6 * var6) ^ 0.5
		var22.p = var4
		var22.v = vector3
		local Frame = var22.Frame
		if not var22.Fake then
			if vector7 < 2 then
				Frame.Position = UDim2.new(0, x_2 - 1, 0, y_2 - 1)
				Frame.Size = UDim2.new(0, 2, 0, 2)
			else
				Frame.Position = UDim2.new(0, x_2 + (var5 - vector7) * 0.5, 0, y_2 + (var6 - vector7) * 0.5)
				Frame.Size = UDim2.new(0, vector7, 0, 3)
				Frame.Rotation = deg((atan2(var6, var5)))
			end
		end
		local color8 = cframe - var22.t
		local ttl = var22.ttl
		if ttl <= color8 then
			remove(Simulate, i)
			var22.Frame:Destroy()
		elseif ttl * 0.5 <= color8 then
			var22.Frame.Transparency = tanh((color8 - ttl * 0.5) / (ttl * 0.5)) * 1.313
		end
	end
	local Fireworks = p1.Fireworks
	for j = #Fireworks, 1, -1 do
		local v10
		local var11 = Fireworks[j]
		if cframe - var11.t >= var11.ttl then
			remove(Fireworks, j)
			var11.Frame:Destroy()
			if var11.OnDestroy then
				var11:OnDestroy()
			end
			local var12 = Color3.fromHSV(random(), 0.9, 0.9)
			for k = 1, 30 do
				local vector13
				local var15 = 200 + random() * 100
				local var16 = random()
				local var17 = random()
				if var17 < var16 then
					var17, vector13 = var16, var17
				else
					vector13 = var16
				end
				local vector18 = Single(p1, var11.p, vector2(var17 * var15 * cos(6.283185307179586 * vector13 / var17), var17 * var15 * sin(6.283185307179586 * vector13 / var17), 0), Vector3.new(0, 0, 0))
				vector18.ttl = 1
				vector18.Frame.BackgroundColor3 = var12
			end
			local color19 = Color3.fromHSV(random(), 0.9, 0.9)
			for n = 1, 10 do
				local v20
				local var22 = random()
				local var23 = random()
				if var23 < var22 then
					var23, v20 = var22, var23
				else
					v20 = var22
				end
				local vector24 = Single(p1, var11.p, vector2(var23 * 100 * cos(6.283185307179586 * v20 / var23), var23 * 100 * sin(6.283185307179586 * v20 / var23), 0), Vector3.new(0, 0, 0))
				vector24.ttl = 1.5
				vector24.Frame.BackgroundColor3 = color19
			end
		end
		local var26 = random()
		local var27 = random()
		if var27 < var26 then
			var27, v10 = var26, var27
		else
			v10 = var26
		end
		Single(p1, var11.p, vector2(var27 * 60 * cos(6.283185307179586 * v10 / var27), var27 * 60 * sin(6.283185307179586 * v10 / var27), 0), Vector3.new(0, 400, 0)).ttl = 0.8
	end
end
local function Clear(p1)
	for cframe, vector2 in next, p1.Simulate do
		vector2.Frame:Destroy()
	end
	p1.Simulate = {}
end
return {
	MakeState = MakeState,
	Single = Single,
	Firework = Firework,
	Explosion = Explosion,
	EasySimulate = function(p1, p2)
		local function Heartbeat(p12)
			Update(p1, p12)
		end
		local cframe = RunService.Heartbeat:Connect(Heartbeat)
		local function Finish()
			cframe:Disconnect()
			Clear(p1)
		end
		delay(p2, Finish)
	end,
	Update = Update,
	Clear = Clear
}
