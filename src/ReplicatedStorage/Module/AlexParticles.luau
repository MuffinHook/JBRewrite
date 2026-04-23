local RunService = game:GetService("RunService")
local v1 = CFrame.new
local Angles = CFrame.Angles
local v2 = Vector3.new
v1(0, 0, 0)
local v3 = Vector3.new(0, 0, 0)
local Dot = v3.Dot
local Cross = v3.Cross
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
local function RandomVector(p1) --[[ Line: 15 | Upvalues: random (copy), cos (copy), sin (copy), v2 (copy) ]]
	local v1 = random()
	local v22 = random()
	local v3
	if v22 < v1 then
		v22, v3 = v1, v22
	else
		v3 = v1
	end
	return v2(v22 * p1 * cos(6.283185307179586 * v3 / v22), v22 * p1 * sin(6.283185307179586 * v3 / v22), 0)
end
local function MakeState() --[[ Line: 27 ]]
	return {
		Frame = nil,
		Simulate = {},
		Fireworks = {}
	}
end
local function MakeParticle() --[[ Line: 34 ]]
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
local function Single(p1, p2, p3, p4) --[[ Line: 45 | Upvalues: insert (copy) ]]
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
local function Firework(p1, p2, p3, p4) --[[ Line: 58 | Upvalues: Single (ref), insert (copy) ]]
	local v1 = Single(p1, p2, p3, p4)
	v1.Frame.Visible = false
	insert(p1.Fireworks, v1)
	return v1
end
local function Explosion(p1, p2) --[[ Line: 64 | Upvalues: random (copy), Single (ref), cos (copy), sin (copy), v2 (copy) ]]
	local v1 = Color3.fromHSV(random(), 0.9, 0.9)
	for i = 1, 30 do
		local v22
		local v4 = 200 + random() * 100
		local v5 = random()
		local v6 = random()
		if v6 < v5 then
			v6, v22 = v5, v6
		else
			v22 = v5
		end
		local v7 = Single(p1, p2, v2(v6 * v4 * cos(6.283185307179586 * v22 / v6), v6 * v4 * sin(6.283185307179586 * v22 / v6), 0), Vector3.new(0, 0, 0))
		v7.ttl = 1
		v7.Frame.BackgroundColor3 = v1
	end
	local v8 = Color3.fromHSV(random(), 0.9, 0.9)
	for j = 1, 10 do
		local v9
		local v11 = random()
		local v12 = random()
		if v12 < v11 then
			v12, v9 = v11, v12
		else
			v9 = v11
		end
		local v13 = Single(p1, p2, v2(v12 * 100 * cos(6.283185307179586 * v9 / v12), v12 * 100 * sin(6.283185307179586 * v9 / v12), 0), Vector3.new(0, 0, 0))
		v13.ttl = 1.5
		v13.Frame.BackgroundColor3 = v8
	end
end
local function Update(p1, p2) --[[ Line: 78 | Upvalues: atan2 (copy), deg (copy), remove (copy), tanh (copy), random (copy), Single (ref), cos (copy), sin (copy), v2 (copy) ]]
	local v1 = tick()
	local Simulate = p1.Simulate
	for i = #Simulate, 1, -1 do
		local v22 = Simulate[i]
		local p = v22.p
		local v3 = v22.v + v22.a * p2
		local v4 = p + v3 * p2
		local x_2 = v4.x
		local y_2 = v4.y
		local v5 = x_2 - p.x
		local v6 = y_2 - p.y
		local v7 = (v5 * v5 + v6 * v6) ^ 0.5
		v22.p = v4
		v22.v = v3
		local Frame = v22.Frame
		if not v22.Fake then
			if v7 < 2 then
				Frame.Position = UDim2.new(0, x_2 - 1, 0, y_2 - 1)
				Frame.Size = UDim2.new(0, 2, 0, 2)
			else
				Frame.Position = UDim2.new(0, x_2 + (v5 - v7) * 0.5, 0, y_2 + (v6 - v7) * 0.5)
				Frame.Size = UDim2.new(0, v7, 0, 3)
				Frame.Rotation = deg((atan2(v6, v5)))
			end
		end
		local v8 = v1 - v22.t
		local ttl = v22.ttl
		if ttl <= v8 then
			remove(Simulate, i)
			v22.Frame:Destroy()
		elseif ttl * 0.5 <= v8 then
			v22.Frame.Transparency = tanh((v8 - ttl * 0.5) / (ttl * 0.5)) * 1.313
		end
	end
	local Fireworks = p1.Fireworks
	for j = #Fireworks, 1, -1 do
		local v10
		local v11 = Fireworks[j]
		if v1 - v11.t >= v11.ttl then
			remove(Fireworks, j)
			v11.Frame:Destroy()
			if v11.OnDestroy then
				v11:OnDestroy()
			end
			local v12 = Color3.fromHSV(random(), 0.9, 0.9)
			for k = 1, 30 do
				local v13
				local v15 = 200 + random() * 100
				local v16 = random()
				local v17 = random()
				if v17 < v16 then
					v17, v13 = v16, v17
				else
					v13 = v16
				end
				local v18 = Single(p1, v11.p, v2(v17 * v15 * cos(6.283185307179586 * v13 / v17), v17 * v15 * sin(6.283185307179586 * v13 / v17), 0), Vector3.new(0, 0, 0))
				v18.ttl = 1
				v18.Frame.BackgroundColor3 = v12
			end
			local v19 = Color3.fromHSV(random(), 0.9, 0.9)
			for n = 1, 10 do
				local v20
				local v22 = random()
				local v23 = random()
				if v23 < v22 then
					v23, v20 = v22, v23
				else
					v20 = v22
				end
				local v24 = Single(p1, v11.p, v2(v23 * 100 * cos(6.283185307179586 * v20 / v23), v23 * 100 * sin(6.283185307179586 * v20 / v23), 0), Vector3.new(0, 0, 0))
				v24.ttl = 1.5
				v24.Frame.BackgroundColor3 = v19
			end
		end
		local v26 = random()
		local v27 = random()
		if v27 < v26 then
			v27, v10 = v26, v27
		else
			v10 = v26
		end
		Single(p1, v11.p, v2(v27 * 60 * cos(6.283185307179586 * v10 / v27), v27 * 60 * sin(6.283185307179586 * v10 / v27), 0), Vector3.new(0, 400, 0)).ttl = 0.8
	end
end
local function Clear(p1) --[[ Line: 144 ]]
	for v1, v2 in next, p1.Simulate do
		v2.Frame:Destroy()
	end
	p1.Simulate = {}
end
return {
	MakeState = MakeState,
	Single = Single,
	Firework = Firework,
	Explosion = Explosion,
	EasySimulate = function(p1, p2) --[[ Name: EasySimulate | Line: 150 | Upvalues: Update (ref), RunService (copy), Clear (ref) ]]
		local function Heartbeat(p12) --[[ Line: 151 | Upvalues: Update (ref), p1 (copy) ]]
			Update(p1, p12)
		end
		local v1 = RunService.Heartbeat:Connect(Heartbeat)
		local function Finish() --[[ Line: 155 | Upvalues: v1 (copy), Clear (ref), p1 (copy) ]]
			v1:Disconnect()
			Clear(p1)
		end
		delay(p2, Finish)
	end,
	Update = Update,
	Clear = Clear
}