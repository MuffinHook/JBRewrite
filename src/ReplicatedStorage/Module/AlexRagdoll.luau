local t = {}
local function RagdollSetup(p1) --[[ Line: 41 ]]
	local RagdollNeck = Instance.new("BallSocketConstraint")
	RagdollNeck.Name = "RagdollNeck"
	RagdollNeck.Attachment0 = p1.UpperTorso.NeckRigAttachment
	RagdollNeck.Attachment1 = p1.Head.NeckRigAttachment
	RagdollNeck.LimitsEnabled = true
	RagdollNeck.UpperAngle = 45
	RagdollNeck.TwistLimitsEnabled = true
	RagdollNeck.TwistLowerAngle = -40
	RagdollNeck.TwistUpperAngle = 40
	RagdollNeck.Enabled = false
	RagdollNeck.Parent = p1
	local RagdollWaist = Instance.new("BallSocketConstraint")
	RagdollWaist.Name = "RagdollWaist"
	RagdollWaist.Attachment0 = p1.LowerTorso.WaistRigAttachment
	RagdollWaist.Attachment1 = p1.UpperTorso.WaistRigAttachment
	RagdollWaist.LimitsEnabled = true
	RagdollWaist.UpperAngle = 5
	RagdollWaist.Enabled = false
	RagdollWaist.Parent = p1
	local RagdollLeftWrist = Instance.new("HingeConstraint")
	RagdollLeftWrist.Name = "RagdollLeftWrist"
	RagdollLeftWrist.Attachment0 = p1.LeftLowerArm.LeftWristRigAttachment
	RagdollLeftWrist.Attachment1 = p1.LeftHand.LeftWristRigAttachment
	RagdollLeftWrist.Enabled = false
	RagdollLeftWrist.Parent = p1
	local RagdollRightWrist = Instance.new("HingeConstraint")
	RagdollRightWrist.Name = "RagdollRightWrist"
	RagdollRightWrist.Attachment0 = p1.RightLowerArm.RightWristRigAttachment
	RagdollRightWrist.Attachment1 = p1.RightHand.RightWristRigAttachment
	RagdollRightWrist.Enabled = false
	RagdollRightWrist.Parent = p1
	local RagdollLeftKnee = Instance.new("HingeConstraint")
	RagdollLeftKnee.Name = "RagdollLeftKnee"
	RagdollLeftKnee.Attachment0 = p1.LeftUpperLeg.LeftKneeRigAttachment
	RagdollLeftKnee.Attachment1 = p1.LeftLowerLeg.LeftKneeRigAttachment
	RagdollLeftKnee.LimitsEnabled = true
	RagdollLeftKnee.UpperAngle = 15
	RagdollLeftKnee.LowerAngle = -45
	RagdollLeftKnee.Enabled = false
	RagdollLeftKnee.Parent = p1
	local RagdollRightKnee = Instance.new("HingeConstraint")
	RagdollRightKnee.Name = "RagdollRightKnee"
	RagdollRightKnee.Attachment0 = p1.RightUpperLeg.RightKneeRigAttachment
	RagdollRightKnee.Attachment1 = p1.RightLowerLeg.RightKneeRigAttachment
	RagdollRightKnee.LimitsEnabled = true
	RagdollRightKnee.UpperAngle = 15
	RagdollRightKnee.LowerAngle = -45
	RagdollRightKnee.Enabled = false
	RagdollRightKnee.Parent = p1
	local RagdollLeftAnkle = Instance.new("HingeConstraint")
	RagdollLeftAnkle.Name = "RagdollLeftAnkle"
	RagdollLeftAnkle.Attachment0 = p1.LeftLowerLeg.LeftAnkleRigAttachment
	RagdollLeftAnkle.Attachment1 = p1.LeftFoot.LeftAnkleRigAttachment
	RagdollLeftAnkle.LimitsEnabled = true
	RagdollLeftAnkle.UpperAngle = 15
	RagdollLeftAnkle.LowerAngle = -45
	RagdollLeftAnkle.Enabled = false
	RagdollLeftAnkle.Parent = p1
	local RagdollRightAnkle = Instance.new("HingeConstraint")
	RagdollRightAnkle.Name = "RagdollRightAnkle"
	RagdollRightAnkle.Attachment0 = p1.RightLowerLeg.RightAnkleRigAttachment
	RagdollRightAnkle.Attachment1 = p1.RightFoot.RightAnkleRigAttachment
	RagdollRightAnkle.LimitsEnabled = true
	RagdollRightAnkle.UpperAngle = 15
	RagdollRightAnkle.LowerAngle = -45
	RagdollRightAnkle.Enabled = false
	RagdollRightAnkle.Parent = p1
	local RagdollLeftShoulder = Instance.new("BallSocketConstraint")
	RagdollLeftShoulder.Name = "RagdollLeftShoulder"
	RagdollLeftShoulder.Attachment0 = p1.UpperTorso.LeftShoulderRigAttachment
	RagdollLeftShoulder.Attachment1 = p1.LeftUpperArm.LeftShoulderRigAttachment
	RagdollLeftShoulder.Enabled = false
	RagdollLeftShoulder.Parent = p1
	local RagdollRightShoulder = Instance.new("BallSocketConstraint")
	RagdollRightShoulder.Name = "RagdollRightShoulder"
	RagdollRightShoulder.Attachment0 = p1.UpperTorso.RightShoulderRigAttachment
	RagdollRightShoulder.Attachment1 = p1.RightUpperArm.RightShoulderRigAttachment
	RagdollRightShoulder.Enabled = false
	RagdollRightShoulder.Parent = p1
	local RagdollLeftElbow = Instance.new("BallSocketConstraint")
	RagdollLeftElbow.Name = "RagdollLeftElbow"
	RagdollLeftElbow.Attachment0 = p1.LeftUpperArm.LeftElbowRigAttachment
	RagdollLeftElbow.Attachment1 = p1.LeftLowerArm.LeftElbowRigAttachment
	RagdollLeftElbow.Enabled = false
	RagdollLeftElbow.Parent = p1
	local RagdollRightElbow = Instance.new("BallSocketConstraint")
	RagdollRightElbow.Name = "RagdollRightElbow"
	RagdollRightElbow.Attachment0 = p1.RightUpperArm.RightElbowRigAttachment
	RagdollRightElbow.Attachment1 = p1.RightLowerArm.RightElbowRigAttachment
	RagdollRightElbow.Enabled = false
	RagdollRightElbow.Parent = p1
	local RagdollLeftHip = Instance.new("BallSocketConstraint")
	RagdollLeftHip.Name = "RagdollLeftHip"
	RagdollLeftHip.Attachment0 = p1.LowerTorso.LeftHipRigAttachment
	RagdollLeftHip.Attachment1 = p1.LeftUpperLeg.LeftHipRigAttachment
	RagdollLeftHip.Enabled = false
	RagdollLeftHip.Parent = p1
	local RagdollRightHip = Instance.new("BallSocketConstraint")
	RagdollRightHip.Name = "RagdollRightHip"
	RagdollRightHip.Attachment0 = p1.LowerTorso.RightHipRigAttachment
	RagdollRightHip.Attachment1 = p1.RightUpperLeg.RightHipRigAttachment
	RagdollRightHip.Enabled = false
	RagdollRightHip.Parent = p1
