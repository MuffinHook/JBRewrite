local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpectateService_upvr = require(ReplicatedStorage.Spectate.SpectateService)
local SpectateConsts_upvr = require(ReplicatedStorage.Spectate.SpectateConsts)
Players_upvr.LocalPlayer:WaitForChild(SpectateConsts_upvr.SPECTATE_REMOTE_NAME).OnClientEvent:Connect(function(...) -- Line 7
    SpectateService_upvr.spectate(...)
end)
if Players_upvr.LocalPlayer:GetAttribute(SpectateConsts_upvr.SHOW_SPECTATE_ATTR_NAME) == true then
    SpectateService_upvr.showGui()
else
    SpectateService_upvr.hideGui()
end
Players_upvr.LocalPlayer:GetAttributeChangedSignal(SpectateConsts_upvr.SHOW_SPECTATE_ATTR_NAME):Connect(function() -- Line 11, Named "handleSpectate"
    if Players_upvr.LocalPlayer:GetAttribute(SpectateConsts_upvr.SHOW_SPECTATE_ATTR_NAME) == true then
        SpectateService_upvr.showGui()
    else
        SpectateService_upvr.hideGui()
    end
end)