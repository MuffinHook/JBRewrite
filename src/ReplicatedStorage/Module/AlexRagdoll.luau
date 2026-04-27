local ragdollStateTable = {}
local function RagdollSetup(character)
	local RagdollNeck = Instance.new("BallSocketConstraint")
	RagdollNeck.Name = "RagdollNeck"
	RagdollNeck.Attachment0 = character.UpperTorso.NeckRigAttachment
	RagdollNeck.Attachment1 = character.Head.NeckRigAttachment
	RagdollNeck.LimitsEnabled = true
	RagdollNeck.UpperAngle = 45
	RagdollNeck.TwistLimitsEnabled = true
	RagdollNeck.TwistLowerAngle = -40
	RagdollNeck.TwistUpperAngle = 40
	RagdollNeck.Enabled = false
	RagdollNeck.Parent = character
	local RagdollWaist = Instance.new("BallSocketConstraint")
	RagdollWaist.Name = "RagdollWaist"
	RagdollWaist.Attachment0 = character.LowerTorso.WaistRigAttachment
	RagdollWaist.Attachment1 = character.UpperTorso.WaistRigAttachment
	RagdollWaist.LimitsEnabled = true
	RagdollWaist.UpperAngle = 5
	RagdollWaist.Enabled = false
	RagdollWaist.Parent = character
	local RagdollLeftWrist = Instance.new("HingeConstraint")
	RagdollLeftWrist.Name = "RagdollLeftWrist"
	RagdollLeftWrist.Attachment0 = character.LeftLowerArm.LeftWristRigAttachment
	RagdollLeftWrist.Attachment1 = character.LeftHand.LeftWristRigAttachment
	RagdollLeftWrist.Enabled = false
	RagdollLeftWrist.Parent = character
	local RagdollRightWrist = Instance.new("HingeConstraint")
	RagdollRightWrist.Name = "RagdollRightWrist"
	RagdollRightWrist.Attachment0 = character.RightLowerArm.RightWristRigAttachment
	RagdollRightWrist.Attachment1 = character.RightHand.RightWristRigAttachment
	RagdollRightWrist.Enabled = false
	RagdollRightWrist.Parent = character
	local RagdollLeftKnee = Instance.new("HingeConstraint")
	RagdollLeftKnee.Name = "RagdollLeftKnee"
	RagdollLeftKnee.Attachment0 = character.LeftUpperLeg.LeftKneeRigAttachment
	RagdollLeftKnee.Attachment1 = character.LeftLowerLeg.LeftKneeRigAttachment
	RagdollLeftKnee.LimitsEnabled = true
	RagdollLeftKnee.UpperAngle = 15
	RagdollLeftKnee.LowerAngle = -45
	RagdollLeftKnee.Enabled = false
	RagdollLeftKnee.Parent = character
	local RagdollRightKnee = Instance.new("HingeConstraint")
	RagdollRightKnee.Name = "RagdollRightKnee"
	RagdollRightKnee.Attachment0 = character.RightUpperLeg.RightKneeRigAttachment
	RagdollRightKnee.Attachment1 = character.RightLowerLeg.RightKneeRigAttachment
	RagdollRightKnee.LimitsEnabled = true
	RagdollRightKnee.UpperAngle = 15
	RagdollRightKnee.LowerAngle = -45
	RagdollRightKnee.Enabled = false
	RagdollRightKnee.Parent = character
	local RagdollLeftAnkle = Instance.new("HingeConstraint")
	RagdollLeftAnkle.Name = "RagdollLeftAnkle"
	RagdollLeftAnkle.Attachment0 = character.LeftLowerLeg.LeftAnkleRigAttachment
	RagdollLeftAnkle.Attachment1 = character.LeftFoot.LeftAnkleRigAttachment
	RagdollLeftAnkle.LimitsEnabled = true
	RagdollLeftAnkle.UpperAngle = 15
	RagdollLeftAnkle.LowerAngle = -45
	RagdollLeftAnkle.Enabled = false
	RagdollLeftAnkle.Parent = character
	local RagdollRightAnkle = Instance.new("HingeConstraint")
	RagdollRightAnkle.Name = "RagdollRightAnkle"
	RagdollRightAnkle.Attachment0 = character.RightLowerLeg.RightAnkleRigAttachment
	RagdollRightAnkle.Attachment1 = character.RightFoot.RightAnkleRigAttachment
	RagdollRightAnkle.LimitsEnabled = true
	RagdollRightAnkle.UpperAngle = 15
	RagdollRightAnkle.LowerAngle = -45
	RagdollRightAnkle.Enabled = false
	RagdollRightAnkle.Parent = character
	local RagdollLeftShoulder = Instance.new("BallSocketConstraint")
	RagdollLeftShoulder.Name = "RagdollLeftShoulder"
	RagdollLeftShoulder.Attachment0 = character.UpperTorso.LeftShoulderRigAttachment
	RagdollLeftShoulder.Attachment1 = character.LeftUpperArm.LeftShoulderRigAttachment
	RagdollLeftShoulder.Enabled = false
	RagdollLeftShoulder.Parent = character
	local RagdollRightShoulder = Instance.new("BallSocketConstraint")
	RagdollRightShoulder.Name = "RagdollRightShoulder"
	RagdollRightShoulder.Attachment0 = character.UpperTorso.RightShoulderRigAttachment
	RagdollRightShoulder.Attachment1 = character.RightUpperArm.RightShoulderRigAttachment
	RagdollRightShoulder.Enabled = false
	RagdollRightShoulder.Parent = character
	local RagdollLeftElbow = Instance.new("BallSocketConstraint")
	RagdollLeftElbow.Name = "RagdollLeftElbow"
	RagdollLeftElbow.Attachment0 = character.LeftUpperArm.LeftElbowRigAttachment
	RagdollLeftElbow.Attachment1 = character.LeftLowerArm.LeftElbowRigAttachment
	RagdollLeftElbow.Enabled = false
	RagdollLeftElbow.Parent = character
	local RagdollRightElbow = Instance.new("BallSocketConstraint")
	RagdollRightElbow.Name = "RagdollRightElbow"
	RagdollRightElbow.Attachment0 = character.RightUpperArm.RightElbowRigAttachment
	RagdollRightElbow.Attachment1 = character.RightLowerArm.RightElbowRigAttachment
	RagdollRightElbow.Enabled = false
	RagdollRightElbow.Parent = character
	local RagdollLeftHip = Instance.new("BallSocketConstraint")
	RagdollLeftHip.Name = "RagdollLeftHip"
	RagdollLeftHip.Attachment0 = character.LowerTorso.LeftHipRigAttachment
	RagdollLeftHip.Attachment1 = character.LeftUpperLeg.LeftHipRigAttachment
	RagdollLeftHip.Enabled = false
	RagdollLeftHip.Parent = character
	local RagdollRightHip = Instance.new("BallSocketConstraint")
	RagdollRightHip.Name = "RagdollRightHip"
	RagdollRightHip.Attachment0 = character.LowerTorso.RightHipRigAttachment
	RagdollRightHip.Attachment1 = character.RightUpperLeg.RightHipRigAttachment
	RagdollRightHip.Enabled = false
	RagdollRightHip.Parent = character
