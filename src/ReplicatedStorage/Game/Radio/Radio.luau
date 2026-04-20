local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Window_upvr = require(ReplicatedStorage_upvr.Module.Window.Window)
local RadioUI_upvr = require(script.Parent.RadioUI)
local ActionButtonService_upvr = require(ReplicatedStorage_upvr.ActionButton.ActionButtonService)
local RadioPlayer_upvr = require(script.Parent.RadioPlayer)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
function module_upvr.Init() -- Line 14
    local RadioGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("RadioGui")
    RadioGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.Gui = RadioGui
    module_upvr.Window = Window_upvr.new()
    local var10_upvw
    module_upvr.Window:GetOnOpenedSignal():Connect(function() -- Line 20
        var10_upvw = RadioUI_upvr.new(module_upvr.Gui)
        var10_upvw.Maid:GiveTask(var10_upvw.Gui.Container.Close.MouseButton1Down:Connect(function() -- Line 22
            module_upvr.Close()
        end))
        var10_upvw.Maid:GiveTask(ActionButtonService_upvr.pushHide())
    end)
    module_upvr.Window:GetOnClosedSignal():Connect(function() -- Line 27
        var10_upvw:Destroy()
        var10_upvw = nil
    end)
    if module_upvr.Gui.Enabled then
        module_upvr.Window:Open()
    end
    RadioPlayer_upvr.OnSongEnded:Connect(function() -- Line 36
        if RadioPlayer_upvr.PlayRandomSongAfter then
            RadioPlayer_upvr.PlayRandomSong()
            if var10_upvw ~= nil then
                var10_upvw:UpdatePlayButton()
            end
        end
    end)
    GameUtil_upvr.getCenterWindowGroup():Add(module_upvr.Window)
end
function module_upvr.Open() -- Line 47
    return module_upvr.Window:Open()
end
function module_upvr.Close() -- Line 50
    return module_upvr.Window:Close()
end
function module_upvr.IsOpen() -- Line 53
    return module_upvr.Window:IsOpen()
end
function module_upvr.Toggle() -- Line 56
    if module_upvr.IsOpen() then
        module_upvr.Close()
    else
        module_upvr.Open()
    end
end
return module_upvr