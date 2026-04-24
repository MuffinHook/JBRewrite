-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VendingMachineConsts = require(script.VendingMachineConsts)
local t = {}
t.__index = t
function t.new(self, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2._obj = self._obj
	t2._maid = Maid.new()
	local function action(self, p2)
		if p2 then
			t2._obj:FindFirstChild(VendingMachineConsts.GRAB_REMOTE_NAME):FireServer()
			return true
		end
	end
	local function preUpdateFun(self)
		self.Enabled = not HomeItemSystem.isCustomizing()
	end
	t2._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(t2._obj, "Prompt", function(self, p22)
		CircleAction.Add({
			Part = self,
			Name = ("Grab %s"):format(p2),
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.1
		}, self)
		p22:GiveTask(function()
			CircleAction.Remove(self)
		end)
	end))
	return t2
end
function t.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return t
