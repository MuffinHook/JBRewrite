local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function _(arg1, arg2) -- Line 18, Named "PlaySound"
    local Sound_upvr_2 = Instance.new("Sound")
    Sound_upvr_2.SoundId = string.format("rbxassetid://%d", arg2)
    Sound_upvr_2.Volume = 0.75
    Sound_upvr_2.Parent = arg1
    Sound_upvr_2:Play()
    delay(1, function() -- Line 24
        game.Debris:AddItem(Sound_upvr_2, Sound_upvr_2.TimeLength)
    end)
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr_2 = require(ReplicatedStorage.Std.Maid)
function tbl_upvr.new(arg1, arg2) -- Line 31
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1 == nil then
    else
    end
    assert(true)
    if arg2 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true)
    local module = {}
    setmetatable(module, tbl_upvr)
    local _1 = arg2.Layout:GetChildren()[1]
    if _1 == nil then
    else
    end
    assert(true)
    module.ModelLayout = _1
    module.Maid = Maid_upvr_2.new()
    module.BornAtSync = arg1
    if module.ModelLayout:FindFirstChild("Lasers") then
        module:SetupLasers(_1)
    end
    do
        return module
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Time_upvr = require(ReplicatedStorage.Module.Time)
function tbl_upvr.SetupLasers(arg1, arg2) -- Line 51
    local Lasers = arg2:WaitForChild("Lasers")
    assert(Lasers)
    local tbl_upvr_4 = {}
    for _, v in ipairs(Lasers:GetChildren()) do
        if v.Name == "Laser" or v.Name == "LaserWall" or v.Name == "LaserTrack" then
            local var19 = 2
            if v.Name == "LaserWall" then
                var19 = 5
            elseif v.Name == "LaserTrack" then
                var19 = 7
            end
            local Part = v:WaitForChild("Part", 3)
            table.insert(tbl_upvr_4, {
                Part = Part;
                Origin = Part.CFrame;
                Target = v.End.CFrame;
                Period = var19;
            })
        end
    end
    arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 74
        local var27 = Time_upvr.GetNowSync() - arg1.BornAtSync
        for _, v_2 in ipairs(tbl_upvr_4) do
            v_2.Part.CFrame = v_2.Origin:lerp(v_2.Target, math.cos((var27) * ((-math.pi*2) / v_2.Period)) * -0.5 + 0.5)
        end
    end))
    arg1.Maid:GiveTask(function() -- Line 82
        for _, v_3 in ipairs(tbl_upvr_4) do
            v_3.Part.CFrame = v_3.Origin
        end
    end)
