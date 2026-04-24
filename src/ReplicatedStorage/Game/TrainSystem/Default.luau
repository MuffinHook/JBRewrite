-- Reviewed by Claude
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local TrainSystemUtils = require(script.Parent.TrainSystemUtils)
local function v1(p1, p2, p3)
	local v12 = next
	local v2, v3 = p1:GetChildren()
	for v4, v5 in v12, v2, v3 do
		if v5:IsA("BasePart") then
			v5.Velocity = p2
			v5.RotVelocity = p3
		end
		v1(v5, p2, p3)
	end
	return true
end
return {
	MakeCar = function(p1)
		local Model = p1.Model
		local Base = p1.Base
		local Length = p1.Length
		Joint.WeldAllTo(Model.Model, Base)
		Joint.Weld(Model.FrontBogeyRoot, Base)
		Joint.Weld(Model.BackBogeyRoot, Base)
		local v1 = Joint.BlankMotor(Model.FrontBogey, Model.FrontBogeyRoot)
		local v2 = Joint.BlankMotor(Model.BackBogey, Model.BackBogeyRoot)
		Model.FrontBogeyRoot.Anchored = false
		Model.BackBogeyRoot.Anchored = false
		Model.FrontBogey.Anchored = false
		Model.BackBogey.Anchored = false
		Base.Anchored = true
		local Magnitude = (Model.FrontBogeyRoot.Position - Base.CFrame * Vector3.new(0, 0, -Length * 0.5)).Magnitude
		local Magnitude_2 = (Model.BackBogeyRoot.Position - Base.CFrame * Vector3.new(0, 0, Length * 0.5)).Magnitude
		p1.BogeyMotorFront = v1
		p1.BogeyMotorBack = v2
		p1.BogeyOffsetFront = Magnitude
		p1.BogeyOffsetBack = Magnitude_2
		local Skeleton = Model:FindFirstChild("Skeleton")
		if Skeleton then
			p1.DoorOpenFuncs = {}
			local function setupDoor(p12)
				local v1 = Skeleton:FindFirstChild("Door" .. tostring(p12))
				if v1 then
					Joint.WeldAllTo(v1, v1.PrimaryPart)
					local v2 = Joint.Motor(v1.PrimaryPart, Base)
					v1.PrimaryPart.Anchored = false
					p1.DoorOpenFuncs[p12] = function()
						local v12 = tick()
						local v22 = nil
						local function Heartbeat()
							local v13 = (tick() - v12) / 1
							if v13 >= 1 then
								v22:Disconnect()
								v13 = 1
							end
							v2.C1 = CFrame.new(v1.PrimaryPart.Size.X * TweenService:GetValue(v13, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 0, 0)
						end
						v22 = RunService.Heartbeat:Connect(Heartbeat)
					end
				end
			end
			setupDoor(1)
			setupDoor(2)
		end
	end,
	MoveCar = function(p1, p2, p3, p4)
		local Speed = p2.Speed
		local v1, v2 = TrainSystemUtils.CalculatePosition(p2, p2.Offset + p4 + p1.BogeyOffsetBack)
		local v3, v4 = TrainSystemUtils.CalculatePosition(p2, p2.Offset + p4 + p1.Length - p1.BogeyOffsetFront)
		local v5 = CFrame.new(Vector3.new(), (v3 - v1).Unit)
		p1.Base.CFrame = v5 + (v1 + v3) * 0.5
		local v6 = v4:toObjectSpace(v5)
		local v7 = v2:toObjectSpace(v5)
		if p1.InvertBogey then
			local v8 = v6:inverse()
			v6, v7 = v8, v7:inverse()
		end
		p1.BogeyMotorFront.C0 = p1.BogeyMotorFront.C0:lerp(v6, 0.1)
		p1.BogeyMotorBack.C0 = p1.BogeyMotorBack.C0:lerp(v7, 0.1)
	end,
	DestroyCar = function(p1)
		p1.Model:Destroy()
		return true
	end
}
