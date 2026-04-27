local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local PowerPlantCore = {}
PowerPlantCore.__index = PowerPlantCore
function PowerPlantCore.new(model)
	local self = {}
	setmetatable(self, PowerPlantCore)
	self.Model = model
	local Spinner = self.Model:FindFirstChild("Spinner")
	self.Spinner = Spinner
	RxInstanceUtils.yieldForProperty(Spinner, "PrimaryPart")
	assert(self.Spinner.PrimaryPart, "spinner is missing PrimaryPart")
	self.Spinner.PrimaryPart.CFrame = CFrame.new(self.Spinner.PrimaryPart.Position)
	self.Maid = Maid.new()
	self.Maid:GiveTask(RunService.Heartbeat:Connect(function(deltaTime)
		self:Heartbeat(deltaTime)
	end))
	return self
end
function PowerPlantCore.Heartbeat(self, deltaTime)
	local Magnitude = (CurrentCamera.CFrame.Position - self.Spinner.PrimaryPart.Position).Magnitude
	if not (Magnitude * Magnitude > 250000) then
		debug.profilebegin("PowerPlant Core")
		self.Spinner:SetPrimaryPartCFrame(self.Spinner.PrimaryPart.CFrame * CFrame.Angles(0, deltaTime, 0))
		local colorCycleOffset = math.cos(tick() * 2) * 20
		self.Model.Part.Color = Color3.fromRGB(colorCycleOffset + 129, colorCycleOffset + 125, colorCycleOffset + 152)
		self.Model.PowerWire.Color = Color3.fromRGB(colorCycleOffset + 129, colorCycleOffset + 125, colorCycleOffset + 152)
		debug.profileend()
	end
end
function PowerPlantCore.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return PowerPlantCore
