-- Reviewed by Claude
-- variables reassigned
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local function GetRootPart()
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
function t.new(position, options)
	assert(position ~= nil)
	assert(options ~= nil)
	local shockwave = {}
	setmetatable(shockwave, t)
	shockwave.Maid = Maid.new()
	shockwave.Position = position
	shockwave.Duration = assert(options.Duration)
	shockwave.MaxRadius = assert(options.MaxRadius)
	shockwave.FlagPastLocalPlayer = false
	shockwave.FlagFirstPass = false
	shockwave.OnPastLocalPlayer = Signal.new()
	shockwave.Maid:GiveTask(shockwave.OnPastLocalPlayer)
	shockwave.OnDestroyed = Signal.new()
	shockwave.Maid:GiveTask(shockwave.OnDestroyed)
	shockwave.SpringBlur = Spring.new(0, 0, 1, 1)
	shockwave.SpringColor = Spring.new(0, 0, 1, 0.5)
	shockwave.FxDisabled = options.FxDisabled == true
	shockwave.Color = options.Color or Color3.fromRGB(234, 117, 90)
	shockwave.TintColor = options.TintColor or options.Color or Color3.fromRGB(255, 200, 0)
	shockwave.Power = options.Power or 10
	shockwave.StartTransparency = options.StartTransparency
	shockwave.EndTransparency = options.EndTransparency
	shockwave:CreateFx()
	shockwave:CreatePart()
	shockwave.BornAt = tick()
	shockwave.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		shockwave:Update()
	end))
	return shockwave
end
function t.Update(self)
	local progress = (tick() - self.BornAt) / self.Duration
	if progress >= 1 then
		progress = 1
	end
	local currentRadius = progress * self.MaxRadius
	local isInRadius = false
	local Character = LocalPlayer.Character
	local rootPart
	if Character == nil then
		rootPart = nil
	else
		local Humanoid = Character:FindFirstChild("Humanoid")
		rootPart = if Humanoid == nil then nil else Humanoid.RootPart
	end
	if rootPart ~= nil then
		isInRadius = (self.Position - rootPart.Position).Magnitude < currentRadius
	end
	if self.FlagPastLocalPlayer ~= isInRadius then
		self.FlagPastLocalPlayer = isInRadius
		if isInRadius == true and self.FlagFirstPass == false then
			self.FlagFirstPass = true
			if not self.FxDisabled then
				self.SpringBlur:Accelerate(200 * self.Power)
				self.SpringColor:Accelerate(400 * self.Power)
				Audio.ObjectLocal(LocalPlayer, 3217484827)
			end
			self.OnPastLocalPlayer:Fire(self.Position - rootPart.Position)
		end
	end
	local blurSize = self.SpringBlur:Update()
	local isBlurActive = blurSize >= 0.01
	if isBlurActive then
		self.Blur.Size = blurSize
		local blurTransparency = 1 - math.clamp(blurSize / 10, 0, 1) * 0.2
		if blurTransparency < 0.999 then
			self.OrangeFrame.Visible = true
		else
			self.OrangeFrame.Visible = false
		end
		self.OrangeFrame.Transparency = blurTransparency
	end
	if self.Blur.Enabled ~= isBlurActive then
		self.Blur.Enabled = isBlurActive
	end
	local colorSpring = self.SpringColor:Update()
	local isColorActive = colorSpring > 0.01
	if isColorActive then
		local colorSaturationFactor = math.clamp(colorSpring / 10, 0, 1)
		self.ColorCorrection.Saturation = colorSaturationFactor * -1
		self.ColorCorrection.TintColor = Color3.new((1 - self.TintColor.r) * (1 - colorSaturationFactor) + self.TintColor.r, (1 - self.TintColor.g) * (1 - colorSaturationFactor) + self.TintColor.g, (1 - self.TintColor.b) * (1 - colorSaturationFactor) + self.TintColor.b)
	end
	if self.ColorCorrection.Enabled ~= isColorActive then
		self.ColorCorrection.Enabled = isColorActive
	end
	self.Mesh.Scale = Vector3.new(1, 1, 1) * currentRadius * 2
	if self.StartTransparency and self.EndTransparency then
		self.Part.Transparency = self.StartTransparency + (self.EndTransparency - self.StartTransparency) * progress
	end
	if progress == 1 and (isBlurActive == false and isColorActive == false) then
		self:Destroy()
	end
end
function t.CreateFx(self)
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Enabled = false
	BlurEffect.Parent = game:GetService("Lighting")
	self.Blur = BlurEffect
	self.Maid:GiveTask(self.Blur)
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.Enabled = false
	ColorCorrectionEffect.Parent = game:GetService("Lighting")
	self.ColorCorrection = ColorCorrectionEffect
	self.Maid:GiveTask(self.ColorCorrection)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = LocalPlayer.PlayerGui
	self.Maid:GiveTask(ScreenGui)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.BackgroundColor3 = self.Color
	Frame.Visible = false
	Frame.Parent = ScreenGui
	self.OrangeFrame = Frame
end
function t.CreatePart(self)
	local Part = Instance.new("Part")
	Part.Color = self.Color
	Part.Size = Vector3.new(1, 1, 1)
	Part.Material = Enum.Material.Neon
	Part.CastShadow = false
	Part.Anchored = true
	Part.CFrame = CFrame.new(self.Position)
	Part.Parent = workspace
	self.Maid:GiveTask(Part)
	local SpecialMesh = Instance.new("SpecialMesh")
	SpecialMesh.MeshType = Enum.MeshType.Sphere
	SpecialMesh.Scale = Vector3.new(1, 1, 1)
	SpecialMesh.Parent = Part
	self.Mesh = SpecialMesh
	self.Part = Part
end
function t.Destroy(self)
	self.OnDestroyed:Fire()
	self.Maid:Destroy()
	self.Maid = nil
end
return t
