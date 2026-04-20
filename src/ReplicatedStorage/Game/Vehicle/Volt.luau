local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera_upvr = workspace.CurrentCamera
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local tbl_upvr_2 = {
    tire_pop = 4534995816;
    tire_leak = 17871250897;
    tire_respawn = 77257382359638;
}
local tbl_3_upvw = {0, 0, 0, 0, 0, 0}
local function GetMoveVector_upvw() -- Line 24, Named "GetMoveVector"
    return Vector3.new()
end
local ControlModule = LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
    local var6_2_upvw = require(ControlModule)
    function GetMoveVector_upvw() -- Line 31, Named "GetMoveVector"
        return var6_2_upvw:GetMoveVector()
    end
end
local function SetHumanoidEnabled_upvr(arg1, arg2) -- Line 36, Named "SetHumanoidEnabled"
    for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
        if v ~= Enum.HumanoidStateType.Dead and v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Jumping then
            arg1.Humanoid:SetStateEnabled(v, arg2)
        end
    end
end
local function GetMass_upvr(arg1) -- Line 60, Named "GetMass"
    local var19
    for _, v_2 in ipairs(arg1:GetChildren()) do
        if v_2:IsA("BasePart") then
            local any_GetMass_result1 = v_2:GetMass()
            if v_2.CustomPhysicalProperties then
                local Density = v_2.CustomPhysicalProperties.Density
                if Density ~= Density then
                    Density = 0
                end
                any_GetMass_result1 *= Density
            end
            var19 += any_GetMass_result1
        end
        var19 += GetMass_upvr(v_2)
    end
    return var19
end
local os_clock_result1_2_upvw = os.clock()
local WheelWorld_upvr = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel_upvr = require(ReplicatedStorage.Module.Wheel.Wheel)
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local C4Binder_upvr = require(ReplicatedStorage.Game.C4.C4Binder)
local Time_upvr = require(ReplicatedStorage.Module.Time)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
local zero_vector3_upvr = Vector3.new()
local tbl_upvr = {
    [Enum.KeyCode.A] = 2;
    [Enum.KeyCode.D] = 4;
    [Enum.KeyCode.Q] = 5;
    [Enum.KeyCode.E] = 6;
    [Enum.KeyCode.ButtonR2] = 1;
    [Enum.KeyCode.ButtonL2] = 3;
    [Enum.KeyCode.Left] = 2;
    [Enum.KeyCode.Right] = 4;
}
local var159_upvw
local var160_upvw
return {
    Init = function(arg1) -- Line 371, Named "Init"
        var159_upvw = arg1.Event
        var160_upvw = arg1.em
    end;
    VehicleEnter = function(arg1) -- Line 79, Named "VehicleEnter"
        tbl_3_upvw = {0, 0, 0, 0, 0, 0}
        os_clock_result1_2_upvw = os.clock()
        local Character_2 = LocalPlayer_upvr.Character
        SetHumanoidEnabled_upvr(Character_2, false)
        Character_2.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        arg1.Rotate.MaxTorque = Vector3.new(0, 1000000, 1000000)
        arg1.fv = Vector3.new()
        arg1.hv = 0
        arg1.Mass = GetMass_upvr(arg1.Model)
        arg1._defaultForwardFriction = 0.01
        local any_new_result1_3 = WheelWorld_upvr.new()
        any_new_result1_3:SetModel(arg1.Model)
        local any_new_result1_2 = Wheel_upvr.new(arg1.Model.SuspensionFront)
        any_new_result1_2:SetSpringConstants(2, 4)
        any_new_result1_2:SetVisualRadius(1)
        any_new_result1_2:SetForwardFriction(arg1._defaultForwardFriction)
        any_new_result1_2:SetForwardFriction2(0)
        any_new_result1_2:SetHorizontalFriction(0)
        any_new_result1_2:SetSuspensionHeight(6.5)
        any_new_result1_3:AddWheel(any_new_result1_2)
        local any_new_result1 = Wheel_upvr.new(arg1.Model.SuspensionBack)
        any_new_result1:SetSpringConstants(2, 4)
        any_new_result1:SetVisualRadius(1)
        any_new_result1:SetForwardFriction(arg1._defaultForwardFriction)
        any_new_result1:SetForwardFriction2(0.001)
        any_new_result1:SetHorizontalFriction(0)
        any_new_result1:SetSuspensionHeight(6.5)
        any_new_result1_3:AddWheel(any_new_result1)
        arg1.WheelWorld = any_new_result1_3
        function arg1.setForward(arg1_2) -- Line 122
            local var30
            if arg1_2 then
                var30 = 1
            else
                var30 = 0
            end
            tbl_3_upvw[1] = var30
        end
        function arg1.setBackward(arg1_3) -- Line 125
            local var31
            if arg1_3 then
                var31 = 1
            else
                var31 = 0
            end
            tbl_3_upvw[3] = var31
        end
    end;
    VehicleLeave = function(arg1) -- Line 129, Named "VehicleLeave"
        local Character_4 = LocalPlayer_upvr.Character
        if Character_4 and Character_4:FindFirstChild("Humanoid") then
            SetHumanoidEnabled_upvr(Character_4, true)
        end
        arg1.Rotate.MaxTorque = Vector3.new()
        arg1.Force.Force = Vector3.new()
        arg1.WheelWorld:Destroy()
        arg1.WheelWorld = nil
        CurrentCamera_upvr.FieldOfView = 70
        tbl_3_upvw = {0, 0, 0, 0, 0, 0}
    end;
    InputBegan = function(arg1) -- Line 328, Named "InputBegan"
        if arg1.UserInputType == Enum.UserInputType.Keyboard then
            local KeyCode_3 = arg1.KeyCode
            if tbl_upvr[KeyCode_3] then
                tbl_3_upvw[tbl_upvr[KeyCode_3]] = 1
            end
        end
    end;
    InputEnded = function(arg1) -- Line 336, Named "InputEnded"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local UserInputType = arg1.UserInputType
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        tbl_3_upvw[tbl_upvr[UserInputType]] = 0
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    InputChanged = function(arg1, arg2) -- Line 349, Named "InputChanged"
        if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
            local KeyCode = arg1.KeyCode
            local var155
            if KeyCode == Enum.KeyCode.Thumbstick1 then
                local X = arg1.Position.X
                local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var155 = (-X) ^ 2
                    return var155
                end
                if X >= -0.24 or not decompInlinedCondition_3() then
                    var155 = 0
                end
                tbl_3_upvw[2] = var155
                local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var155 = X ^ 2
                    return var155
                end
                if 0.24 >= X or not decompInlinedCondition_4() then
                    var155 = 0
                end
                tbl_3_upvw[4] = var155
                return
            end
            if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
                local Z = arg1.Position.Z
                var155 = tbl_upvr
                local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var155 = Z ^ 0.5
                    return var155
                end
                if 0.05 >= Z or not decompInlinedCondition_5() then
                    var155 = 0
                end
                tbl_3_upvw[var155[KeyCode]] = var155
            end
        end
    end;
    Update = function(arg1) -- Line 153, Named "Update"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local os_clock_result1_3 = os.clock()
        local var120 = os_clock_result1_3 - os_clock_result1_2_upvw
        os_clock_result1_2_upvw = os_clock_result1_3
        local var121
        if InputUtils_upvr.isTouch() then
            local Character_3 = LocalPlayer_upvr.Character
            if Character_3 and Character_3:FindFirstChild("Humanoid") then
                local _ = math.clamp(GetMoveVector_upvw().X, -1, 1)
            end
        end
        local Model_2 = arg1.Model
        local Engine_2 = Model_2:FindFirstChild("Engine")
        if not Engine_2 then
        else
            local BoundingBox = Model_2.BoundingBox
            for _, v_3 in C4Binder_upvr:GetAll() do
                var121 = table.insert
                var121({}, v_3.obj)
                local var131
            end
            var131[#var131 + 1] = Model_2
            var131[#var131 + 1] = LocalPlayer_upvr.Character
            for _, v_4 in ipairs(arg1.WheelWorld.Wheels) do
                v_4.IgnoreModel = var131
                var121 = v_4:Update
                var121(var120, 0)
                local var135
            end
            var121 = (Time_upvr.GetNowSync() - (Model_2:GetAttribute("VehicleTiresLastPop") or 0)) / arg1.DisableDuration
            if math.min(var121, 1) >= 0.999 then
                var121 = false
            else
                var121 = true
            end
            if var121 then
            end
            if arg1.AreTiresPopped ~= var121 then
                local tbl = {
                    Volume = 1;
                }
                if arg1.AreTiresPopped ~= nil and var121 then
                    Audio_upvr.ObjectLocal(Engine_2, tbl_upvr_2.tire_pop, tbl)
                    Audio_upvr.ObjectLocal(Engine_2, tbl_upvr_2.tire_leak, tbl)
                elseif arg1.AreTiresPopped ~= nil and var121 ~= nil then
                    Audio_upvr.ObjectLocal(Engine_2, tbl_upvr_2.tire_respawn, tbl)
                end
                for _, v_5 in ipairs(arg1.WheelWorld.Wheels) do
                    local var140
                    if var121 then
                        var140 = 50
                    else
                        var140 = 1
                    end
                    v_5:SetForwardFriction(arg1._defaultForwardFriction * var140)
                end
                arg1.AreTiresPopped = var121
            end
            if arg1.LockMovement then
            end
            local any_Dot_result1_2 = Engine_2.Velocity:Dot(Engine_2.CFrame.LookVector)
            local var143 = any_Dot_result1_2 * var120 / 1.7035
            var121 = arg1.FrontWheelMotor.C1 * arg1.FrontWheelMotor.C0:Inverse() * CFrame.Angles(-var143, 0, 0)
            arg1.FrontWheelMotor.C1 = var121 * arg1.FrontWheelMotor.C0
            var121 = arg1.BackWheelMotor.C1 * arg1.BackWheelMotor.C0:Inverse() * CFrame.Angles(-var143, 0, 0)
            arg1.BackWheelMotor.C1 = var121 * arg1.BackWheelMotor.C0
            local var144 = any_Dot_result1_2 / 200
            if var144 ~= var144 then
                var144 = 0
            end
            var121 = var144
            local clamped_2 = math.clamp(var121, 0, 3)
            var121 = 0.825155
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var121 = clamped_2 * clamped_2
                return var121 * clamped_2
            end
            if clamped_2 >= var121 or not decompInlinedCondition_2() then
                var121 = math.exp(-clamped_2)
            end
            var121 = (1 - var121) * 30
            var121 = CurrentCamera_upvr
            var121 = var121.FieldOfView
            CurrentCamera_upvr.FieldOfView = var121 + (var121 + 70 - var121) * 0.7
            var121 = 0
            if 0 < var121 then
                if 0 < any_Dot_result1_2 then
                    var121 = 0.5
                else
                    var121 = 0.15
                end
            end
            if arg1.Nitro then
            end
            if not RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(BoundingBox.CFrame * Vector3.new(0, -BoundingBox.Size.Y * 0.5, 0), Vector3.new(0, -1, 0), 10, var135) then
            end
            arg1.Force.Force = zero_vector3_upvr - math.min(50, Engine_2.Velocity:Dot(Engine_2.CFrame.RightVector)) * 10 * Engine_2.CFrame.RightVector * Engine_2.AssemblyMass
            local const_number_2 = 0
            local hv_2 = arg1.hv
            hv_2 += (const_number_2 - hv_2) * 0.1
            local var148 = hv_2
            if const_number_2 * const_number_2 <= 0.01 then
                var148 *= 0.9
            else
                var148 *= 0.99
            end
            arg1.hv = var148
            local var149 = 1
            if Engine_2.Velocity:Dot(Engine_2.CFrame.LookVector) < -5 then
                var149 = -1
            end
            arg1.Rotate.CFrame = CFrame.new(zero_vector3_upvr, Engine_2.CFrame.LookVector) * CFrame.Angles(0, 0.5 * var148 * var149, 0.8 * var148 * var149)
        end
    end;
}