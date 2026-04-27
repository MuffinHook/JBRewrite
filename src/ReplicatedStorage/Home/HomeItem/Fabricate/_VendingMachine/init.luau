local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VendingMachineConsts = require(script.VendingMachineConsts)
local VendingMachine = {}
VendingMachine.__index = VendingMachine
function VendingMachine.new(self, itemName)
	local vendingMachineInstance = {}
	setmetatable(vendingMachineInstance, VendingMachine)
	vendingMachineInstance._obj = self._obj
	vendingMachineInstance._maid = Maid.new()
	local function action(self, isActivated)
		if isActivated then
			vendingMachineInstance._obj:FindFirstChild(VendingMachineConsts.GRAB_REMOTE_NAME):FireServer()
			return true
		end
	end
	local function preUpdateFun(self)
		self.Enabled = not HomeItemSystem.isCustomizing()
	end
	vendingMachineInstance._maid:GiveTask(RxInstanceUtils.observeOneChildNamed(vendingMachineInstance._obj, "Prompt", function(self, promptMaid)
		CircleAction.Add({
			Part = self,
			Name = ("Grab %s"):format(itemName),
			Timed = false,
			Dist = 10,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.1
		}, self)
		promptMaid:GiveTask(function()
			CircleAction.Remove(self)
		end)
	end))
	return vendingMachineInstance
end
function VendingMachine.Destroy(self)
	local _maid = self._maid
	assert(_maid ~= nil)
	self._maid = nil
	_maid:Destroy()
end
return VendingMachine
