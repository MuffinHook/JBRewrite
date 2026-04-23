local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {
	__ClassName = "Window"
}
t.__index = t
function t.new() --[[ Line: 8 | Upvalues: t (copy), Maid (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._isOpen = false
	t2._beforeOpenFun = nil
	return t2
end
function t.GetOnOpenedSignal(p1) --[[ Line: 19 | Upvalues: Signal (copy) ]]
	if not p1._onOpened then
		p1._onOpened = Signal.new()
		p1._maid:GiveTask(p1._onOpened)
	end
	return p1._onOpened
end
function t.GetOnClosedSignal(p1) --[[ Line: 26 | Upvalues: Signal (copy) ]]
	if not p1._onClosed then
		p1._onClosed = Signal.new()
		p1._maid:GiveTask(p1._onClosed)
	end
	return p1._onClosed
end
function t.Open(p1) --[[ Line: 33 ]]
	assert(not p1._isOpen)
	p1._isOpen = true
	if p1._beforeOpenFun then
		p1:_beforeOpenFun()
	end
	if p1._onOpened then
		p1._onOpened:Fire()
	end
end
function t.Close(p1) --[[ Line: 43 ]]
	assert(p1._isOpen)
	p1._isOpen = false
	if p1._onClosed then
		p1._onClosed:Fire()
	end
end
function t.IsOpen(p1) --[[ Line: 50 ]]
	return p1._isOpen
end
function t.Destroy(p1) --[[ Line: 53 ]]
	assert(p1._maid)
	if p1:IsOpen() then
		p1:Close()
	end
	local _maid_2 = p1._maid
	p1._maid = nil
	_maid_2:Destroy()
end
return t