end
local function EnableHumanoid(p1, p2) --[[ Line: 160 ]]
	local v1 = next
	local v2, v3 = Enum.HumanoidStateType:GetEnumItems()
	for v4, v5 in v1, v2, v3 do
		if v5 ~= Enum.HumanoidStateType.None and v5 ~= Enum.HumanoidStateType.Dead then
			p1:SetStateEnabled(v5, p2)
		end
	end
end
return {
	Ragdoll = function(p1) --[[ Name: Ragdoll | Line: 167 | Upvalues: EnableHumanoid (copy) ]]
		local Humanoid = p1:FindFirstChild("Humanoid")
		if Humanoid and p1.PrimaryPart then
			local UpperTorso = p1:FindFirstChild("UpperTorso")
			if UpperTorso then
				workspace.CurrentCamera.CameraSubject = UpperTorso
				EnableHumanoid(Humanoid, false)
				Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
			end
		end
	end,
	Unragdoll = function(p1) --[[ Name: Unragdoll | Line: 185 | Upvalues: EnableHumanoid (copy) ]]
		local Humanoid = p1:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if not Humanoid.Sit then
				local v1, v2, v3, v4, _, v5, v6, v7, v8, v9, _2, v10 = RootPart.CFrame:GetComponents()
				local v11 = if v7 >= 0 then CFrame.new(v1, v2, v3, v4, 0, v5, v6, 1, v8, v9, 0, v10) else CFrame.new(v1, v2, v3, v4, 0, -v5, v6, 1, -v8, v9, 0, -v10)
				RootPart.CFrame = v11 * CFrame.new(0, Humanoid.HipHeight, 0)
			end
			EnableHumanoid(Humanoid, true)
			if not p1:GetAttribute("InVehicle") then
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				workspace.CurrentCamera.CameraSubject = Humanoid
			end
		end
	end,
	RagdollServer = function(p1) --[[ Name: RagdollServer | Line: 212 | Upvalues: t (copy), RagdollSetup (copy) ]]
		local v1 = p1.Name
		local Character = p1.Character
		if not Character then
			return false
		end
		local Humanoid = Character:FindFirstChild("Humanoid")
		if not Humanoid then
			return false
		end
		if Humanoid.Sit then
			return false
		end
		local PrimaryPart = Character.PrimaryPart
		if not PrimaryPart then
			return false
		end
		PrimaryPart.CanCollide = false
		local Head = Character:FindFirstChild("Head")
		if Head then
			Head.CanCollide = true
		end
		local UpperTorso = Character:FindFirstChild("UpperTorso")
		if UpperTorso then
			UpperTorso.Velocity = PrimaryPart.Velocity * 3
			UpperTorso.RotVelocity = PrimaryPart.Velocity * 0.5
			local v2 = t[v1]
			if not v2 then
				v2 = {}
				t[v1] = v2
			end
			if not PrimaryPart.Anchored then
				local v3, v4 = pcall(function() --[[ Line: 246 | Upvalues: PrimaryPart (copy), p1 (copy) ]]
					PrimaryPart:SetNetworkOwner(p1)
				end)
				if v3 == false then
					print(v4)
				end
			end
			local v5 = next
			local v6, v7 = Character:GetChildren()
			for v8, v9 in v5, v6, v7 do
				if v9:IsA("BasePart") then
					local v10 = next
					local v11, v12 = v9:GetChildren()
					for v13, v14 in v10, v11, v12 do
						if v14:IsA("Motor") and v14.Name ~= "Root" then
							v2[v14] = v14.Part1
							v14.Part1 = nil
						end
					end
				elseif v9:IsA("Accessory") then
					v9.Handle.CanCollide = false
				end
			end
			if not Character:FindFirstChild("RagdollWaist") then
				RagdollSetup(Character)
			end
			local v15 = next
			local v16, v17 = Character:GetChildren()
			for v18, v19 in v15, v16, v17 do
				if v19:IsA("Constraint") and v19.Name:sub(1, 7) == "Ragdoll" then
					v19.Enabled = true
				end
			end
			return true
		end
	end,
	UnragdollServer = function(p1) --[[ Name: UnragdollServer | Line: 276 | Upvalues: t (copy) ]]
		local v1 = p1.Name
		local Character = p1.Character
		if Character and Character:FindFirstChild("RagdollWaist") then
			local v2 = t[v1]
			if v2 and Character:FindFirstChild("Humanoid") then
				local PrimaryPart = Character.PrimaryPart
				if PrimaryPart then
					PrimaryPart.CanCollide = true
					local Head = Character:FindFirstChild("Head")
					if Head then
						Head.CanCollide = false
					end
					for v3, v4 in next, v2 do
						v3.Part1 = v4
					end
					t[v1] = nil
					local v5 = next
					local v6, v7 = Character:GetChildren()
					for v8, v9 in v5, v6, v7 do
						if v9:IsA("Constraint") and v9.Name:sub(1, 7) == "Ragdoll" then
							v9:Destroy()
						end
					end
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end,
	PlayerRemoving = function(p1) --[[ Name: PlayerRemoving | Line: 318 | Upvalues: t (copy) ]]
		t[p1] = nil
	end,
	IsRagdoll = function(p1) --[[ Name: IsRagdoll | Line: 321 ]]
		local Character = p1.Character
		if Character then
			local RagdollWaist = Character:FindFirstChild("RagdollWaist")
			if RagdollWaist then
				return RagdollWaist.Enabled and true or false
			else
				return false
			end
		else
			return false
		end
	end
}