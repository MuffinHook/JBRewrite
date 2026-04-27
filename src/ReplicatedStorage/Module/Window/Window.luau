local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {
	__ClassName = "Window"
}
t.__index = t
function t.new()
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._isOpen = false
	t2._beforeOpenFun = nil
	return t2
end
function t.GetOnOpenedSignal(self)
	if not self._onOpened then
		self._onOpened = Signal.new()
		self._maid:GiveTask(self._onOpened)
	end
	return self._onOpened
end
function t.GetOnClosedSignal(self)
	if not self._onClosed then
		self._onClosed = Signal.new()
		self._maid:GiveTask(self._onClosed)
	end
	return self._onClosed
end
function t.Open(self)
	assert(not self._isOpen)
	self._isOpen = true
	if self._beforeOpenFun then
		self:_beforeOpenFun()
	end
	if self._onOpened then
		self._onOpened:Fire()
	end
end
function t.Close(self)
	assert(self._isOpen)
	self._isOpen = false
	if self._onClosed then
		self._onClosed:Fire()
	end
end
function t.IsOpen(self)
	return self._isOpen
end
function t.Destroy(self)
	assert(self._maid)
	if self:IsOpen() then
		self:Close()
	end
	local _maid_2 = self._maid
	self._maid = nil
	_maid_2:Destroy()
end
return t
