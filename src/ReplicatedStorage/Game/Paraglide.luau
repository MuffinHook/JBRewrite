-- Reviewed by Claude
local RunService = game:GetService("RunService")
game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Audio = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local C4Consts = require(ReplicatedStorage.Game.C4.C4Consts)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v1 = nil
local v2 = nil
local v3 = Vector3.new
local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local function fpor2(p1, p2, ...)
	local magnitude = p2.magnitude
	local unit = p2.unit
	local v1 = 0
	local t = { ... }
	TableUtils.concatInPlace(t, CollectionService:GetTagged(C4Consts.TAG_NAME))
	if workspace:FindFirstChild("NetworkFixPart1") then
		table.insert(t, workspace.NetworkFixPart1)
	end
	local count, v2 = 0, p1
	while true do
		local v32, v4
		count = count + 1
		local v6, v7, v8 = FindPartOnRayWithIgnoreList(workspace, Ray.new(v2, unit * (magnitude - v1)), t, false, true)
		if v6 then
			v6 = v6.CanCollide
		end
		local v9 = v6
		if not v6 then
			table.insert(t, v9)
		end
		v1 = (p1 - v7).magnitude
		if v6 or (magnitude - v1 <= 0.001 or count > 4) then
			if v9 then
				v32 = v7
				v4 = v8
			else
				v4 = v3
				v32 = p1 + unit * magnitude
			end
			return v9, v32, v4
		end
		v2 = v7
	end
end
local v4 = nil
local v5 = nil
local v6 = Signal.new()
local v7 = Signal.new()
local v8 = nil
local function IsFlying()
	return v8 ~= nil
end
local function UpdateParachute()
	local HumanoidRootPart = v8.HumanoidRootPart
	local v1 = CurrentCamera.CFrame * CFrame.Angles(0.2, 0, 0)
	local v2 = math.clamp(HumanoidRootPart.RotVelocity.y, -4, 4)
	local v42 = math.abs((v1.LookVector:Dot(Vector3.new(0, 1, 0))))
	local v5 = Vector3.new(v1.LookVector.X, 0, v1.lookVector.Z)
	v8.Velocity.Velocity = v5 * 60 * math.max(0.5, v42) + Vector3.new(0, v42, 0) * -40
	v8.Gyro.CFrame = CFrame.new(Vector3.new(), v1.lookVector) * CFrame.new(0, 0, v2 * 0.125)
	local v6, _ = fpor2(HumanoidRootPart.Position, Vector3.new(0, -4, 0), HumanoidRootPart.Parent)
	if v6 and not v6:IsDescendantOf(workspace.Vehicles) then
		v4()
	end
end
local function RawParachute()
	if v8 then
		print("Already has parachute")
		return false
	else
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				local PrimaryPart = Character.PrimaryPart
				if PrimaryPart then
					if Humanoid.PlatformStand or Humanoid.Sit then
						return false
					else
						Humanoid.PlatformStand = true
						Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
						v8 = {
							Type = "Parachute"
						}
						local BodyGyro = Instance.new("BodyGyro")
						BodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
						BodyGyro.CFrame = CurrentCamera.CFrame * CFrame.Angles(0.2, 0, 0)
						BodyGyro.Parent = PrimaryPart
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
						BodyVelocity.Velocity = Vector3.new(0, -1, 0)
						BodyVelocity.Parent = PrimaryPart
						v8.Gyro = BodyGyro
						v8.Velocity = BodyVelocity
						v8.HumanoidRootPart = PrimaryPart
						v8.Humanoid = Humanoid
						Audio.ObjectLocal(Humanoid.RootPart, 4482070135)
						v8.Loop = RunService.Heartbeat:Connect(UpdateParachute)
						return true
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
end
local function RawParachuteStop()
	if v8 and v8.Type == "Parachute" then
		v8.Gyro:Destroy()
		v8.Velocity:Destroy()
		v8.Loop:Disconnect()
		v8.Humanoid.PlatformStand = false
		v8 = nil
		v6:Fire()
		return true
	else
		return false
	end
