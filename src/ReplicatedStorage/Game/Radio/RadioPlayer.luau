local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RadioConfig_upvr = require(script.Parent.RadioConfig)
local Music_upvr = game:GetService("SoundService"):FindFirstChild("Music")
local var7_upvw
local module_upvr = {
    CacheMapNamePlaylist = {};
    CurrentSound = nil;
    CurrentSoundId = nil;
    FadeInConn = nil;
    PlayRandomSongAfter = true;
    Maid = require(ReplicatedStorage.Std.Maid).new();
    OnSongStarted = Signal.new();
    OnSongStopped = Signal.new();
    OnSongEnded = Signal.new();
    OnPlaylistUpdated = Signal.new();
}
function module_upvr.Init(arg1) -- Line 33
    var7_upvw = arg1.Event
    VehicleUtils_upvr.OnVehicleEntered:Connect(function() -- Line 37
        if module_upvr.IsPlaying() then
            module_upvr.PlayId(module_upvr.CurrentSoundId, module_upvr.CurrentSound.TimePosition, true)
        end
    end)
    local os_clock_result1_upvw = os.clock()
    VehicleUtils_upvr.OnVehicleJumpExited:Connect(function() -- Line 43
        if module_upvr.IsPlayingThirdPerson() and 0.5 < os.clock() - os_clock_result1_upvw then
            os_clock_result1_upvw = os.clock()
            module_upvr.PlayId(module_upvr.CurrentSoundId, module_upvr.CurrentSound.TimePosition, false)
        end
    end)
    module_upvr.OnPlaylistUpdated:Connect(function(arg1_2) -- Line 52
        if arg1_2.Persist then
            var7_upvw:FireServer('n'.."baedz":sub(2, 2):reverse().."".."".."nt50eyyk3":sub(3, 7):reverse():reverse():reverse():reverse():reverse()..""..'6', arg1_2.Title, arg1_2.Songs)
        end
    end)
    arg1.em.zgowty66 = function(arg1_3) -- Line 58, Named "zgowty66"
        for i, v in pairs(arg1_3) do
            module_upvr.GetPlaylist(i).Songs = v
        end
    end
end
local RadioUtils_upvr = require(script.Parent.RadioUtils)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.PlayId(arg1, arg2, arg3) -- Line 65
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var21 = arg1
    assert(var21)
    if type(arg1) ~= "number" then
        var21 = false
    else
        var21 = true
    end
    assert(var21)
    if 0 >= arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var22
    assert(true)
    if var22 and not RadioUtils_upvr.HasSteroGamepass() then
        print("Requested third person, but no gamepass....")
        var22 = false
    end
    if MarketplaceService_upvr:GetProductInfo(arg1).AssetTypeId ~= Enum.AssetType.Audio.Value then
        error("AssetId `%d` is not a valid audio asset.":format(arg1))
        return false
    end
    module_upvr.Stop()
    module_upvr.CurrentSoundId = arg1
    local var23
    if var22 then
        local any_GetLocalVehiclePacket_result1_3 = VehicleUtils_upvr.GetLocalVehiclePacket()
        assert(any_GetLocalVehiclePacket_result1_3)
        var23 = any_GetLocalVehiclePacket_result1_3.RadioSound
        assert(var23)
        var23.Volume = 0
        var7_upvw:FireServer('s'.."".."zsfrcvgguxy":sub(3, 7):reverse().."".."yo", arg1, arg2)
    else
        var23 = Audio_upvr.ObjectLocal(LocalPlayer_upvr, arg1, {
            DoNotPlay = true;
            Volume = 0;
        })
        if arg2 ~= nil then
            var23.TimePosition = arg2
        end
    end
    module_upvr.CurrentSound = var23
    module_upvr.Maid.EndedConn = var23.Ended:Connect(function() -- Line 101
        module_upvr.Stop()
        module_upvr.OnSongEnded:Fire()
    end)
    var23.SoundGroup = Music_upvr
    var23.PlaybackSpeed = RadioConfig_upvr.PlaybackSpeed
    if not var22 then
        task.spawn(var23.Play, var23)
    end
    module_upvr.Maid.FadeInConn = Audio_upvr.FadeTo(var23, RadioConfig_upvr.Volume, 1, function() -- Line 111
        module_upvr.Maid.FadeInConn = nil
    end)
    RadioConfig_upvr.MapSoundIdPlays[arg1] = module_upvr.GetPlays(arg1) + 1
    module_upvr.OnSongStarted:Fire(arg1)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Math_upvr = require(ReplicatedStorage.Module.Math)
