return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setLocalVehiclePacket = function(arg1, arg2) -- Line 5, Named "setLocalVehiclePacket"
        local var2
        if arg2.packet == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing Packet")
        return arg2.packet
    end;
})