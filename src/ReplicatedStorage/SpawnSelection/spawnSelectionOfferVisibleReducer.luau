return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setSpawnSelectionOfferVisible = function(arg1, arg2) -- Line 5, Named "setSpawnSelectionOfferVisible"
        return arg2.visible
    end;
})