end
local function Parachute()
	if not RawParachute() then
		return false
	end
	v1:FireServer("g" .. ("t8x"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("nmkqmqyms"):sub(4, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ydl"):sub(2, 2):reverse() .. "sf")
end
v4 = function()
	local v12
	if v8 and v8.Type == "Parachute" then
		v8.Gyro:Destroy()
		v8.Velocity:Destroy()
		v8.Loop:Disconnect()
		v8.Humanoid.PlatformStand = false
		v8 = nil
		v6:Fire()
		v12 = true
	else
		v12 = false
	end
	if not v12 then
		return false
	end
	v1:FireServer("q" .. ("ieaznve"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("s9ls"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("b83yluf"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("ek53zzt1"):sub(5, 5):reverse():reverse():reverse() .. "uem")
end
local function UpdateGlider()
	local HumanoidRootPart = v8.HumanoidRootPart
	local v1 = CurrentCamera.CFrame * CFrame.Angles(0.2, 0, 0)
	local v4 = math.abs((math.clamp(v1.lookVector:Dot(Vector3.new(0, 1, 0)), -1, -0.06)))
	local v52 = Vector3.new(v1.lookVector.X, 0, v1.lookVector.Z)
	v8.Velocity.Velocity = v52 * 60 * math.max(0.9, v4) + Vector3.new(0, v4, 0) * -90
	v8.Gyro.CFrame = CFrame.new(Vector3.new(), v1.lookVector * 1) * CFrame.Angles(-1.8849555921538759, 0, 0)
	local v6, _ = fpor2(HumanoidRootPart.Position, Vector3.new(0, -3, 0), HumanoidRootPart.Parent)
	if v6 and (not v6:IsDescendantOf(workspace.Vehicles) and tick() - v8.Started > 1) then
		v5()
	end
end
local function RawGlider()
	if v8 then
		print("Already has glider")
		return false
	else
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				local PrimaryPart = Character.PrimaryPart
				if PrimaryPart then
					if Humanoid.PlatformStand or Humanoid.Sit then
						return false
					else
						Humanoid.PlatformStand = true
						Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
						v8 = {
							Type = "Glider"
						}
						local BodyGyro = Instance.new("BodyGyro")
						BodyGyro.MaxTorque = Vector3.new(inf, inf, inf)
						BodyGyro.CFrame = CurrentCamera.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
						BodyGyro.Parent = PrimaryPart
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
						BodyVelocity.Velocity = Vector3.new(0, -1, 0)
						BodyVelocity.Parent = PrimaryPart
						v8.Gyro = BodyGyro
						v8.Velocity = BodyVelocity
						v8.HumanoidRootPart = PrimaryPart
						v8.Humanoid = Humanoid
						v8.Started = tick()
						v8.Loop = RunService.Heartbeat:Connect(UpdateGlider)
						return true
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
end
local function RawGliderStop()
	if v8 and v8.Type == "Glider" then
		v8.Gyro:Destroy()
		v8.Velocity:Destroy()
		v8.Loop:Disconnect()
		v8.Humanoid.PlatformStand = false
		v8.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		v8 = nil
		v7:Fire()
		return true
	else
		return false
	end
end
local function Glider()
	if not RawGlider() then
		return false
	end
	v1:FireServer("d" .. ("ashj6e2"):sub(5, 5):reverse() .. "" .. "" .. ("x8cuhlli"):sub(4, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("a1ruj9s"):sub(3, 3):reverse() .. "m4")
end
v5 = function()
	if not RawGliderStop() then
		return false
	end
	v1:FireServer("m" .. ("awfcg8s"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "6ascx8")
end
return {
	Init = function(p1)
		local em = p1.em
		v1 = p1.Event
		v2 = em
		function em.g8qmqdsf()
			if not RawParachute() then
				v1:FireServer("qa93zuem")
			end
		end
		function em.qa93zuem()
			if v8 then
				if v8.Type == "Parachute" then
					v8.Gyro:Destroy()
					v8.Velocity:Destroy()
					v8.Loop:Disconnect()
					v8.Humanoid.PlatformStand = false
					v8 = nil
					v6:Fire()
				end
			end
		end
		function em.d6lhurm4()
			if not RawGlider() then
				v1:FireServer("m" .. "" .. ("nxcuyyr"):sub(3, 3):reverse() .. "" .. "" .. ("v3rfa6g"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "scx8")
			end
		end
		function em.mc6ascx8()
			RawGliderStop()
		end
		require(script.Parent.DefaultActions).onJumpPressed:Connect(function()
			if v8 and v8.Type == "Glider" then
				v5()
			end
		end)
	end,
	Parachute = Parachute,
	ParachuteStop = v4,
	Glider = Glider,
	GliderStop = v5,
	IsFlying = IsFlying,
	OnParachuteStopped = v6,
	OnGliderStopped = v7
}
