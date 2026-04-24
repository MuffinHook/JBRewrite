-- Reviewed by Claude
local _VendingMachine = require(script.Parent._VendingMachine)
return {
	setup = function(p1)
		local v1 = _VendingMachine.new(p1, "Energy Drink")
		p1._maid:GiveTask(v1)
		p1._vendingMachine = v1
	end
}
