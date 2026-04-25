-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local OwnedPartConsts = require(script.Parent.OwnedPartConsts)
local t = {}
t.__index = t
t.__ClassName = "OwnedPart"
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = self
	t2._networkOwnerIdValue = self:WaitForChild(OwnedPartConsts.NETWORK_OWNER_ID_VALUE_NAME)
	t2._maid:GiveTask(t2._networkOwnerIdValue.Changed:Connect(function()
		t2:_onOwnerChanged()
	end))
	t2._onOwned = Signal.new()
	return t2
end
function t.GetOnOwnedSignal(self)
	local _onOwned = self._onOwned
	if not _onOwned then
		local onOwnedSignal = Signal.new()
		self._onOwned = onOwnedSignal
		_onOwned = onOwnedSignal
	end
	return _onOwned
end
function t._onOwnerChanged(self)
	if self:GetOwner() == LocalPlayer then
		self._maid.ownerMaid = Maid.new()
		if self._onOwned then
			self._onOwned:Fire(self._maid.ownerMaid)
		end
	else
		self._maid.ownerMaid = nil
	end
end
function t.GetOwner(self)
	return Players:GetPlayerByUserId(self._networkOwnerIdValue.Value)
end
function t.Destroy(self)
	local _maid = self._maid
	self._maid = nil
	_maid:Destroy()
end
return t
