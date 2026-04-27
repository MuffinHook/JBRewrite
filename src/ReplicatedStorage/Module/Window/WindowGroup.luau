local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local WindowGroup = {}
WindowGroup.__index = WindowGroup
function WindowGroup.new()
	local instance = {}
	setmetatable(instance, WindowGroup)
	instance._maid = Maid.new()
	instance._listWindow = {}
	instance._maid:GiveTask(function()
		for i, listedWindow in ipairs(instance._listWindow) do
			listedWindow:Destroy()
		end
		instance._listWindow = nil
	end)
	return instance
end
function WindowGroup.Add(self, window)
	assert(window.__ClassName == "Window")
	for i, listedWindow in ipairs(self._listWindow) do
		if window == listedWindow then
			error("Window already exists in group.")
		end
	end
	table.insert(self._listWindow, window)
	function window._beforeOpenFun()
		for i, listedWindow in ipairs(self._listWindow) do
			if listedWindow ~= window and listedWindow:IsOpen() then
				listedWindow:Close()
			end
		end
	end
end
function WindowGroup.Destroy(self)
	assert(self._maid)
	local maidToDestroy = self._maid
	self._maid = nil
	maidToDestroy:Destroy()
end
return WindowGroup
