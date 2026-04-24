-- Reviewed by Claude
local _VendingMachine = require(script.Parent._VendingMachine)
return {
	setup = function(self)
		local instance = _VendingMachine.new(self, "Donut")
		self._maid:GiveTask(instance)
		self._vendingMachine = instance
	end
}
