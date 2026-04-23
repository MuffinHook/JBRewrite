local _VendingMachine = require(script.Parent._VendingMachine)
return {
	setup = function(p1) --[[ Name: setup | Line: 4 | Upvalues: _VendingMachine (copy) ]]
		local v1 = _VendingMachine.new(p1, "Donut")
		p1._maid:GiveTask(v1)
		p1._vendingMachine = v1
	end
}