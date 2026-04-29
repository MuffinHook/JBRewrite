local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Math = require(ReplicatedStorage.Module.Math)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local function ShortestAngle(angle, otherAngle)
	return (angle - otherAngle + math.pi) % math.tau - math.pi + otherAngle
end
local function LookAt(position, targetPosition)
	local Unit = (targetPosition - position).Unit
	local vector = Unit:Cross(Vector3.new(1, 0, 0))
	return CFrame.fromMatrix(position, vector, (vector:Cross(Unit)))
end
local SpotlightConstants = require(script.Parent.SpotlightConstants)
local Spotlight = {}
Spotlight.__index = Spotlight
function Spotlight.new(spotlightMotor)
	assert(spotlightMotor)
	local self = {}
	setmetatable(self, Spotlight)
	self.SpotlightMotor = spotlightMotor
	self.Maid = Maid.new()
	local Attachment = Instance.new("Attachment")
	self.Attachment = Attachment
	Attachment.Parent = self.SpotlightMotor.Part1
	local PointLight = Instance.new("PointLight")
	PointLight.Range = 32
	PointLight.Enabled = false
	PointLight.Parent = self.Attachment
	self.PointLight = PointLight
	local Beam = self.SpotlightMotor.Part0.Parent.Light.Beam
	Beam.Attachment1 = Attachment
	self.Beam = Beam
	self.SpringMouseLocation = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
	self.SpringAngles = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
	self.LastMouseWorldPosition = nil
	self.LastMouseWorldNormal = nil
	self:SetAngles((Vector3.new()))
	self:SetDistance(0)
	self:SetEnabled(false)
	self.LastUpdateAngleDistance = 0
	self.RemoteEvent = spotlightMotor:WaitForChild("RemoteEvent")
	local OnValue = spotlightMotor:WaitForChild("OnValue")
	self.OnValue = OnValue
	self.Maid:GiveTask(OnValue:GetPropertyChangedSignal("Value"):Connect(function()
		self:SetEnabled(OnValue.Value)
	end))
	local AngleValue = spotlightMotor:WaitForChild("AngleValue")
	self.Maid:GiveTask(AngleValue:GetPropertyChangedSignal("Value"):Connect(function()
		self:SetAngles(AngleValue.Value)
	end))
	local DistanceValue = spotlightMotor:WaitForChild("DistanceValue")
	self.Maid:GiveTask(DistanceValue:GetPropertyChangedSignal("Value"):Connect(function()
		self:SetDistance(DistanceValue.Value)
	end))
	self.PoliceValue = spotlightMotor:WaitForChild("PoliceValue")
	self.IgnoreList = { workspace.Vehicles, LocalPlayer.Character }
	return self
end
function Spotlight.TransformLocalMousePosition(self, mousePosition)
	return mousePosition
end
function Spotlight.ProjectMouseLocationToWorld(self, screenPosition)
	local vector = CurrentCamera:ViewportPointToRay(screenPosition.x, screenPosition.y)
	local _, hitPosition, hitNormal = RayCast.RayIgnoreNonCollideWithIgnoreList(vector.Origin, vector.Direction, 999, self.IgnoreList)
	return self:TransformLocalMousePosition(hitPosition), hitNormal
end
function Spotlight.GetMouseLocation(self)
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.875, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
function Spotlight.SetEnabled(self, isEnabled)
	if isEnabled then
		self.Maid.UpdateLoop = RunService.Heartbeat:Connect(function()
			self:Update()
		end)
	else
		self.Maid.UpdateLoop = nil
	end
	self.Beam.Enabled = isEnabled
	self.PointLight.Enabled = isEnabled
	self.Beam.Parent.Material = isEnabled and Enum.Material.Neon or Enum.Material.Plastic
end
function Spotlight.RequestToggle(self)
	if self.OnValue.Value then
		self.RemoteEvent:FireServer(SpotlightConstants.EVENT_DISABLE)
		self:UnhookLocal()
	else
		self.RemoteEvent:FireServer(SpotlightConstants.EVENT_ENABLE)
		self:HookLocal()
	end
end
function Spotlight.HookLocal(self)
	assert(self.Maid.LocalMaid == nil)
	self.Maid.LocalMaid = Maid.new()
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(64, 64, 0.1)
	Part.Anchored = true
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Parent = workspace
	local Decal = Instance.new("Decal")
	Decal.Texture = "rbxassetid://5477999115"
	Decal.Face = Enum.NormalId.Front
	Decal.Transparency = 0.5
	Decal.Parent = Part
	self.FakeCircle = Part
	local vector, hitNormal = self:ProjectMouseLocationToWorld((self:GetMouseLocation()))
	self.LastMouseWorldPosition = vector
	self.LastMouseWorldNormal = hitNormal
	self.Maid.LocalMaid:GiveTask(RunService.Heartbeat:Connect(function()
		self:UpdateMousePosition()
	end))
	self.Maid.LocalMaid:GiveTask(function()
		self.Attachment.Position = Vector3.new()
	end)
	self.Maid.LocalMaid:GiveTask(function()
		self.FakeCircle:Destroy()
		self.FakeCircle = nil
	end)
