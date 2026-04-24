-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VendingMachineConsts = require(script.VendingMachineConsts)
local t = {}
t.__index = t
function t.new(p1, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2._obj = p1._obj
	t2._maid = Maid.new()
	local function action(p1, p2)
		if p2 then
			t2._obj:FindFirstChild(VendingMachineConsts.GRAB_REMOTE_NAME):FireServer()
			return true
		end
	end
	local function preUpdateFun(p1)
		p1.Enabled = not HomeItemSystem.isCustomizing()
	end
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(t2._obj, "Prompt", function(p1, p22)
		CircleAction.Add({
			Part = p1,
			Name = ("Grab %s"):format(p2),
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.1
		}, p1)
		p22:GiveTask(function()
			CircleAction.Remove(p1)
		end)
	end))
	return t2
end
function t.Destroy(p1)
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return t