function module_upvr.PlayRandomSong() -- Line 117
    local assert_result1 = assert(module_upvr.GetPlaylist(RadioConfig_upvr.Playlist).Songs)
    if #assert_result1 == 0 then
    else
        for i_2, v_2 in ipairs(assert_result1) do
            ({})[i_2] = module_upvr.GetPlays(v_2.AssetId)
            local var63
        end
        local tbl = {}
        local var68
        for i_3, v_3 in ipairs(var63) do
            if v_3 <= math.min(unpack(var63)) then
                var68 = 1
            else
                var68 = 0
            end
            tbl[i_3] = var68
        end
        local any_GetLocalVehiclePacket_result1_2 = VehicleUtils_upvr.GetLocalVehiclePacket()
        local any_IsPlayingThirdPerson_result1 = module_upvr.IsPlayingThirdPerson()
        if not any_IsPlayingThirdPerson_result1 then
            any_IsPlayingThirdPerson_result1 = false
            if any_GetLocalVehiclePacket_result1_2 ~= nil then
                any_IsPlayingThirdPerson_result1 = not any_GetLocalVehiclePacket_result1_2.Passenger
            end
        end
        module_upvr.PlayId(assert_result1[Math_upvr.WeightedRandom(tbl)].AssetId, nil, any_IsPlayingThirdPerson_result1)
    end
end
function module_upvr.GetPlaylist(arg1) -- Line 142
    if module_upvr.CacheMapNamePlaylist[arg1] then
        return module_upvr.CacheMapNamePlaylist[arg1]
    end
    module_upvr.CacheMapNamePlaylist[arg1] = require(script.Parent.PlaylistData[arg1])
    return module_upvr.CacheMapNamePlaylist[arg1]
end
function module_upvr.GetPlays(arg1) -- Line 149
    return RadioConfig_upvr.MapSoundIdPlays[arg1] or 0
end
function module_upvr.SetVolume(arg1) -- Line 152
    if module_upvr.IsPlaying() then
        module_upvr.CurrentSound.Volume = arg1
    end
end
function module_upvr.SetBass(arg1) -- Line 157
    local var71 = 1 - arg1
    local var72 = 1 - var71
    Music_upvr.EqualizerSoundEffect.LowGain = var71 * -5 + var72 * 5
    Music_upvr.EqualizerSoundEffect.MidGain = var72 * -1.5 + var71 * 1.5
    Music_upvr.EqualizerSoundEffect.HighGain = var72 * -1.5 + var71 * 1.5
end
function module_upvr.Stop() -- Line 173
    module_upvr.Maid.FadeInConn = nil
    if module_upvr.CurrentSound ~= nil then
        module_upvr.CurrentSoundId = nil
        local CurrentSound_upvr = module_upvr.CurrentSound
        module_upvr.CurrentSound = nil
        if CurrentSound_upvr:IsDescendantOf(workspace) then
            var7_upvw:FireServer('e'.."xclp6xcag":sub(5, 5):reverse().."".."e8mna2")
        else
            Audio_upvr.FadeTo(CurrentSound_upvr, 0, 1, function() -- Line 182
                CurrentSound_upvr:Destroy()
            end)
        end
        module_upvr.OnSongStopped:Fire()
    end
end
function module_upvr.IsPlaying() -- Line 189
    local var75
    if module_upvr.CurrentSound == nil then
        var75 = false
    else
        var75 = true
    end
    return var75
end
function module_upvr.IsPlayingThirdPerson() -- Line 192
    local any_IsPlaying_result1 = module_upvr.IsPlaying()
    if any_IsPlaying_result1 then
        any_IsPlaying_result1 = module_upvr
        any_IsPlaying_result1 = any_IsPlaying_result1.CurrentSound:IsDescendantOf(workspace)
    end
    return any_IsPlaying_result1
end
return module_upvr