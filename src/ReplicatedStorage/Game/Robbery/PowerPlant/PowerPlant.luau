local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function _(arg1) -- Line 8, Named "Round"
    return math.floor(arg1 / 50 + 0.5) * 50
end
local function _(arg1) -- Line 11, Named "comma"
    local string_match_result1_2, string_match_result2, string_match_result3 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1_2..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
return {
    Init = function(arg1) -- Line 26, Named "Init"
        local em = arg1.em
        local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 3280045064, {
            Looped = true;
            DoNotPlay = true;
        })
        local any_ObjectLocal_result1_upvr_2 = Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 1836781594, {
            Looped = true;
            DoNotPlay = true;
        })
        any_ObjectLocal_result1_upvr_2.SoundGroup = game:GetService("SoundService").RobberyMusic
        local PowerPlantRobberyGui_upvr = ReplicatedStorage_upvr.Resource.Robbery.PowerPlant.PowerPlantRobberyGui
        local var15_upvw
        local var16_upvw = false
        local function StartRuntime_upvr() -- Line 37, Named "StartRuntime"
            while var16_upvw do
                local squareroot = math.sqrt(1 - math.clamp((Time_upvr.GetNowSync() - var15_upvw.CollectedAt) / var15_upvw.Timeout, 0, 1))
                PowerPlantRobberyGui_upvr.Price.Value.Size = UDim2.new(squareroot, 0, 1, 0)
                local string_match_result1, string_match_result2_2, string_match_result3_2 = string.match(math.floor(var15_upvw.BaseWorth * squareroot / 50 + 0.5) * 50, "^([^%d]*%d)(%d*)(.-)$")
                PowerPlantRobberyGui_upvr.Price.TextLabel.Text = "Uranium Value: $%s":format(string_match_result1..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2)
                wait(0.1)
            end
        end
        local function _() -- Line 50, Named "Show"
            local var21
            if var16_upvw ~= false then
                var21 = false
            else
                var21 = true
            end
            assert(var21)
            var16_upvw = true
            var21 = LocalPlayer_upvr
            var21 = var21.PlayerGui
            PowerPlantRobberyGui_upvr.Parent = var21
            var21 = StartRuntime_upvr
            spawn(var21)
        end
        local function _() -- Line 56, Named "Hide"
            local var22
            if var16_upvw ~= true then
                var22 = false
            else
                var22 = true
            end
            assert(var22)
            var22 = nil
            PowerPlantRobberyGui_upvr.Parent = var22
            var16_upvw = false
        end
        Binder_upvr.new("PowerPlantCore", require(script.Parent.Core)):Start()
        local var23_upvw
        function em.d1c4ep0r() -- Line 71
            Audio_upvr.ObjectLocal(LocalPlayer_upvr, 1837831244)
            delay(1, function() -- Line 73
                Audio_upvr.ObjectLocal(LocalPlayer_upvr, 1843025542)
            end)
            any_ObjectLocal_result1_upvr.Volume = 0
            any_ObjectLocal_result1_upvr:Play()
            Audio_upvr.FadeTo(any_ObjectLocal_result1_upvr, 0.3, 2)
            if var23_upvw ~= nil then
                var23_upvw:Disconnect()
                var23_upvw = nil
            end
            any_ObjectLocal_result1_upvr_2.Volume = 0
            any_ObjectLocal_result1_upvr_2:Play()
            var23_upvw = Audio_upvr.FadeTo(any_ObjectLocal_result1_upvr_2, 0.3, 2)
        end
        function em.ot6bg255() -- Line 88
            if var23_upvw ~= nil then
                var23_upvw:Disconnect()
                var23_upvw = nil
            end
            Audio_upvr.FadeTo(any_ObjectLocal_result1_upvr, 0, 2, function() -- Line 93
                any_ObjectLocal_result1_upvr:Stop()
            end)
            if var16_upvw == false then
                var23_upvw = Audio_upvr.FadeTo(any_ObjectLocal_result1_upvr_2, 0, 2, function() -- Line 99
                    any_ObjectLocal_result1_upvr_2:Stop()
                end)
            end
        end
        function em.jnoz6n6r(arg1_2) -- Line 104
            local var27 = LocalPlayer_upvr
            Audio_upvr.ObjectLocal(var27, 3280045717)
            var15_upvw = arg1_2
            if var16_upvw ~= false then
                var27 = false
            else
                var27 = true
            end
            assert(var27)
            var16_upvw = true
            PowerPlantRobberyGui_upvr.Parent = LocalPlayer_upvr.PlayerGui
            spawn(StartRuntime_upvr)
        end
        function em.axaze38d() -- Line 110
            Audio_upvr.ObjectLocal(script, 1988476450)
        end
        function em.u8bct66l() -- Line 113
            local var28 = any_ObjectLocal_result1_upvr_2
            Audio_upvr.FadeTo(var28, 0, 2, function() -- Line 115
                any_ObjectLocal_result1_upvr_2:Stop()
            end)
            if var16_upvw == true then
                if var16_upvw ~= true then
                    var28 = false
                else
                    var28 = true
                end
                assert(var28)
                var28 = nil
                PowerPlantRobberyGui_upvr.Parent = var28
                var16_upvw = false
            end
        end
        Binder_upvr.new("Piston", require(script.Parent.Piston)):Start()
    end;
}