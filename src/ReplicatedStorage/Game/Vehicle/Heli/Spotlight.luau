-- Reviewed by Claude
-- variables reassigned
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
local function ShortestAngle(p1, p2)
	return (p1 - p2 + math.pi) % 6.283185307179586 - math.pi + p2
end
local function LookAt(p1, p2)
	local Unit = (p2 - p1).Unit
	local vector = Unit:Cross(Vector3.new(1, 0, 0))
	return CFrame.fromMatrix(p1, vector, (vector:Cross(Unit)))
end
local SpotlightConstants = require(script.Parent.SpotlightConstants)
local t = {}
t.__index = t
function t.new(p1)
	assert(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.SpotlightMotor = p1
	t2.Maid = Maid.new()
	local Attachment = Instance.new("Attachment")
	t2.Attachment = Attachment
	Attachment.Parent = t2.SpotlightMotor.Part1
	local PointLight = Instance.new("PointLight")
	PointLight.Range = 32
	PointLight.Enabled = false
	PointLight.Parent = t2.Attachment
	t2.PointLight = PointLight
	local Beam = t2.SpotlightMotor.Part0.Parent.Light.Beam
	Beam.Attachment1 = Attachment
	t2.Beam = Beam
	t2.SpringMouseLocation = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
	t2.SpringAngles = Spring.new(Vector3.new(), Vector3.new(), 0.8, 20)
	t2.LastMouseWorldPosition = nil
	t2.LastMouseWorldNormal = nil
	t2:SetAngles((Vector3.new()))
	t2:SetDistance(0)
	t2:SetEnabled(false)
	t2.LastUpdateAngleDistance = 0
	t2.RemoteEvent = p1:WaitForChild("RemoteEvent")
	local OnValue = p1:WaitForChild("OnValue")
	t2.OnValue = OnValue
	t2.Maid:GiveTask(OnValue:GetPropertyChangedSignal("Value"):Connect(function()
		t2:SetEnabled(OnValue.Value)
	end))
	local AngleValue = p1:WaitForChild("AngleValue")
	t2.Maid:GiveTask(AngleValue:GetPropertyChangedSignal("Value"):Connect(function()
		t2:SetAngles(AngleValue.Value)
	end))
	local DistanceValue = p1:WaitForChild("DistanceValue")
	t2.Maid:GiveTask(DistanceValue:GetPropertyChangedSignal("Value"):Connect(function()
		t2:SetDistance(DistanceValue.Value)
	end))
	t2.PoliceValue = p1:WaitForChild("PoliceValue")
	t2.IgnoreList = { workspace.Vehicles, LocalPlayer.Character }
	return t2
end
function t.TransformLocalMousePosition(p1, p2)
	return p2
end
function t.ProjectMouseLocationToWorld(p1, p2)
	local vector = CurrentCamera:ViewportPointToRay(p2.x, p2.y)
	local _, cframe2, cframe3 = RayCast.RayIgnoreNonCollideWithIgnoreList(vector.Origin, vector.Direction, 999, p1.IgnoreList)
	return p1:TransformLocalMousePosition(cframe2), cframe3
end
function t.GetMouseLocation(p1)
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.875, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
function t.SetEnabled(p1, p2)
	if p2 then
		p1.Maid.UpdateLoop = RunService.Heartbeat:Connect(function()
			p1:Update()
		end)
	else
		p1.Maid.UpdateLoop = nil
	end
	p1.Beam.Enabled = p2
	p1.PointLight.Enabled = p2
	p1.Beam.Parent.Material = p2 and Enum.Material.Neon or Enum.Material.Plastic
end
function t.RequestToggle(p1)
	if p1.OnValue.Value then
		p1.RemoteEvent:FireServer(SpotlightConstants.EVENT_DISABLE)
		p1:UnhookLocal()
	else
		p1.RemoteEvent:FireServer(SpotlightConstants.EVENT_ENABLE)
		p1:HookLocal()
	end
end
function t.HookLocal(p1)
	assert(p1.Maid.LocalMaid == nil)
	p1.Maid.LocalMaid = Maid.new()
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
	p1.FakeCircle = Part
	local vector, cframe2 = p1:ProjectMouseLocationToWorld((p1:GetMouseLocation()))
	p1.LastMouseWorldPosition = vector
	p1.LastMouseWorldNormal = cframe2
	p1.Maid.LocalMaid:GiveTask(RunService.Heartbeat:Connect(function()
		p1:UpdateMousePosition()
	end))
	p1.Maid.LocalMaid:GiveTask(function()
		p1.Attachment.Position = Vector3.new()
	end)
	p1.Maid.LocalMaid:GiveTask(function()
		p1.FakeCircle:Destroy()
		p1.FakeCircle = nil
	end)
end
function t.UnhookLocal(p1)
	if p1.Maid.LocalMaid ~= nil then
		p1.Maid.LocalMaid = nil
	end
end
function t.SetAngles(p1, p2)
	p1.SpringAngles:SetTarget(p2)
end
function t.SetDistance(p1, p2)
	p1.Distance = p2
end
function t.UpdateMousePosition(p1)
	local vector, cframe2
	if InputUtils.isTouch() then
		local cframe3, v4 = p1:ProjectMouseLocationToWorld((p1:GetMouseLocation()))
		vector = cframe3
		cframe2 = v4
	elseif InputUtils.isGamepad() then
		local v5, v6 = p1:ProjectMouseLocationToWorld((p1:GetMouseLocation()))
		vector = v5
		cframe2 = v6
	elseif UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or not p1.LastMouseWorldPosition then
		local v7, v8 = p1:ProjectMouseLocationToWorld((p1:GetMouseLocation()))
		p1.LastMouseWorldPosition = v7
		p1.LastMouseWorldNormal = v8
		vector = v7
		cframe2 = v8
	else
		vector = p1.LastMouseWorldPosition
		cframe2 = p1.LastMouseWorldNormal
	end
	local directionToMouse = vector - p1.Beam.Attachment0.WorldPosition
	local Magnitude = directionToMouse.Magnitude
	if Magnitude > 160 then
		Magnitude = 160
		if p1.FakeCircle.Parent ~= nil then
			p1.FakeCircle.Parent = nil
		end
		vector = p1.Beam.Attachment0.WorldPosition + p1.SpotlightMotor.Part1.CFrame.LookVector * 160
	else
		local spotlightRayPosition = directionToMouse.Unit * Magnitude + p1.Beam.Attachment0.WorldPosition
		p1.FakeCircle.CFrame = CFrame.new(spotlightRayPosition, spotlightRayPosition + cframe2)
		if p1.FakeCircle.Parent ~= workspace then
			p1.FakeCircle.Parent = workspace
		end
	end
	p1:SetDistance(Magnitude)
	local v11, v12, v13 = p1.SpotlightMotor.Part1.CFrame:ToObjectSpace(LookAt(p1.SpotlightMotor.Part1.Position, vector)):ToEulerAnglesXYZ()
	local x = p1.SpringAngles:Update().x
	local newAngles = Vector3.new((v11 - x + math.pi) % 6.283185307179586 - math.pi + x, v12, v13)
	p1:SetAngles(newAngles)
	local currentTime = tick()
	if currentTime - p1.LastUpdateAngleDistance > 0.125 then
		p1.LastUpdateAngleDistance = currentTime
		p1.RemoteEvent:FireServer(SpotlightConstants.EVENT_UPDATE_ANGLE_DISTANCE, newAngles, Magnitude)
	end
end
function t.Update(p1)
	local vector = p1.SpringAngles:Update()
	local cframe2 = CFrame.fromEulerAnglesXYZ(vector.X, vector.Y, vector.Z)
	local Distance = p1.Distance
	p1.SpotlightMotor.C1 = cframe2
	local cframe3 = p1.SpotlightMotor.Part0.CFrame
	p1.Attachment.WorldPosition = cframe3.p + cframe3.LookVector * (Distance + 4)
	p1.Beam.TextureLength = Distance + 4
	p1.Beam.Width1 = Distance * 2 / 3
	if p1.Maid.LocalMaid == nil and p1.PoliceValue.Value then
		local Character = LocalPlayer.Character
		if Character ~= nil then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid ~= nil then
				local RootPart = Humanoid.RootPart
				if RootPart ~= nil then
					p1.IsLocalInSpotlight = Math.DoesFixedConeIntersectSphere(cframe3.p, cframe3.LookVector, Distance + 4, 0.23561944901923448, RootPart.Position, 3)
				end
			end
		end
	end
end
function t.Destroy(p1)
	p1.IsLocalInSpotlight = false
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
