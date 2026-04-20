local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Players_upvr = game:GetService("Players")
local LevelUISystem_upvr = require(ReplicatedStorage.Game.Level2.LevelUISystem)
function module.init() -- Line 8
    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9742813686, {
        Looped = true;
        Volume = 0.1;
    })
    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9742811639, {
        Looped = true;
        Volume = 0.4;
        GroupName = "RobberyMusic";
    })
    LevelUISystem_upvr.hideTopbar()
end
return module