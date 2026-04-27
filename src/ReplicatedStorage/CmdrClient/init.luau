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
	__index = function(self, methodName)
		local method = self.Dispatcher[methodName]
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
function CmdrClient.SetActivationKeys(self, keys)
	self.ActivationKeys = Util.MakeDictionary(keys)
end
function CmdrClient.SetPlaceName(self, placeName)
	self.PlaceName = placeName
	Interface.Window:UpdateLabel()
end
function CmdrClient.SetEnabled(self, enabled)
	self.Enabled = enabled
end
function CmdrClient.SetActivationUnlocksMouse(self, unlocks)
	self.ActivationUnlocksMouse = unlocks
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
function CmdrClient.SetMashToEnable(self, enabled)
	self.MashToEnable = enabled
	if enabled then
		self:SetEnabled(false)
	end
end
function CmdrClient.SetHideOnLostFocus(self, hideOnLostFocus)
	self.HideOnLostFocus = hideOnLostFocus
end
function CmdrClient.HandleEvent(self, eventName, handler)
	self.Events[eventName] = handler
end
if RunService:IsServer() == false then
	task.delay(1, function()
		CmdrClient.Registry:RegisterTypesIn(script:WaitForChild("Types"))
		CmdrClient.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
	end)
end
CmdrClient.RemoteEvent.OnClientEvent:Connect(function(eventName, ...)
	if CmdrClient.Events[eventName] then
		CmdrClient.Events[eventName](...)
	end
end)
require(script.DefaultEventHandlers)(CmdrClient)
return CmdrClient