end
function tbl_upvr.Destroy(arg1) -- Line 88
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
local var37_upvw
local var38_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local DuffelBagConsts_upvr = require(ReplicatedStorage.Game.DuffelBag.DuffelBagConsts)
local DuffelBagBinder_upvr = require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder)
local RobberyMoneyUI_upvr = require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
return {
    Init = function(arg1) -- Line 93, Named "Init"
        var37_upvw = arg1.Event
        var38_upvw = arg1.em
        local Sound_upvr = Instance.new("Sound")
        Sound_upvr.SoundId = "rbxassetid://1848209466"
        Sound_upvr.Looped = true
        Sound_upvr.Volume = 0
        Sound_upvr.SoundGroup = game:GetService("SoundService").RobberyMusic
        Sound_upvr.Parent = LocalPlayer_upvr.PlayerGui
        local var48_upvw
        local var49_upvw
        local var50_upvw
        function var38_upvw.awkhmwsa(arg1_2, arg2, arg3, arg4) -- Line 110
            if var50_upvw then
            else
                local var52_upvw
                local SOME_upvr = arg4:FindFirstChild(DuffelBagConsts_upvr.MULT_ENABLED_VALUE_NAME)
                local SOME_upvr_3 = arg4:FindFirstChild(DuffelBagConsts_upvr.MAXIMUM_VALUE_NAME)
                local SOME_upvr_2 = arg4:FindFirstChild(DuffelBagConsts_upvr.MULT_VALUE_NAME)
                var50_upvw = RunService_upvr.RenderStepped:Connect(function() -- Line 118
                    if not var52_upvw then
                        var52_upvw = DuffelBagBinder_upvr:Get(arg4)
                    end
                    if var52_upvw then
                        local var57
                        if arg4.Parent then
                            var57 = arg2 + (workspace:GetServerTimeNow() - arg1_2) * arg3
                            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                                var57 = math.ceil(SOME_upvr_3.Value * SOME_upvr_2.Value)
                                return var57
                            end
                            if not SOME_upvr.Value or not decompInlinedCondition_2() then
                                var57 = SOME_upvr_3
                                var57 = var57.Value
                            end
                            RobberyMoneyUI_upvr.SetMoney(math.clamp(math.floor(var57), 0, var57), var57, true)
                        end
                    end
                end)
            end
        end
        function var38_upvw.vmf6op9q(arg1_3) -- Line 131
            local var58
            if var58 then
                var58 = var50_upvw:Disconnect
                var58()
                var58 = nil
                var50_upvw = var58
            end
            var58 = arg1_3
            if var58 then
                var58 = arg1_3:FindFirstChild(DuffelBagConsts_upvr.MULT_ENABLED_VALUE_NAME)
            end
            if var58 then
                var58.Value = not var58.Value
                var58.Value = not var58.Value
            end
        end
        function var38_upvw.s4eanm66(arg1_4, arg2) -- Line 143
            local var59
            if var49_upvw ~= nil then
                var59 = false
            else
                var59 = true
            end
            assert(var59)
            if arg2 == nil then
                var59 = false
            else
                var59 = true
            end
            assert(var59)
            var59 = arg1_4
            var49_upvw = tbl_upvr.new(var59, arg2)
            var59 = LocalPlayer_upvr
            Audio_upvr.ObjectLocal(var59, 1837831244)
            var59 = 1
            delay(var59, function() -- Line 149
                Audio_upvr.ObjectLocal(LocalPlayer_upvr, 1843025542)
            end)
            if var48_upvw ~= nil then
                var48_upvw:Disconnect()
                var48_upvw = nil
            end
            if Sound_upvr.Playing == false then
                Sound_upvr:Play()
            end
            var59 = Sound_upvr
            var48_upvw = Audio_upvr.FadeTo(var59, 1, 5)
        end
        function var38_upvw.txpl0ht2() -- Line 161
            if var49_upvw ~= nil then
                var49_upvw:Destroy()
                var49_upvw = nil
            end
            if var48_upvw ~= nil then
                var48_upvw:Disconnect()
                var48_upvw = nil
            end
            var48_upvw = Audio_upvr.FadeTo(Sound_upvr, 0, 5, function() -- Line 170
                Sound_upvr:Stop()
            end)
            if var50_upvw then
                var50_upvw:Disconnect()
                var50_upvw = nil
            end
        end
        Binder_upvr.new("BankDoorEscapeRoute", function(arg1_5) -- Line 179
            local any_new_result1 = Maid_upvr.new()
            local tbl_upvr_3 = {}
            tbl_upvr_3.Part = arg1_5
            tbl_upvr_3.Name = "Place Dynamite"
            tbl_upvr_3.Timed = true
            tbl_upvr_3.Duration = 5
            tbl_upvr_3.Dist = 8
            function tbl_upvr_3.Callback(arg1_6, arg2) -- Line 182, Named "Action"
                if arg2 then
                    var37_upvw:FireServer('b'.."".."i6zrf6":sub(4, 4):reverse().."".."".."k9atuz9b23o":sub(3, 7):reverse()..""..'z', arg1_5)
                end
                return true
            end
            local function update() -- Line 197
                local var65
                if arg1_5:GetAttribute("Open") ~= nil then
                    var65 = false
                else
                    var65 = true
                end
                tbl_upvr_3.Enabled = var65
            end
            local var66
            if arg1_5:GetAttribute("Open") ~= nil then
                var66 = false
            else
                var66 = true
            end
            tbl_upvr_3.Enabled = var66
            var66 = any_new_result1:GiveTask
            var66(CircleAction_upvr.Add(tbl_upvr_3, arg1_5))
            var66 = any_new_result1:GiveTask
            var66(arg1_5:GetAttributeChangedSignal("Open"):Connect(update))
            return any_new_result1
        end):Start()
        Binder_upvr.new("BankTopFloorButton", function(arg1_7) -- Line 207
            local any_new_result1_2 = Maid_upvr.new()
            local tbl_upvr_2 = {}
            tbl_upvr_2.Part = arg1_7
            tbl_upvr_2.Name = "Open Shutters"
            tbl_upvr_2.Timed = false
            tbl_upvr_2.Dist = 8
            function tbl_upvr_2.Callback(arg1_8, arg2) -- Line 209, Named "action"
                if arg2 then
                    Audio_upvr.ObjectLocal(arg1_7, 9553471217, {
                        Volume = 0.5;
                    })
                    arg1_7:FindFirstChild("OpenTopFloorRemote"):FireServer()
                end
                return true
            end
            local var72
            if arg1_7:GetAttribute("ButtonDisabled") == true then
                var72 = false
            else
                var72 = true
            end
            tbl_upvr_2.Enabled = var72
            var72 = any_new_result1_2:GiveTask
            var72(CircleAction_upvr.Add(tbl_upvr_2, arg1_7))
            var72 = any_new_result1_2:GiveTask
            var72(arg1_7:GetAttributeChangedSignal("ButtonDisabled"):Connect(function() -- Line 223, Named "update"
                local var71
                if arg1_7:GetAttribute("ButtonDisabled") == true then
                    var71 = false
                else
                    var71 = true
                end
                tbl_upvr_2.Enabled = var71
            end))
            return any_new_result1_2
        end):Start()
    end;
}