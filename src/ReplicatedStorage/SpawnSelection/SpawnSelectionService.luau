local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local module_upvr = {
    _updateRemote = nil;
    _maid = Maid_upvr.new();
}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
function module_upvr.init() -- Line 20
    waitForChild_upvr(ReplicatedStorage_upvr, "SpawnSelectionUpdateSpawnData"):andThen(function(arg1) -- Line 21
        module_upvr._updateRemote = arg1
        arg1.OnClientEvent:Connect(module_upvr._receiveSpawns)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, "SpawnSelectionOffer"):andThen(function(arg1) -- Line 25
        module_upvr._offerRemote = arg1
        arg1.OnClientEvent:Connect(function() -- Line 27
            store_upvr:dispatch({
                type = "setSpawnSelectionOfferVisible";
                visible = true;
            })
        end)
    end)
    store_upvr.changed:connect(function(arg1, arg2) -- Line 35
        if arg1.minimapSpawns ~= arg2.minimapSpawns then
            module_upvr._maid.receiveSpawnsMaid = nil
        end
    end)
end
function module_upvr.requestShowSpawns() -- Line 41
    module_upvr._updateRemote:FireServer()
end
function module_upvr.attemptSelect(arg1) -- Line 44
    ReplicatedStorage_upvr:FindFirstChild("SpawnSelectionSelect"):FireServer(arg1)
end
local ClanUtils_upvr = require(ReplicatedStorage_upvr.Clan.ClanUtils)
local Players_upvr = game:GetService("Players")
local PrivateServerUtils_upvr = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerUtils)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local CharacterUtil_upvr = require(ReplicatedStorage_upvr.Game.CharacterUtil)
local SpawnSelectionConsts_upvr = require(script.Parent.SpawnSelectionConsts)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module_upvr._receiveSpawns(arg1) -- Line 50
    local any_new_result1 = Maid_upvr.new()
    module_upvr._maid.receiveSpawnsMaid = any_new_result1
    local tbl = {}
    for _, v in arg1 do
        local tbl_2_upvr = {
            name = assert(v.name, "missing spawnData.name");
            useParachute = v.useParachute;
            locked = v.locked;
            position = assert(v.position, "missing spawnData.position");
        }
        if PrivateServerUtils_upvr.getIsBattleServer() then
            local any_createBinding_result1, any_createBinding_result2_upvr = Roact_upvr.createBinding(0)
            tbl_2_upvr.numEnemies = any_createBinding_result1
            local any_getCurrentClanId_result1_upvr = ClanUtils_upvr.getCurrentClanId(Players_upvr.LocalPlayer)
            any_new_result1:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 64
                local var45
                for _, v_2 in Players_upvr:GetPlayers() do
                    if ClanUtils_upvr.getCurrentClanId(v_2) ~= any_getCurrentClanId_result1_upvr then
                        local Character_2 = v_2.Character
                        if Character_2 then
                            local any_getPositionFromCharacter_result1 = CharacterUtil_upvr.getPositionFromCharacter(Character_2)
                            if any_getPositionFromCharacter_result1 and SpawnSelectionConsts_upvr.ENEMY_CHECK_RADIUS >= (any_getPositionFromCharacter_result1 - tbl_2_upvr.position).Magnitude then
                                var45 += 1
                            end
                        end
                    end
                end
                any_createBinding_result2_upvr(var45)
            end))
        end
        if v.exclusiveTeamId then
            any_createBinding_result2_upvr = Settings_upvr
            any_createBinding_result2_upvr = any_createBinding_result2_upvr.TeamColor
            tbl_2_upvr.backgroundColor = any_createBinding_result2_upvr[v.exclusiveTeamId]
        else
            any_createBinding_result2_upvr = 1
            tbl_2_upvr.backgroundColor = Color3.new(any_createBinding_result2_upvr, 1, 1)
        end
        any_createBinding_result2_upvr = tbl
        table.insert(any_createBinding_result2_upvr, tbl_2_upvr)
    end
    store_upvr:dispatch({
        type = "minimapSetSpawns";
        spawns = tbl;
    })
    store_upvr:dispatch({
        type = "setSpawnSelectionReceivedAt";
        receivedAt = workspace:GetServerTimeNow();
    })
end
return module_upvr