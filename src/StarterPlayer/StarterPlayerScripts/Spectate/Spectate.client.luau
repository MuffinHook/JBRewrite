-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCHNwZWN0YXRlC0xvY2FsUGxheWVyF1NIT1dfU1BFQ1RBVEVfQVRUUl9OQU1FDEdldEF0dHJpYnV0ZQdzaG93R3VpB2hpZGVHdWkOaGFuZGxlU3BlY3RhdGUEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQhTcGVjdGF0ZQ9TcGVjdGF0ZVNlcnZpY2UOU3BlY3RhdGVDb25zdHMUU1BFQ1RBVEVfUkVNT1RFX05BTUUMV2FpdEZvckNoaWxkDU9uQ2xpZW50RXZlbnQHQ29ubmVjdBlHZXRBdHRyaWJ1dGVDaGFuZ2VkU2lnbmFsAAMCAAEBAAAHowAAAPsAAABNAABHAAAAAN0BAACfAAABggABAAEDAQAHAAEYAAEAAAAAAQcAAAAAAwADAAAAFfsAAABNAAAxAAAAAPsCAQBNAgJtAQAAALwAABICAAAAnwADAioABgABAACA+wECAE0BAZ4DAAAAnwEBAYIAAQD7AQIATQEBzAQAAACfAQEBggABAAUDAgMDAwQDBQMGAAsHARgAAAAAAAAAAAABAAEAAAAAAgAAAAIMAAAAAAkAAAECAEmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBNAwEnBwAAAE0DA+QIAAAAnwICAqQDBgAAAFBATQQBJwcAAABNBASyCQAAAJ8DAgJNBAAxCgAAAE0GA3oLAAAAvAQE0wwAAACfBAMCTQUEjA0AAADABw4AEgACALwFBccPAAAAnwUDAcAFEAASAAAAEgADABIAAgBNBgAxCgAAAE0IA20RAAAAvAYGEhIAAACfBgMCKgYFAAEAAIBNBwKeEwAAAJ8HAQFlAAMATQcCzBQAAACfBwEBTQYAMQoAAABNCANtEQAAALwGBhYVAAAAnwYDAlIIBQC8BgbHDwAAAJ8GAwGCAAEAFgMIBAAAAEADCQMKAwsDDAQAAFBAAw0DDgMPAwIDEAMRAxIGAAMTBgEDAwMEAwUDBgMUAgABAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAgAAAAAAAAEAAAAAAAABAAAAAAAABAAAAAEAAAAAAAABAAEAAAACAAAEAAAAAAAAAAAAAAEBAAAAAAI+lijkZE96/kt1BMiqJe9tTo4/kAxSQuU=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:53
-- Luau version 6, Types version 3
-- Time taken: 0.001373 seconds

local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpectateService_upvr = require(ReplicatedStorage.Spectate.SpectateService)
local SpectateConsts_upvr = require(ReplicatedStorage.Spectate.SpectateConsts)
Players_upvr.LocalPlayer:WaitForChild(SpectateConsts_upvr.SPECTATE_REMOTE_NAME).OnClientEvent:Connect(function(...) -- Line 7
    --[[ Upvalues[1]:
        [1]: SpectateService_upvr (readonly)
    ]]
    SpectateService_upvr.spectate(...)
end)
if Players_upvr.LocalPlayer:GetAttribute(SpectateConsts_upvr.SHOW_SPECTATE_ATTR_NAME) == true then
    SpectateService_upvr.showGui()
else
    SpectateService_upvr.hideGui()
end
Players_upvr.LocalPlayer:GetAttributeChangedSignal(SpectateConsts_upvr.SHOW_SPECTATE_ATTR_NAME):Connect(function() -- Line 11, Named "handleSpectate"
    --[[ Upvalues[3]:
        [1]: Players_upvr (readonly)
        [2]: SpectateConsts_upvr (readonly)
        [3]: SpectateService_upvr (readonly)
    ]]
    if Players_upvr.LocalPlayer:GetAttribute(SpectateConsts_upvr.SHOW_SPECTATE_ATTR_NAME) == true then
        SpectateService_upvr.showGui()
    else
        SpectateService_upvr.hideGui()
    end
end)