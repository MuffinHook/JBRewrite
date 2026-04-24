-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))
if RunService:IsClient() == false then
	error("[Cmdr] Server scripts cannot require the client library. Please require the server library from the server to use Cmdr in your own code.")
end
local v1 = setmetatable({
	ReplicatedRoot = script,
	RemoteFunction = script:WaitForChild("CmdrFunction"),
	RemoteEvent = script:WaitForChild("CmdrEvent"),
	ActivationKeys = {
		[Enum.KeyCode.F2] = true
	},
	Enabled = true,
	MashToEnable = false,
	ActivationUnlocksMouse = false,
	HideOnLostFocus = true,
	PlaceName = "Cmdr",
	Util = Util,
	Events = {}
}, {
	__index = function(p1, p2)
		local v1 = p1.Dispatcher[p2]
		if v1 and type(v1) == "function" then
			return function(p12, ...)
				return v1(p1.Dispatcher, ...)
			end
		end
	end
})
v1.Registry = require(Shared.Registry)(v1)
v1.Dispatcher = require(Shared.Dispatcher)(v1)
local v2 = require(script.CmdrInterface)(v1)
function v1.SetActivationKeys(p1, p2)
	p1.ActivationKeys = Util.MakeDictionary(p2)
end
function v1.SetPlaceName(p1, p2)
	p1.PlaceName = p2
	v2.Window:UpdateLabel()
end
function v1.SetEnabled(p1, p2)
	p1.Enabled = p2
end
function v1.SetActivationUnlocksMouse(p1, p2)
	p1.ActivationUnlocksMouse = p2
end
function v1.Show(p1)
	if p1.Enabled then
		v2.Window:Show()
	end
end
function v1.Hide(p1)
	v2.Window:Hide()
end
function v1.Toggle(p1)
	if p1.Enabled then
		v2.Window:SetVisible(not v2.Window:IsVisible())
	else
		p1:Hide()
	end
end
function v1.SetMashToEnable(p1, p2)
	p1.MashToEnable = p2
	if p2 then
		p1:SetEnabled(false)
	end
end
function v1.SetHideOnLostFocus(p1, p2)
	p1.HideOnLostFocus = p2
end
function v1.HandleEvent(p1, p2, p3)
	p1.Events[p2] = p3
end
if RunService:IsServer() == false then
	task.delay(1, function()
		v1.Registry:RegisterTypesIn(script:WaitForChild("Types"))
		v1.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
	end)
end
v1.RemoteEvent.OnClientEvent:Connect(function(p1, ...)
	if v1.Events[p1] then
		v1.Events[p1](...)
	end
end)
require(script.DefaultEventHandlers)(v1)
return v1
