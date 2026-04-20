local tbl_upvr = {}
local function RagdollSetup_upvr(arg1) -- Line 41, Named "RagdollSetup"
    local BallSocketConstraint_8 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_8.Name = "RagdollNeck"
    BallSocketConstraint_8.Attachment0 = arg1.UpperTorso.NeckRigAttachment
    BallSocketConstraint_8.Attachment1 = arg1.Head.NeckRigAttachment
    BallSocketConstraint_8.LimitsEnabled = true
    BallSocketConstraint_8.UpperAngle = 45
    BallSocketConstraint_8.TwistLimitsEnabled = true
    BallSocketConstraint_8.TwistLowerAngle = -40
    BallSocketConstraint_8.TwistUpperAngle = 40
    BallSocketConstraint_8.Enabled = false
    BallSocketConstraint_8.Parent = arg1
    local BallSocketConstraint_2 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_2.Name = "RagdollWaist"
    BallSocketConstraint_2.Attachment0 = arg1.LowerTorso.WaistRigAttachment
    BallSocketConstraint_2.Attachment1 = arg1.UpperTorso.WaistRigAttachment
    BallSocketConstraint_2.LimitsEnabled = true
    BallSocketConstraint_2.UpperAngle = 5
    BallSocketConstraint_2.Enabled = false
    BallSocketConstraint_2.Parent = arg1
    local HingeConstraint = Instance.new("HingeConstraint")
    HingeConstraint.Name = "RagdollLeftWrist"
    HingeConstraint.Attachment0 = arg1.LeftLowerArm.LeftWristRigAttachment
    HingeConstraint.Attachment1 = arg1.LeftHand.LeftWristRigAttachment
    HingeConstraint.Enabled = false
    HingeConstraint.Parent = arg1
    local HingeConstraint_2 = Instance.new("HingeConstraint")
    HingeConstraint_2.Name = "RagdollRightWrist"
    HingeConstraint_2.Attachment0 = arg1.RightLowerArm.RightWristRigAttachment
    HingeConstraint_2.Attachment1 = arg1.RightHand.RightWristRigAttachment
    HingeConstraint_2.Enabled = false
    HingeConstraint_2.Parent = arg1
    local HingeConstraint_3 = Instance.new("HingeConstraint")
    HingeConstraint_3.Name = "RagdollLeftKnee"
    HingeConstraint_3.Attachment0 = arg1.LeftUpperLeg.LeftKneeRigAttachment
    HingeConstraint_3.Attachment1 = arg1.LeftLowerLeg.LeftKneeRigAttachment
    HingeConstraint_3.LimitsEnabled = true
    HingeConstraint_3.UpperAngle = 15
    HingeConstraint_3.LowerAngle = -45
    HingeConstraint_3.Enabled = false
    HingeConstraint_3.Parent = arg1
    local HingeConstraint_6 = Instance.new("HingeConstraint")
    HingeConstraint_6.Name = "RagdollRightKnee"
    HingeConstraint_6.Attachment0 = arg1.RightUpperLeg.RightKneeRigAttachment
    HingeConstraint_6.Attachment1 = arg1.RightLowerLeg.RightKneeRigAttachment
    HingeConstraint_6.LimitsEnabled = true
    HingeConstraint_6.UpperAngle = 15
    HingeConstraint_6.LowerAngle = -45
    HingeConstraint_6.Enabled = false
    HingeConstraint_6.Parent = arg1
    local HingeConstraint_5 = Instance.new("HingeConstraint")
    HingeConstraint_5.Name = "RagdollLeftAnkle"
    HingeConstraint_5.Attachment0 = arg1.LeftLowerLeg.LeftAnkleRigAttachment
    HingeConstraint_5.Attachment1 = arg1.LeftFoot.LeftAnkleRigAttachment
    HingeConstraint_5.LimitsEnabled = true
    HingeConstraint_5.UpperAngle = 15
    HingeConstraint_5.LowerAngle = -45
    HingeConstraint_5.Enabled = false
    HingeConstraint_5.Parent = arg1
    local HingeConstraint_4 = Instance.new("HingeConstraint")
    HingeConstraint_4.Name = "RagdollRightAnkle"
    HingeConstraint_4.Attachment0 = arg1.RightLowerLeg.RightAnkleRigAttachment
    HingeConstraint_4.Attachment1 = arg1.RightFoot.RightAnkleRigAttachment
    HingeConstraint_4.LimitsEnabled = true
    HingeConstraint_4.UpperAngle = 15
    HingeConstraint_4.LowerAngle = -45
    HingeConstraint_4.Enabled = false
    HingeConstraint_4.Parent = arg1
    local BallSocketConstraint = Instance.new("BallSocketConstraint")
    BallSocketConstraint.Name = "RagdollLeftShoulder"
    BallSocketConstraint.Attachment0 = arg1.UpperTorso.LeftShoulderRigAttachment
    BallSocketConstraint.Attachment1 = arg1.LeftUpperArm.LeftShoulderRigAttachment
    BallSocketConstraint.Enabled = false
    BallSocketConstraint.Parent = arg1
    local BallSocketConstraint_4 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_4.Name = "RagdollRightShoulder"
    BallSocketConstraint_4.Attachment0 = arg1.UpperTorso.RightShoulderRigAttachment
    BallSocketConstraint_4.Attachment1 = arg1.RightUpperArm.RightShoulderRigAttachment
    BallSocketConstraint_4.Enabled = false
    BallSocketConstraint_4.Parent = arg1
    local BallSocketConstraint_5 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_5.Name = "RagdollLeftElbow"
    BallSocketConstraint_5.Attachment0 = arg1.LeftUpperArm.LeftElbowRigAttachment
    BallSocketConstraint_5.Attachment1 = arg1.LeftLowerArm.LeftElbowRigAttachment
    BallSocketConstraint_5.Enabled = false
    BallSocketConstraint_5.Parent = arg1
    local BallSocketConstraint_3 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_3.Name = "RagdollRightElbow"
    BallSocketConstraint_3.Attachment0 = arg1.RightUpperArm.RightElbowRigAttachment
    BallSocketConstraint_3.Attachment1 = arg1.RightLowerArm.RightElbowRigAttachment
    BallSocketConstraint_3.Enabled = false
    BallSocketConstraint_3.Parent = arg1
    local BallSocketConstraint_6 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_6.Name = "RagdollLeftHip"
    BallSocketConstraint_6.Attachment0 = arg1.LowerTorso.LeftHipRigAttachment
    BallSocketConstraint_6.Attachment1 = arg1.LeftUpperLeg.LeftHipRigAttachment
    BallSocketConstraint_6.Enabled = false
    BallSocketConstraint_6.Parent = arg1
    local BallSocketConstraint_7 = Instance.new("BallSocketConstraint")
    BallSocketConstraint_7.Name = "RagdollRightHip"
    BallSocketConstraint_7.Attachment0 = arg1.LowerTorso.RightHipRigAttachment
    BallSocketConstraint_7.Attachment1 = arg1.RightUpperLeg.RightHipRigAttachment
    BallSocketConstraint_7.Enabled = false
    BallSocketConstraint_7.Parent = arg1
