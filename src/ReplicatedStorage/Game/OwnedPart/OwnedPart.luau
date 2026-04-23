local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local OwnedPartConsts = require(script.Parent.OwnedPartConsts)
local t = {}
t.__index = t
t.__ClassName = "OwnedPart"
function t.new(p1) --[[ Line: 12 | Upvalues: t (copy), Maid (copy), OwnedPartConsts (copy), Signal (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	t2._networkOwnerIdValue = p1:WaitForChild(OwnedPartConsts.NETWORK_OWNER_ID_VALUE_NAME)
	t2._maid:GiveTask(t2._networkOwnerIdValue.Changed:Connect(function() --[[ Line: 19 | Upvalues: t2 (copy) ]]
		t2:_onOwnerChanged()
	end))
	t2._onOwned = Signal.new()
	return t2
end
function t.GetOnOwnedSignal(p1) --[[ Line: 26 | Upvalues: Signal (copy) ]]
	local _onOwned = p1._onOwned
	if not _onOwned then
		local v1 = Signal.new()
		p1._onOwned = v1
		_onOwned = v1
	end
	return _onOwned
end
function t._onOwnerChanged(p1) --[[ Line: 34 | Upvalues: LocalPlayer (copy), Maid (copy) ]]
	if p1:GetOwner() == LocalPlayer then
		p1._maid.ownerMaid = Maid.new()
		if p1._onOwned then
			p1._onOwned:Fire(p1._maid.ownerMaid)
		end
	else
		p1._maid.ownerMaid = nil
	end
end
function t.GetOwner(p1) --[[ Line: 45 | Upvalues: Players (copy) ]]
	return Players:GetPlayerByUserId(p1._networkOwnerIdValue.Value)
end
function t.Destroy(p1) --[[ Line: 50 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
end
return t