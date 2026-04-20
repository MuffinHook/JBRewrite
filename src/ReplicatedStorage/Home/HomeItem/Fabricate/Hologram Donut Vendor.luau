local module = {}
local _VendingMachine_upvr = require(script.Parent._VendingMachine)
function module.setup(arg1) -- Line 4
    local any_new_result1 = _VendingMachine_upvr.new(arg1, "Donut")
    arg1._maid:GiveTask(any_new_result1)
    arg1._vendingMachine = any_new_result1
end
return module