end
local function EnableHumanoid(humanoid, isEnabled)
	local iteratorFunction = next
	local humanoidStateTypes, endMarker = Enum.HumanoidStateType:GetEnumItems()
	for index, stateType in iteratorFunction, humanoidStateTypes, endMarker do
		if stateType ~= Enum.HumanoidStateType.None and stateType ~= Enum.HumanoidStateType.Dead then
			humanoid:SetStateEnabled(stateType, isEnabled)
		end
	end
end
return {
	Ragdoll = function(character)
		local Humanoid = character:FindFirstChild("Humanoid")
		if Humanoid and character.PrimaryPart then
			local UpperTorso = character:FindFirstChild("UpperTorso")
			if UpperTorso then
				workspace.CurrentCamera.CameraSubject = UpperTorso
				EnableHumanoid(Humanoid, false)
				Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
			end
		end
	end,
	Unragdoll = function(character)
		local Humanoid = character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if not Humanoid.Sit then
				local posX, posY, posZ, r00, r01, r02, r10, r11, r12, r20, r21, r22 = RootPart.CFrame:GetComponents()
				local adjustedCFrame = if r10 >= 0 then CFrame.new(posX, posY, posZ, r00, 0, r02, r10, 1, r12, r20, 0, r22) else CFrame.new(posX, posY, posZ, r00, 0, -r02, r10, 1, -r12, r20, 0, -r22)
				RootPart.CFrame = adjustedCFrame * CFrame.new(0, Humanoid.HipHeight, 0)
			end
			EnableHumanoid(Humanoid, true)
			if not character:GetAttribute("InVehicle") then
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				workspace.CurrentCamera.CameraSubject = Humanoid
			end
		end
	end,
	RagdollServer = function(player)
		local playerName = player.Name
		local Character = player.Character
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
			local playerMotorTable = ragdollStateTable[playerName]
			if not playerMotorTable then
				playerMotorTable = {}
				ragdollStateTable[playerName] = playerMotorTable
			end
			if not PrimaryPart.Anchored then
				local success, errorMessage = pcall(function()
					PrimaryPart:SetNetworkOwner(player)
				end)
				if success == false then
					print(errorMessage)
				end
			end
			local iteratorFunction = next
			local childrenList, endMarker = Character:GetChildren()
			for childIndex, childPart in iteratorFunction, childrenList, endMarker do
				if childPart:IsA("BasePart") then
					local motorIterator = next
					local motorChildren, motorEnd = childPart:GetChildren()
					for motorIndex, motor in motorIterator, motorChildren, motorEnd do
						if motor:IsA("Motor") and motor.Name ~= "Root" then
							playerMotorTable[motor] = motor.Part1
							motor.Part1 = nil
						end
					end
				elseif childPart:IsA("Accessory") then
					childPart.Handle.CanCollide = false
				end
			end
			if not Character:FindFirstChild("RagdollWaist") then
				RagdollSetup(Character)
			end
			local constraintIterator = next
			local constraintChildren, constraintEnd = Character:GetChildren()
			for constraintIndex, constraint in constraintIterator, constraintChildren, constraintEnd do
				if constraint:IsA("Constraint") and constraint.Name:sub(1, 7) == "Ragdoll" then
					constraint.Enabled = true
				end
			end
			return true
		end
	end,
	UnragdollServer = function(player)
		local playerName = player.Name
		local Character = player.Character
		if Character and Character:FindFirstChild("RagdollWaist") then
			local playerMotorTable = ragdollStateTable[playerName]
			if playerMotorTable and Character:FindFirstChild("Humanoid") then
				local PrimaryPart = Character.PrimaryPart
				if PrimaryPart then
					PrimaryPart.CanCollide = true
					local Head = Character:FindFirstChild("Head")
					if Head then
						Head.CanCollide = false
					end
					for motor, previousPart in next, playerMotorTable do
						motor.Part1 = previousPart
					end
					ragdollStateTable[playerName] = nil
					local constraintIterator = next
					local constraintChildren, constraintEnd = Character:GetChildren()
					for constraintIndex, constraint in constraintIterator, constraintChildren, constraintEnd do
						if constraint:IsA("Constraint") and constraint.Name:sub(1, 7) == "Ragdoll" then
							constraint:Destroy()
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
	PlayerRemoving = function(player)
		ragdollStateTable[player] = nil
	end,
	IsRagdoll = function(character)
		local Character = character.Character
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
