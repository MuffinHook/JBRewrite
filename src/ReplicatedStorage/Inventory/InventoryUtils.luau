return {
    doesInventoryValueHave = function(arg1, arg2) -- Line 2, Named "doesInventoryValueHave"
        assert(arg1, "missing inventoryValue")
        local assert = assert
        assert(arg2, "missing itemName")
        if arg1:FindFirstChild(arg2) == nil then
            assert = false
        else
            assert = true
        end
        return assert
    end;
    getInventoryItemValue = function(arg1, arg2) -- Line 8, Named "getInventoryItemValue"
        assert(arg1, "missing inventoryValue")
        assert(arg2, "missing itemName")
        return arg1:FindFirstChild(arg2)
    end;
}