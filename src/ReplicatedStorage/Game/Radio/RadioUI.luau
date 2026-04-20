local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RadioConfig_upvr = require(script.Parent.RadioConfig)
local RadioPlayer_upvr = require(script.Parent.RadioPlayer)
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new(arg1) -- Line 15
    assert(arg1)
    local module = {}
    setmetatable(module, module_upvr)
    module.Gui = arg1
    module.Maid = Maid_upvr.new()
    module:ConnectPlayer()
    module:ConnectStations()
    module.Gui.Enabled = true
    return module
end
local Slider_upvr = require(script.Parent.Slider)
function module_upvr.ConnectPlayer(arg1) -- Line 30
    local Player = arg1.Gui.Container.Player
    local TextBox_upvr = Player.Left.SongId.TextBox
    arg1.Maid:GiveTask(TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 34
        if TextBox_upvr.Text:find("%D+") then
            TextBox_upvr.Text = TextBox_upvr.Text:gsub("%D+", "")
        end
    end))
    arg1.Maid:GiveTask(Player.Left.Toggle.MouseButton1Down:Connect(function() -- Line 39
        if RadioPlayer_upvr.IsPlaying() then
            arg1:StopSong()
        else
            arg1:PlayCustomSong()
        end
    end))
    arg1.Maid:GiveTask(RadioPlayer_upvr.OnSongStarted:Connect(function() -- Line 46
        arg1:UpdatePlayButton()
    end))
    arg1.Maid:GiveTask(RadioPlayer_upvr.OnSongStopped:Connect(function() -- Line 49
        arg1:UpdatePlayButton()
    end))
    arg1.Maid:GiveTask(RadioPlayer_upvr.OnSongEnded:Connect(function() -- Line 52
        arg1:UpdatePlayButton()
    end))
    local any_new_result1_2 = Slider_upvr.new(Player.Right.SliderBass)
    arg1.Maid:GiveTask(any_new_result1_2)
    any_new_result1_2.OnValueChanged:Connect(function(arg1_2) -- Line 58
        RadioConfig_upvr.Bass = arg1_2
        RadioPlayer_upvr.SetBass(arg1_2)
    end)
    any_new_result1_2:SetValue(RadioConfig_upvr.Bass)
    local any_new_result1 = Slider_upvr.new(Player.Right.SliderVolume)
    any_new_result1.OnValueChanged:Connect(function(arg1_3) -- Line 66
        RadioConfig_upvr.Volume = arg1_3
        RadioPlayer_upvr.SetVolume(arg1_3)
    end)
    any_new_result1:SetValue(RadioConfig_upvr.Volume)
    arg1.Maid:GiveTask(any_new_result1)
end
function module_upvr.ConnectStations(arg1) -- Line 74
    for _, v_upvr in ipairs(arg1.Gui.Container.Stations.ContainerStations:GetChildren()) do
        if v_upvr:IsA("Frame") then
            arg1.Maid:GiveTask(v_upvr.Button.MouseButton1Down:Connect(function() -- Line 79
                RadioConfig_upvr.Playlist = v_upvr.Name
                RadioPlayer_upvr.PlayRandomSongAfter = true
                RadioPlayer_upvr.PlayRandomSong()
                arg1:OpenSidebar(RadioConfig_upvr.Playlist)
            end))
        end
    end
    if RadioConfig_upvr.Playlist then
        arg1:OpenSidebar(RadioConfig_upvr.Playlist)
    end
end
local RadioList_upvr = require(script.Parent.RadioList)
function module_upvr.OpenSidebar(arg1, arg2) -- Line 93
    if arg1.mRadioList ~= nil then
        arg1.mRadioList:Destroy()
        arg1.mRadioList = nil
    end
    arg1.mRadioList = RadioList_upvr.new(arg1.Gui)
    arg1.mRadioList:Populate(RadioPlayer_upvr.GetPlaylist(arg2))
    arg1.mRadioList.Maid:GiveTask(arg1.mRadioList.OnRefreshRequested:Connect(function() -- Line 100
        arg1:OpenSidebar(arg2)
    end))
end
function module_upvr.StopSong(arg1) -- Line 104
    RadioPlayer_upvr.Stop()
end
local RadioUtils_upvr = require(script.Parent.RadioUtils)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
function module_upvr.PlayCustomSong(arg1) -- Line 107
    local tonumber_result1_2 = tonumber(arg1.Gui.Container.Player.Left.SongId.TextBox.Text)
    if tonumber_result1_2 == nil and RadioConfig_upvr.Playlist ~= nil then
        RadioPlayer_upvr.PlayRandomSongAfter = true
        RadioPlayer_upvr.PlayRandomSong()
    else
        assert(tonumber_result1_2)
        if not RadioUtils_upvr.CheckOrPromptStereoGamepass() then
            return false
        end
        local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr.GetLocalVehiclePacket()
        RadioPlayer_upvr.PlayRandomSongAfter = true
        local any_IsPlayingThirdPerson_result1 = RadioPlayer_upvr.IsPlayingThirdPerson()
        if not any_IsPlayingThirdPerson_result1 then
            any_IsPlayingThirdPerson_result1 = false
            if any_GetLocalVehiclePacket_result1 ~= nil then
                any_IsPlayingThirdPerson_result1 = not any_GetLocalVehiclePacket_result1.Passenger
            end
        end
        RadioPlayer_upvr.PlayId(tonumber_result1_2, nil, any_IsPlayingThirdPerson_result1)
    end
end
function module_upvr.UpdatePlayButton(arg1) -- Line 131
    local var35
    if RadioPlayer_upvr.IsPlaying() then
        var35 = "PAUSE"
    else
        var35 = "PLAY"
    end
    arg1.Gui.Container.Player.Left.Toggle.TextLabel.Text = var35
end
function module_upvr.Destroy(arg1) -- Line 136
    arg1.Gui.Enabled = false
    arg1.Gui = nil
    if arg1.mRadioList then
        arg1.mRadioList:Destroy()
        arg1.mRadioList = nil
    end
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr