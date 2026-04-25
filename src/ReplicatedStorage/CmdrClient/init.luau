-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))
if RunService:IsClient() == false then
	error("[Cmdr] Server scripts cannot require the client library. Please require the server library from the server to use Cmdr in your own code.")
end
local CmdrClient = setmetatable({
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
	__index = function(self, p2)
		local method = self.Dispatcher[p2]
		if method and type(method) == "function" then
			return function(firstArg, ...)
				return method(self.Dispatcher, ...)
			end
		end
	end
})
CmdrClient.Registry = require(Shared.Registry)(CmdrClient)
CmdrClient.Dispatcher = require(Shared.Dispatcher)(CmdrClient)
local Interface = require(script.CmdrInterface)(CmdrClient)
function CmdrClient.SetActivationKeys(self, p2)
	self.ActivationKeys = Util.MakeDictionary(p2)
end
function CmdrClient.SetPlaceName(self, p2)
	self.PlaceName = p2
	Interface.Window:UpdateLabel()
end
function CmdrClient.SetEnabled(self, p2)
	self.Enabled = p2
end
function CmdrClient.SetActivationUnlocksMouse(self, p2)
	self.ActivationUnlocksMouse = p2
end
function CmdrClient.Show(self)
	if self.Enabled then
		Interface.Window:Show()
	end
end
function CmdrClient.Hide(self)
	Interface.Window:Hide()
end
function CmdrClient.Toggle(self)
	if self.Enabled then
		Interface.Window:SetVisible(not Interface.Window:IsVisible())
	else
		self:Hide()
	end
end
function CmdrClient.SetMashToEnable(self, p2)
	self.MashToEnable = p2
	if p2 then
		self:SetEnabled(false)
	end
end
function CmdrClient.SetHideOnLostFocus(self, p2)
	self.HideOnLostFocus = p2
end
function CmdrClient.HandleEvent(self, p2, handler)
	self.Events[p2] = handler
end
if RunService:IsServer() == false then
	task.delay(1, function()
		CmdrClient.Registry:RegisterTypesIn(script:WaitForChild("Types"))
		CmdrClient.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
	end)
end
CmdrClient.RemoteEvent.OnClientEvent:Connect(function(p1, ...)
	if CmdrClient.Events[p1] then
		CmdrClient.Events[p1](...)
	end
end)
require(script.DefaultEventHandlers)(CmdrClient)
return CmdrClient