end
function Spotlight.UnhookLocal(self)
	if self.Maid.LocalMaid ~= nil then
		self.Maid.LocalMaid = nil
	end
end
function Spotlight.SetAngles(self, angles)
	self.SpringAngles:SetTarget(angles)
end
function Spotlight.SetDistance(self, distance)
	self.Distance = distance
end
function Spotlight.UpdateMousePosition(self)
	local targetWorldPosition, targetNormal
	if InputUtils.isTouch() then
		local touchWorldPosition, touchNormal = self:ProjectMouseLocationToWorld((self:GetMouseLocation()))
		targetWorldPosition = touchWorldPosition
		targetNormal = touchNormal
	elseif InputUtils.isGamepad() then
		local gamepadWorldPosition, gamepadNormal = self:ProjectMouseLocationToWorld((self:GetMouseLocation()))
		targetWorldPosition = gamepadWorldPosition
		targetNormal = gamepadNormal
	elseif UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or not self.LastMouseWorldPosition then
		local mouseWorldPosition, mouseNormal = self:ProjectMouseLocationToWorld((self:GetMouseLocation()))
		self.LastMouseWorldPosition = mouseWorldPosition
		self.LastMouseWorldNormal = mouseNormal
		targetWorldPosition = mouseWorldPosition
		targetNormal = mouseNormal
	else
		targetWorldPosition = self.LastMouseWorldPosition
		targetNormal = self.LastMouseWorldNormal
	end
	local directionToMouse = targetWorldPosition - self.Beam.Attachment0.WorldPosition
	local Magnitude = directionToMouse.Magnitude
	if Magnitude > 160 then
		Magnitude = 160
		if self.FakeCircle.Parent ~= nil then
			self.FakeCircle.Parent = nil
		end
		targetWorldPosition = self.Beam.Attachment0.WorldPosition + self.SpotlightMotor.Part1.CFrame.LookVector * 160
	else
		local spotlightRayPosition = directionToMouse.Unit * Magnitude + self.Beam.Attachment0.WorldPosition
		self.FakeCircle.CFrame = CFrame.new(spotlightRayPosition, spotlightRayPosition + targetNormal)
		if self.FakeCircle.Parent ~= workspace then
			self.FakeCircle.Parent = workspace
		end
	end
	self:SetDistance(Magnitude)
	local eulerX, eulerY, eulerZ = self.SpotlightMotor.Part1.CFrame:ToObjectSpace(LookAt(self.SpotlightMotor.Part1.Position, targetWorldPosition)):ToEulerAnglesXYZ()
	local x = self.SpringAngles:Update().x
	local newAngles = Vector3.new((eulerX - x + math.pi) % math.tau - math.pi + x, eulerY, eulerZ)
	self:SetAngles(newAngles)
	local currentTime = tick()
	if currentTime - self.LastUpdateAngleDistance > 0.125 then
		self.LastUpdateAngleDistance = currentTime
		self.RemoteEvent:FireServer(SpotlightConstants.EVENT_UPDATE_ANGLE_DISTANCE, newAngles, Magnitude)
	end
end
function Spotlight.Update(self)
	local anglesCFrame = CFrame.fromEulerAnglesXYZ(self.SpringAngles:Update().X, self.SpringAngles:Update().Y, self.SpringAngles:Update().Z)
	local Distance = self.Distance
	self.SpotlightMotor.C1 = anglesCFrame
	local currentPositionCFrame = self.SpotlightMotor.Part0.CFrame
	self.Attachment.WorldPosition = currentPositionCFrame.p + currentPositionCFrame.LookVector * (Distance + 4)
	self.Beam.TextureLength = Distance + 4
	self.Beam.Width1 = Distance * 2 / 3
	if self.Maid.LocalMaid == nil and self.PoliceValue.Value then
		local Character = LocalPlayer.Character
		if Character ~= nil then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid ~= nil then
				local RootPart = Humanoid.RootPart
				if RootPart ~= nil then
					self.IsLocalInSpotlight = Math.DoesFixedConeIntersectSphere(currentPositionCFrame.p, currentPositionCFrame.LookVector, Distance + 4, 0.23561944901923448, RootPart.Position, 3)
				end
			end
		end
	end
end
function Spotlight.Destroy(self)
	self.IsLocalInSpotlight = false
	self.Maid:Destroy()
	self.Maid = nil
end
return Spotlight
