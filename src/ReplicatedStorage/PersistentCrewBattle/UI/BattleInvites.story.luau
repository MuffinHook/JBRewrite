local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    function any_extend_result1.init(arg1_2) -- Line 9
        persistentCrewStore_upvr:dispatch({
            type = "battleInvitesSet";
            list = {{
                clanName = "CeilingFanCrew";
                battleNumPlayersPerTeam = 5;
                clanRating = 1500;
                opposingClanOwnerName = "badcc";
                ranked = false;
            }, {
                clanName = "BadBoyz";
                battleNumPlayersPerTeam = 4;
                clanRating = 2000;
                opposingClanOwnerName = "badcc";
                ranked = true;
            }};
        })
    end
    local BattleInvites_upvr = require(script.Parent.BattleInvites)
    function any_extend_result1.render(arg1_3) -- Line 30
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(BattleInvites_upvr, {
            onAccept = function(arg1_4) -- Line 35, Named "onAccept"
                print("accept", arg1_4)
            end;
            onDecline = function(arg1_5) -- Line 38, Named "onDecline"
                print("decline", arg1_5)
            end;
        })})
    end
    function any_extend_result1.willUnmount(arg1_6) -- Line 44
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 47
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end