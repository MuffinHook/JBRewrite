local Animation_upvr = Instance.new("Animation")
Animation_upvr.AnimationId = "rbxassetid://3066265539"
local var2_upvw
local var3_upvw
local any_new_result1_upvr = require(game:GetService("ReplicatedStorage").Std.Maid).new()
local var5_upvw
local var6_upvw = false
local SoundService_upvr = game:GetService("SoundService")
local RunService_upvr = game:GetService("RunService")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local function PartyStart_upvr() -- Line 19, Named "PartyStart"
    assert(not var6_upvw)
    var6_upvw = true
    local tick_result1_5_upvw = tick()
    local tick_result1_7_upvw = tick()
    any_new_result1_upvr.Runtime = RunService_upvr.Heartbeat:Connect(function(arg1) -- Line 25, Named "Heartbeat"
        local tick_result1 = tick()
        local Disco_3 = var5_upvw:FindFirstChild("Disco")
        if Disco_3 then
            for _, v in next, var5_upvw:GetChildren() do
                if v.Name == "Laser" then
                    v.CFrame = Disco_3.CFrame:toWorldSpace(CFrame.Angles(0, 0.3 * arg1, 0) * Disco_3.CFrame:toObjectSpace(v.CFrame))
                end
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            Disco_3.CFrame *= CFrame.Angles(0, 0.3 * arg1, 0)
            Disco_3:FindFirstChild("Music").SoundGroup = SoundService_upvr.Music
        end
        local Cloud = var5_upvw:FindFirstChild("Cloud")
        if Cloud then
            for _, v_2 in next, Cloud:GetChildren() do
                if v_2:IsA("Decal") then
                    v_2.Color3 = Color3.fromHSV(math.cos(tick_result1 * 0.1) * 0.5 + 0.5, 1, 1)
                end
            end
        end
        if 0.5 < tick_result1 - tick_result1_5_upvw then
            tick_result1_5_upvw = tick_result1
            local SmallDanceFloor_3 = var5_upvw:FindFirstChild("SmallDanceFloor")
            if SmallDanceFloor_3 then
                for _, v_3 in next, SmallDanceFloor_3:GetChildren() do
                    if v_3.Name == "Color" then
                        v_3.Transparency = math.random() * 0.35 + 0.1
                    end
                end
            end
        end
        if 1 < tick_result1 - tick_result1_7_upvw then
            tick_result1_7_upvw = tick_result1
            var3_upvw(1)
        end
    end)
    local Character_2 = LocalPlayer_upvr.Character
    if Character_2 then
        local Humanoid = Character_2:FindFirstChild("Humanoid")
        if Humanoid then
            var2_upvw = Humanoid:LoadAnimation(Animation_upvr)
            var2_upvw:Play()
        end
    end
end
local function _() -- Line 77, Named "PartyEnd"
    assert(var6_upvw)
    var6_upvw = false
    any_new_result1_upvr:Destroy()
    var2_upvw:Stop()
    var2_upvw:Destroy()
    var2_upvw = nil
end
local function AddedFun_upvr(arg1) -- Line 86, Named "AddedFun"
    var5_upvw = arg1
    PartyStart_upvr()
end
local function RemovedFun_upvr(arg1) -- Line 90, Named "RemovedFun"
    assert(var6_upvw)
    var6_upvw = false
    any_new_result1_upvr:Destroy()
    var2_upvw:Stop()
    var2_upvw:Destroy()
    var2_upvw = nil
    var5_upvw = nil
end
local CollectionService_upvr = game:GetService("CollectionService")
return {
    Init = function(arg1) -- Line 96, Named "Init"
        var3_upvw = arg1.Fireworks
        for _, v_4 in next, CollectionService_upvr:GetTagged("PartyThemeModel") do
            var5_upvw = v_4
            PartyStart_upvr()
        end
        CollectionService_upvr:GetInstanceAddedSignal("PartyThemeModel"):Connect(AddedFun_upvr)
        CollectionService_upvr:GetInstanceRemovedSignal("PartyThemeModel"):Connect(RemovedFun_upvr)
    end;
}