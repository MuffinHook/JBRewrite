local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local var5_upvw = 0
UserInputService.InputBegan:Connect(function(arg1) -- Line 14
    if arg1.UserInputType ~= Enum.UserInputType.Gamepad1 then
        var5_upvw = os.clock()
    end
end)
UserInputService.InputChanged:Connect(function(arg1) -- Line 19
    if arg1.UserInputType ~= Enum.UserInputType.Gamepad1 then
        var5_upvw = os.clock()
    end
end)
local function hasLineOfSight_upvr(arg1, arg2) -- Line 37, Named "hasLineOfSight"
    local Position = workspace.CurrentCamera.CFrame.Position
    local RaycastParams_new_result1 = RaycastParams.new()
    RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
    RaycastParams_new_result1.RespectCanCollide = true
    RaycastParams_new_result1.FilterDescendantsInstances = {Players_upvr.LocalPlayer.Character, workspace.Items}
    RaycastParams_new_result1.IgnoreWater = true
    local workspace_Raycast_result1 = workspace:Raycast(Position, arg2 - Position, RaycastParams_new_result1)
    if not workspace_Raycast_result1 then
        return true
    end
    return workspace_Raycast_result1.Instance:IsDescendantOf(arg1)
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local CollectionService_upvr = game:GetService("CollectionService")
local RunService_upvr = game:GetService("RunService")
return {
    aimAssist = function(arg1, arg2) -- Line 61, Named "aimAssist"
        local any_new_result1 = Maid_upvr.new()
        local var17_upvr
        if Players_upvr.LocalPlayer:GetAttribute("AimbotEnabled") ~= true then
            var17_upvr = false
        else
            var17_upvr = true
        end
        local any_GetPivot_result1 = Players_upvr.LocalPlayer.Character:GetPivot()
        local Position_upvr = any_GetPivot_result1.Position
        local LookVector_upvr = any_GetPivot_result1.LookVector
        local findBestCharacter_result1_upvr = (function() -- Line 68, Named "findBestCharacter"
            local tbl_upvr = {}
            local tbl_3_upvr = {}
            local function handleCharacter(arg1_4) -- Line 71
                if tbl_3_upvr[arg1_4] then
                else
                    tbl_3_upvr[arg1_4] = true
                    local Humanoid = arg1_4:FindFirstChild("Humanoid")
                    if not Humanoid then return end
                    if Humanoid.Health == 0 then return end
                    if arg1_4 == Players_upvr.LocalPlayer.Character then return end
                    local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(arg1_4)
                    if any_GetPlayerFromCharacter_result1 and PlayerUtils_upvr.getTeam(any_GetPlayerFromCharacter_result1) == PlayerUtils_upvr.getTeam(Players_upvr.LocalPlayer) then return end
                    local PrimaryPart = arg1_4.PrimaryPart
                    if not PrimaryPart then return end
                    local Head = arg1_4:FindFirstChild("Head")
                    local var53 = Vector3.new(0, 0, 0)
                    if Head then
                        var53 = (Head.Position - PrimaryPart.Position) * Vector3.new(0, 1, 0) / 2
                    end
                    local var54 = PrimaryPart.CFrame * var53
                    if not hasLineOfSight_upvr(arg1_4, var54) then return end
                    table.insert(tbl_upvr, {
                        humanoid = Humanoid;
                        part = PrimaryPart;
                        offset = var53;
                        distance = (var54 - Position_upvr).Magnitude;
                        dot = (var54 - Position_upvr).Unit:Dot(LookVector_upvr);
                    })
                end
            end
            for i, v in CollectionService_upvr:GetTagged("Humanoid") do
                handleCharacter(v.Parent)
            end
            table.sort(tbl_upvr, function(arg1_5, arg2_3) -- Line 117
                local var60
                if arg2_3.dot >= arg1_5.dot then
                    var60 = false
                else
                    var60 = true
                end
                return var60
            end)
            for i_2 = 1, #tbl_upvr do
                i = tbl_upvr[i_2]
                v = i.dot
                if 0.9396926207859084 < v then
                    v = i.distance
                    if v <= 100 then
                        return i
                    end
                end
            end
            return nil
        end)()
        if not findBestCharacter_result1_upvr then
            return nil
        end
        local CurrentCamera_upvr = workspace.CurrentCamera
        local part_upvr = findBestCharacter_result1_upvr.part
        any_new_result1:GiveTask(RunService_upvr.RenderStepped:Connect(function(arg1_6) -- Line 133
            local cframe_looking_at = CFrame.lookAt(CurrentCamera_upvr.CFrame.Position, part_upvr.CFrame * findBestCharacter_result1_upvr.offset)
            local any_GetMouseLocation_result1 = arg1:GetMouseLocation()
            local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(any_GetMouseLocation_result1.X, any_GetMouseLocation_result1.Y, 0)
            local any_Dot_result1 = any_ViewportPointToRay_result1.Direction:Dot(CurrentCamera_upvr.CFrame.LookVector)
            if any_Dot_result1 < 0.999 then
                cframe_looking_at *= CFrame.fromAxisAngle(any_ViewportPointToRay_result1.Direction:Cross(CurrentCamera_upvr.CFrame.LookVector), math.acos(any_Dot_result1))
            end
            local var69 = part_upvr.CFrame * findBestCharacter_result1_upvr.offset
            if not hasLineOfSight_upvr(part_upvr.Parent, var69) then
                arg2()
            else
                if 100 < (Players_upvr.LocalPlayer.Character:GetPivot().Position - var69).Magnitude then
                    arg2()
                    return
                end
                local var70 = 1 - math.exp(-9 * arg1_6)
                if var17_upvr then
                    var70 = 1
                end
                CurrentCamera_upvr.CFrame = CurrentCamera_upvr.CFrame:Lerp(cframe_looking_at, var70)
                if Players_upvr.LocalPlayer:GetAttribute("AimbotEnabled") then
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
                local var71
                if InputUtils_upvr.isGamepad() and 10 < os.clock() - var5_upvw then
                    var71 = true
                else
                    var71 = false
                end
                if not var71 then
                    var71 = arg2
                    var71()
                    return
                end
                var71 = findBestCharacter_result1_upvr
                var71 = var71.humanoid
                var71 = var71.Health
                if var71 == 0 then
                    var71 = arg2
                    var71()
                    return
                end
                var71 = part_upvr:IsDescendantOf(workspace)
                if not var71 then
                    var71 = arg2
                    var71()
                end
            end
        end))
        return any_new_result1
    end;
    canAimAssist = function() -- Line 25, Named "canAimAssist"
        if Players_upvr.LocalPlayer:GetAttribute("AimbotEnabled") then
            return true
        end
        if InputUtils_upvr.isGamepad() and 10 < os.clock() - var5_upvw then
            return true
        end
        return false
    end;
}