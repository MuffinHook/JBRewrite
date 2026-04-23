local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local RunService = game:GetService("RunService")
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Falling = require(ReplicatedStorage.Game.Falling)
local Maid = require(ReplicatedStorage.Std.Maid)
local RateLimiter = require(ReplicatedStorage.Std.RateLimiter)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Signal = require(ReplicatedStorage.Std.Signal)
local t = {
	mapPlayerRolling = {},
	mapLastRollTime = {},
	onRollBegan = Signal.new(),
	onRollEnded = Signal.new()
}
local v1 = RateLimiter.new(10, 10)
function t.attemptRoll() --[[ Line: 25 | Upvalues: Players (copy), Falling (copy), CharacterUtil (copy), Raycast (copy), t (copy), v1 (copy), Maid (copy), UserGameSettings (copy), RunService (copy) ]]
	local LocalPlayer = Players.LocalPlayer
	local PrimaryPart = LocalPlayer.Character.PrimaryPart
	local Humanoid = PrimaryPart.Parent:FindFirstChild("Humanoid")
	if Humanoid.Sit or Humanoid.PlatformStand or (Humanoid.WalkSpeed < 4 or (Falling.IsRagdolling() or (Falling.IsSkydiving() or CharacterUtil.IsCrawling))) then
		return
	end
	local v12 = RaycastParams.new()
	v12.FilterDescendantsInstances = { LocalPlayer.Character }
	if Raycast.collidable(PrimaryPart.Position, Vector3.new(-0, -1, -0), 32, v12) and t.mapLastRollTime[LocalPlayer] == nil then
		local MoveDirection = Humanoid.MoveDirection
		if v1:UseBudget(LocalPlayer.UserId, 1) then
			if MoveDirection.Magnitude < 0.25 then
				MoveDirection = PrimaryPart.CFrame.LookVector
			end
			local v2 = Maid.new()
			local LinearVelocity = Instance.new("LinearVelocity")
			LinearVelocity.Attachment0 = PrimaryPart:FindFirstChild("RootAttachment")
			LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
			LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0)
			LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1)
			LinearVelocity.MaxForce = PrimaryPart.AssemblyMass * 500
			LinearVelocity.Parent = PrimaryPart
			v2:GiveTask(LinearVelocity)
			local ImpulseAttachment = Instance.new("Attachment")
			ImpulseAttachment.Name = "ImpulseAttachment"
			ImpulseAttachment.Parent = PrimaryPart
			local ImpulseAlignOrientation = Instance.new("AlignOrientation")
			ImpulseAlignOrientation.Name = "ImpulseAlignOrientation"
			ImpulseAlignOrientation.Attachment0 = ImpulseAttachment
			ImpulseAlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
			ImpulseAlignOrientation.RigidityEnabled = true
			ImpulseAlignOrientation.CFrame = ImpulseAttachment.WorldCFrame
			ImpulseAlignOrientation.Parent = PrimaryPart
			v2:GiveTask(function() --[[ Line: 95 | Upvalues: ImpulseAlignOrientation (copy) ]]
				task.delay(0.1, function() --[[ Line: 97 | Upvalues: ImpulseAlignOrientation (ref) ]]
					ImpulseAlignOrientation:Destroy()
				end)
			end)
			v2:GiveTask(ImpulseAttachment)
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			v2:GiveTask(function() --[[ Line: 106 | Upvalues: Humanoid (copy) ]]
				if Humanoid:GetState() == Enum.HumanoidStateType.Physics and Humanoid:GetStateEnabled(Enum.HumanoidStateType.Running) then
					Humanoid:ChangeState(Enum.HumanoidStateType.Running)
				end
			end)
			if UserGameSettings.RotationType == Enum.RotationType.CameraRelative then
				UserGameSettings.RotationType = Enum.RotationType.MovementRelative
				v2:GiveTask(function() --[[ Line: 119 | Upvalues: UserGameSettings (ref) ]]
					UserGameSettings.RotationType = Enum.RotationType.CameraRelative
				end)
			end
			v2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 124 | Upvalues: MoveDirection (ref), LinearVelocity (copy) ]]
				local v1 = (MoveDirection * Vector3.new(1, 0, 1)).Unit * 70
				LinearVelocity.PlaneVelocity = Vector2.new(v1.X, v1.Z)
			end))
			t.onRollBegan:Fire(LocalPlayer, 0.3)
			t.mapPlayerRolling[LocalPlayer] = true
			v2:GiveTask(function() --[[ Line: 132 | Upvalues: t (ref), LocalPlayer (copy) ]]
				t.mapPlayerRolling[LocalPlayer] = nil
				t.onRollEnded:Fire(LocalPlayer)
			end)
			v2:GiveTask(task.delay(0.3, function() --[[ Line: 136 | Upvalues: v2 (copy) ]]
				task.defer(v2.Destroy, v2)
			end))
			t.mapLastRollTime[LocalPlayer] = os.clock()
			task.delay(1, function() --[[ Line: 141 | Upvalues: t (ref), LocalPlayer (copy) ]]
				t.mapLastRollTime[LocalPlayer] = nil
			end)
			return true
		end
	end
end
function t.isPlayerRolling(p1) --[[ Line: 146 | Upvalues: t (copy) ]]
	return t.mapPlayerRolling[p1] == true
end
return t