end
local function EnableHumanoid_upvr(arg1, arg2) -- Line 160, Named "EnableHumanoid"
    for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
        if v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Dead then
            arg1:SetStateEnabled(v, arg2)
        end
    end
end
tbl_upvr = {}
local var106 = tbl_upvr
function var106.Ragdoll(arg1) -- Line 167
    local Humanoid_4 = arg1:FindFirstChild("Humanoid")
    if not Humanoid_4 then
    else
        if not arg1.PrimaryPart then return end
        local UpperTorso = arg1:FindFirstChild("UpperTorso")
        if not UpperTorso then return end
        workspace.CurrentCamera.CameraSubject = UpperTorso
        EnableHumanoid_upvr(Humanoid_4, false)
        Humanoid_4:ChangeState(Enum.HumanoidStateType.FallingDown)
    end
end
function var106.Unragdoll(arg1) -- Line 185
    local Humanoid = arg1:FindFirstChild("Humanoid")
    if not Humanoid then
    else
        local RootPart = Humanoid.RootPart
        if not Humanoid.Sit then
            local any_GetComponents_result1, any_GetComponents_result2, any_GetComponents_result3, any_GetComponents_result4, _, any_GetComponents_result6, any_GetComponents_result7, any_GetComponents_result8, any_GetComponents_result9, any_GetComponents_result10, _, any_GetComponents_result12 = RootPart.CFrame:GetComponents()
            local var36
            if 0 <= any_GetComponents_result8 then
                var36 = CFrame.new(any_GetComponents_result1, any_GetComponents_result2, any_GetComponents_result3, any_GetComponents_result4, 0, any_GetComponents_result6, any_GetComponents_result7, 1, any_GetComponents_result9, any_GetComponents_result10, 0, any_GetComponents_result12)
            else
                var36 = CFrame.new(any_GetComponents_result1, any_GetComponents_result2, any_GetComponents_result3, any_GetComponents_result4, 0, -any_GetComponents_result6, any_GetComponents_result7, 1, -any_GetComponents_result9, any_GetComponents_result10, 0, -any_GetComponents_result12)
            end
            RootPart.CFrame = var36 * CFrame.new(0, Humanoid.HipHeight, 0)
        end
        EnableHumanoid_upvr(Humanoid, true)
        if not arg1:GetAttribute("InVehicle") then
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            workspace.CurrentCamera.CameraSubject = Humanoid
        end
    end
