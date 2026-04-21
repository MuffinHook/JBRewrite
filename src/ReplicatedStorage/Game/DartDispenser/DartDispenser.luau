local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Folder_upvr = Instance.new("Folder")
Folder_upvr.Name = "Darts"
Folder_upvr.Parent = workspace
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local DartDispenserConsts_upvr = require(script.Parent.DartDispenserConsts)
function module_upvr.new(arg1) -- Line 20
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._maid:GiveTask(arg1:WaitForChild(DartDispenserConsts_upvr.FIRE_REMOTE_NAME).OnClientEvent:Connect(function() -- Line 27
        module_upvr_2:_fire(arg1)
    end))
    module_upvr_2._damageRemote = arg1:WaitForChild(DartDispenserConsts_upvr.DAMAGE_REMOTE_NAME)
    return module_upvr_2
end
local random_state_upvr = Random.new()
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local SimulatedPhysicsProjectile_upvr = require(ReplicatedStorage_upvr.Module.SimulatedPhysicsProjectile)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
local RunService_upvr = game:GetService("RunService")
function module_upvr._fire(arg1, arg2) -- Line 34
    local any_NextInteger_result1 = random_state_upvr:NextInteger(1, 1000000000)
    local formatted_upvr = string.format("update_%d", any_NextInteger_result1);
    local formatted_upvr_2 = string.format("part_%d", any_NextInteger_result1);
    local var17_upvw = arg2.CFrame * Vector3.new(0, 0, -arg2.Size.Z * 0.5)
    local clone_upvw = ReplicatedStorage_upvr.Resource.Robbery.Tomb:FindFirstChild("Arrow"):Clone()
    clone_upvw.Parent = Folder_upvr
    arg1._maid[formatted_upvr_2] = clone_upvw
    Audio_upvr.ObjectLocal(arg2, 6856219972, {
        Volume = 0.6;
        RollOffMaxDistance = 128;
    })
    local any_new_result1_upvr_2 = SimulatedPhysicsProjectile_upvr.new(var17_upvw)
    function any_new_result1_upvr_2.CollidableFunc(arg1_2) -- Line 58
        local var21 = true
        if arg1_2.Parent ~= LocalPlayer_upvr.Character then
            var21 = arg1_2:IsA("Terrain")
        end
        return var21
    end
    any_new_result1_upvr_2.IgnoreList = {Folder_upvr}
    any_new_result1_upvr_2._GravityVector /= 20
    any_new_result1_upvr_2.Velocity = arg2.CFrame.LookVector * 300
    local var24_upvw
    local PrimaryPart_upvr = clone_upvw.PrimaryPart
    local var26_upvw
    local LookVector_2_upvw = arg2.CFrame.LookVector
    local any_new_result1_upvr = Spring_upvr.new(0, 0, 0.3, 30)
    local var29_upvw
    local os_clock_result1_upvr = os.clock()
    arg1._maid[formatted_upvr] = RunService_upvr.Heartbeat:Connect(function() -- Line 71
        if not var24_upvw then
            local any_Step_result1, any_Step_result2, any_Step_result3_2 = any_new_result1_upvr_2:Step(any_new_result1_upvr_2:_GetNow(), var17_upvw)
            local var43 = CFrame.new(var17_upvw, any_Step_result1) * CFrame.new(0, 0, PrimaryPart_upvr.Size.Z * 0.5)
            local LookVector_3 = var43.LookVector
            if any_Step_result2 then
                var26_upvw = LookVector_2_upvw:Cross(LookVector_3)
                any_new_result1_upvr:Accelerate(20)
                local cframe = CFrame.new(any_Step_result1, any_Step_result1 + LookVector_3)
                var43 = cframe * CFrame.new(0, 0, PrimaryPart_upvr.Size.Z * 0.5)
                var24_upvw = any_Step_result3_2
                var29_upvw = any_Step_result3_2.CFrame:ToObjectSpace(cframe)
                Audio_upvr.ObjectLocal(PrimaryPart_upvr, 6856219902, {
                    Volume = 0.6;
                    RollOffMaxDistance = 128;
                })
                if any_Step_result3_2:IsDescendantOf(LocalPlayer_upvr.Character) then
                    arg1._damageRemote:FireServer()
                end
            end
            clone_upvw:SetPrimaryPartCFrame(var43)
            LookVector_2_upvw = LookVector_3
            var17_upvw = any_Step_result1
        else
            local any_Update_result1, any_Update_result2_2 = any_new_result1_upvr:Update()
            if math.abs(any_Update_result1) < 0.001 and math.abs(any_Update_result2_2) < 0.001 then
                arg1._maid[formatted_upvr] = nil
                arg1._maid[formatted_upvr_2] = nil
                return
            end
            clone_upvw:SetPrimaryPartCFrame(var24_upvw.CFrame * var29_upvw * CFrame.fromAxisAngle(var26_upvw, any_Update_result1) * CFrame.new(0, 0, PrimaryPart_upvr.Size.Z * 0.5))
        end
        if 3 < os.clock() - os_clock_result1_upvr then
            arg1._maid[formatted_upvr] = nil
            arg1._maid[formatted_upvr_2] = nil
        end
    end)
end
function module_upvr.Destroy(arg1) -- Line 113
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr