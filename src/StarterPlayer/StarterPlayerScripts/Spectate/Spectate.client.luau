local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpectateService = require(ReplicatedStorage.Spectate.SpectateService)
local SpectateConsts = require(ReplicatedStorage.Spectate.SpectateConsts)
Players.LocalPlayer:WaitForChild(SpectateConsts.SPECTATE_REMOTE_NAME).OnClientEvent:Connect(function(...) --[[ Line: 7 | Upvalues: SpectateService (copy) ]]
	SpectateService.spectate(...)
end)
local function handleSpectate() --[[ Line: 11 | Upvalues: Players (copy), SpectateConsts (copy), SpectateService (copy) ]]
	if Players.LocalPlayer:GetAttribute(SpectateConsts.SHOW_SPECTATE_ATTR_NAME) == true then
		SpectateService.showGui()
	else
		SpectateService.hideGui()
	end
end
if Players.LocalPlayer:GetAttribute(SpectateConsts.SHOW_SPECTATE_ATTR_NAME) == true then
	SpectateService.showGui()
else
	SpectateService.hideGui()
end
Players.LocalPlayer:GetAttributeChangedSignal(SpectateConsts.SHOW_SPECTATE_ATTR_NAME):Connect(handleSpectate)