end
function var106.RagdollServer(arg1) -- Line 212
    local Name_2 = arg1.Name
    local Character_4 = arg1.Character
    local var79
    if not Character_4 then
        return false
    end
    local Humanoid_2 = Character_4:FindFirstChild("Humanoid")
    if not Humanoid_2 then
        return false
    end
    if Humanoid_2.Sit then
        return false
    end
    local PrimaryPart_3_upvr = Character_4.PrimaryPart
    if not PrimaryPart_3_upvr then
        return false
    end
    PrimaryPart_3_upvr.CanCollide = false
    var79 = "Head"
    local SOME_2 = Character_4:FindFirstChild(var79)
    if SOME_2 then
        SOME_2.CanCollide = true
    end
    local UpperTorso_2 = Character_4:FindFirstChild("UpperTorso")
    if not UpperTorso_2 then return end
    var79 = PrimaryPart_3_upvr.Velocity * 3
    UpperTorso_2.Velocity = var79
    var79 = PrimaryPart_3_upvr.Velocity * 0.5
    UpperTorso_2.RotVelocity = var79
    var79 = tbl_upvr[Name_2]
    if not var79 then
        var79 = {}
        tbl_upvr[Name_2] = var79
    end
    if not PrimaryPart_3_upvr.Anchored then
        local pcall_result1, pcall_result2 = pcall(function() -- Line 246
            PrimaryPart_3_upvr:SetNetworkOwner(arg1)
        end)
        if pcall_result1 == false then
            print(pcall_result2)
        end
    end
    for _, v_2 in next, Character_4:GetChildren() do
        if v_2:IsA("BasePart") then
            for _, v_3 in next, v_2:GetChildren() do
                if v_3:IsA("Motor") and v_3.Name ~= "Root" then
                    var79[v_3] = v_3.Part1
                    v_3.Part1 = nil
                end
            end
        elseif v_2:IsA("Accessory") then
            v_2.Handle.CanCollide = false
        end
    end
    if not Character_4:FindFirstChild("RagdollWaist") then
        RagdollSetup_upvr(Character_4)
    end
    for _, v_4 in next, Character_4:GetChildren() do
        if v_4:IsA("Constraint") and v_4.Name:sub(1, 7) == "Ragdoll" then
            v_4.Enabled = true
        end
    end
    return true
end
function var106.UnragdollServer(arg1) -- Line 276
    local Name_3 = arg1.Name
    local Character = arg1.Character
    if not Character then
        return false
    end
    if not Character:FindFirstChild("RagdollWaist") then
        return false
    end
    local var99 = tbl_upvr[Name_3]
    if not var99 then
        return false
    end
    if not Character:FindFirstChild("Humanoid") then
        return false
    end
    local PrimaryPart = Character.PrimaryPart
    if not PrimaryPart then
        return false
    end
    PrimaryPart.CanCollide = true
    local Head = Character:FindFirstChild("Head")
    if Head then
        Head.CanCollide = false
    end
    for i_5, v_5 in next, var99 do
        i_5.Part1 = v_5
    end
    tbl_upvr[Name_3] = nil
    for _, v_6 in next, Character:GetChildren() do
        if v_6:IsA("Constraint") and v_6.Name:sub(1, 7) == "Ragdoll" then
            v_6:Destroy()
        end
    end
    return true
end
function var106.PlayerRemoving(arg1) -- Line 318
    tbl_upvr[arg1] = nil
end
function var106.IsRagdoll(arg1) -- Line 321
    local Character_2 = arg1.Character
    if not Character_2 then
        return false
    end
    local RagdollWaist = Character_2:FindFirstChild("RagdollWaist")
    if not RagdollWaist then
        return false
    end
    if not RagdollWaist.Enabled then
        return false
    end
    return true
end
return var106