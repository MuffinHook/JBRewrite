local Players_upvr = game:GetService("Players")
local module_upvr = {}
local Audio_upvr = require(game:GetService("ReplicatedStorage").Std.Audio)
function module_upvr.init() -- Line 8
    local var4_upvw
    local var5_upvw
    Players_upvr.LocalPlayer:GetAttributeChangedSignal("NightclubMusicPlaying"):Connect(function() -- Line 11
        if var5_upvw then
            var5_upvw:cancel()
            var5_upvw = nil
        end
        if var4_upvw then
            local var7_upvr = var4_upvw
            var4_upvw = nil
            Audio_upvr.promiseFadeTo(var7_upvr, 0, 3):finally(function() -- Line 19
                var7_upvr:Destroy()
            end)
        end
        var7_upvr = module_upvr
        var7_upvr = var7_upvr.isMusicPlaying()
        if var7_upvr then
            var7_upvr = Audio_upvr
            var7_upvr = var7_upvr.ObjectLocal
            var7_upvr = var7_upvr(Players_upvr.LocalPlayer.PlayerGui, 1839822990, {
                Looped = true;
                Volume = 0;
            })
            var4_upvw = var7_upvr
            var7_upvr = var4_upvw
            var7_upvr.SoundGroup = game:GetService("SoundService"):FindFirstChild("RobberyMusic")
            var7_upvr = var4_upvw
            var7_upvr.Name = "ClubMusic"
            var7_upvr = Instance.new("ReverbSoundEffect")
            local var10 = var7_upvr
            var10.Enabled = module_upvr.isMusicMuffled()
            var10.DecayTime = 5
            var10.Parent = var4_upvw
            var5_upvw = Audio_upvr.promiseFadeTo(var4_upvw, 0.4, 3):finally(function() -- Line 31
                var5_upvw = nil
            end)
        end
    end)
    Players_upvr.LocalPlayer:GetAttributeChangedSignal("NightclubMusicMuffled"):Connect(function() -- Line 36
        if var5_upvw then
            var5_upvw:cancel()
            var5_upvw = nil
        end
        local var14
        if var4_upvw then
            if module_upvr.isMusicMuffled() then
                var14 = 0.04000000000000001
            else
                var14 = 0.4
            end
            function var14() -- Line 47
                var5_upvw = nil
            end
            var5_upvw = Audio_upvr.promiseFadeTo(var4_upvw, var14, 0.1):finally(var14)
            var14 = "ReverbSoundEffect"
            var4_upvw:FindFirstChild(var14).Enabled = module_upvr.isMusicMuffled()
        end
    end)
end
function module_upvr.isMusicPlaying() -- Line 56
    local var15
    if Players_upvr.LocalPlayer:GetAttribute("NightclubMusicPlaying") ~= true then
        var15 = false
    else
        var15 = true
    end
    return var15
end
function module_upvr.isMusicMuffled() -- Line 59
    local var16
    if Players_upvr.LocalPlayer:GetAttribute("NightclubMusicMuffled") ~= true then
        var16 = false
    else
        var16 = true
    end
    return var16
end
return module_upvr