local _VendingMachine = require(script.Parent._VendingMachine)
return {
	setup = function(self)
		local instance = _VendingMachine.new(self, "Energy Drink")
		self._maid:GiveTask(instance)
		self._vendingMachine = instance
	end
}
