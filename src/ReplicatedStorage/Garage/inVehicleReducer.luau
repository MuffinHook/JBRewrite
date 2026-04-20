return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setInVehicle = function(arg1, arg2) -- Line 5, Named "setInVehicle"
        local var2
        if arg2.inVehicle == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing inVehicle value")
        return arg2.inVehicle
    end;
})