local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local function GetRootPart() --[[ Line: 11 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid == nil then
			return nil
		else
			return Humanoid.RootPart
		end
	end
end
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 27 | Upvalues: t (copy), Maid (copy), Signal (copy), Spring (copy), RunService (copy) ]]
	assert(p1 ~= nil)
	assert(p2 ~= nil)
	local t2 = {}
	setmetatable(t2, t)
	t2.Maid = Maid.new()
	t2.Position = p1
	t2.Duration = assert(p2.Duration)
	t2.MaxRadius = assert(p2.MaxRadius)
	t2.FlagPastLocalPlayer = false
	t2.FlagFirstPass = false
	t2.OnPastLocalPlayer = Signal.new()
	t2.Maid:GiveTask(t2.OnPastLocalPlayer)
	t2.OnDestroyed = Signal.new()
	t2.Maid:GiveTask(t2.OnDestroyed)
	t2.SpringBlur = Spring.new(0, 0, 1, 1)
	t2.SpringColor = Spring.new(0, 0, 1, 0.5)
	t2.FxDisabled = p2.FxDisabled == true
	t2.Color = p2.Color or Color3.fromRGB(234, 117, 90)
	t2.TintColor = p2.TintColor or p2.Color or Color3.fromRGB(255, 200, 0)
	t2.Power = p2.Power or 10
	t2.StartTransparency = p2.StartTransparency
	t2.EndTransparency = p2.EndTransparency
	t2:CreateFx()
	t2:CreatePart()
	t2.BornAt = tick()
	t2.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 58 | Upvalues: t2 (copy) ]]
		t2:Update()
	end))
	return t2
end
function t.Update(p1) --[[ Line: 64 | Upvalues: LocalPlayer (copy), Audio (copy) ]]
	local v1 = (tick() - p1.BornAt) / p1.Duration
	if v1 >= 1 then
		v1 = 1
	end
	local v2 = v1 * p1.MaxRadius
	local v3 = false
	local Character = LocalPlayer.Character
	local v4
	if Character == nil then
		v4 = nil
	else
		local Humanoid = Character:FindFirstChild("Humanoid")
		v4 = if Humanoid == nil then nil else Humanoid.RootPart
	end
	if v4 ~= nil then
		v3 = (p1.Position - v4.Position).Magnitude < v2
	end
	if p1.FlagPastLocalPlayer ~= v3 then
		p1.FlagPastLocalPlayer = v3
		if v3 == true and p1.FlagFirstPass == false then
			p1.FlagFirstPass = true
			if not p1.FxDisabled then
				p1.SpringBlur:Accelerate(200 * p1.Power)
				p1.SpringColor:Accelerate(400 * p1.Power)
				Audio.ObjectLocal(LocalPlayer, 3217484827)
			end
			p1.OnPastLocalPlayer:Fire(p1.Position - v4.Position)
		end
	end
	local v5 = p1.SpringBlur:Update()
	local v6 = v5 >= 0.01
	if v6 then
		p1.Blur.Size = v5
		local v7 = 1 - math.clamp(v5 / 10, 0, 1) * 0.2
		if v7 < 0.999 then
			p1.OrangeFrame.Visible = true
		else
			p1.OrangeFrame.Visible = false
		end
		p1.OrangeFrame.Transparency = v7
	end
	if p1.Blur.Enabled ~= v6 then
		p1.Blur.Enabled = v6
	end
	local v8 = p1.SpringColor:Update()
	local v9 = v8 > 0.01
	if v9 then
		local v10 = math.clamp(v8 / 10, 0, 1)
		p1.ColorCorrection.Saturation = v10 * -1
		p1.ColorCorrection.TintColor = Color3.new((1 - p1.TintColor.r) * (1 - v10) + p1.TintColor.r, (1 - p1.TintColor.g) * (1 - v10) + p1.TintColor.g, (1 - p1.TintColor.b) * (1 - v10) + p1.TintColor.b)
	end
	if p1.ColorCorrection.Enabled ~= v9 then
		p1.ColorCorrection.Enabled = v9
	end
	p1.Mesh.Scale = Vector3.new(1, 1, 1) * v2 * 2
	if p1.StartTransparency and p1.EndTransparency then
		p1.Part.Transparency = p1.StartTransparency + (p1.EndTransparency - p1.StartTransparency) * v1
	end
	if v1 == 1 and (v6 == false and v9 == false) then
		p1:Destroy()
	end
end
function t.CreateFx(p1) --[[ Line: 141 | Upvalues: LocalPlayer (copy) ]]
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Enabled = false
	BlurEffect.Parent = game:GetService("Lighting")
	p1.Blur = BlurEffect
	p1.Maid:GiveTask(p1.Blur)
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.Enabled = false
	ColorCorrectionEffect.Parent = game:GetService("Lighting")
	p1.ColorCorrection = ColorCorrectionEffect
	p1.Maid:GiveTask(p1.ColorCorrection)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = LocalPlayer.PlayerGui
	p1.Maid:GiveTask(ScreenGui)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.BackgroundColor3 = p1.Color
	Frame.Visible = false
	Frame.Parent = ScreenGui
	p1.OrangeFrame = Frame
end
function t.CreatePart(p1) --[[ Line: 168 ]]
	local Part = Instance.new("Part")
	Part.Color = p1.Color
	Part.Size = Vector3.new(1, 1, 1)
	Part.Material = Enum.Material.Neon
	Part.CastShadow = false
	Part.Anchored = true
	Part.CFrame = CFrame.new(p1.Position)
	Part.Parent = workspace
	p1.Maid:GiveTask(Part)
	local SpecialMesh = Instance.new("SpecialMesh")
	SpecialMesh.MeshType = Enum.MeshType.Sphere
	SpecialMesh.Scale = Vector3.new(1, 1, 1)
	SpecialMesh.Parent = Part
	p1.Mesh = SpecialMesh
	p1.Part = Part
end
function t.Destroy(p1) --[[ Line: 190 ]]
	p1.OnDestroyed:Fire()
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t