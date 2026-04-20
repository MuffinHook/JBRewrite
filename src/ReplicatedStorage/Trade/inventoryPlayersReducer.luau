local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_2 = {
    setInventoryPlayers = function(arg1, arg2) -- Line 7, Named "setInventoryPlayers"
        local var4
        if arg2.allPlayers == nil then
            var4 = false
        else
            var4 = true
        end
        assert(var4, "missing allPlayers")
        local module_3 = {}
        var4 = arg1.selectedPlayer
        module_3.selectedPlayer = var4
        var4 = arg2.allPlayers
        module_3.allPlayers = var4
        return module_3
    end;
}
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
function module_2.setInventoryPlayer(arg1, arg2) -- Line 12
    local var7
    if arg2.selectedPlayer == nil then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "missing selectedPlayer")
    local module = {}
    var7 = arg1.allPlayers
    module.allPlayers = var7
    var7 = arg2.selectedPlayer
    module.selectedPlayer = var7
    var7 = ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.UPDATE_INVENTORY_PLAYER_REMOTE_NAME)
    var7:FireServer(arg2.selectedPlayer, true)
    return module
end
return require(ReplicatedStorage_upvr.Rodux).createReducer({
    selectedPlayer = game:GetService("Players").LocalPlayer;
    allPlayers = {};
}, module_2)