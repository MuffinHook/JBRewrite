local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
        arg1_2.members = {{
            id = 2025110;
            userId = 2025110;
            displayName = "badcc";
            isAdmin = true;
            showKick = true;
            showAdmin = true;
            showUnAdmin = true;
            battlesPlayed = 1;
            battlesWon = 1;
        }}
        function arg1_2.attemptBattleClanId(arg1_3) -- Line 23
            print("player wants to clan", arg1_3)
        end
        function arg1_2.attemptViewUserIdClan(arg1_4) -- Line 26
            print("player wants to view clan of user", arg1_4)
        end
        function arg1_2.onClickAdmin(arg1_5) -- Line 29
            print("wants to admin", arg1_5)
        end
        function arg1_2.onClickUnAdmin(arg1_6) -- Line 32
            print("wants to UNadmin", arg1_6)
        end
        function arg1_2.onClickKick(arg1_7) -- Line 35
            print("wants to kick", arg1_7)
        end
        function arg1_2.onClickToggleRequests(arg1_8) -- Line 38
            print("toggle requests")
        end
        function arg1_2.onClickRenameCrew(arg1_9) -- Line 41
            print("wants to rename", arg1_9)
        end
        arg1_2.isReadiedUp = false
        arg1_2.joinRequests = {{
            displayName = "badcc";
            showRequestAccept = true;
            showRequestDeny = true;
        }, {
            displayName = "CritStyx";
            showRequestAccept = true;
            showRequestDeny = true;
        }, {
            displayName = "asimo3089";
            showRequestAccept = true;
            showRequestDeny = true;
        }}
    end
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    local Info_upvr = require(script.Parent.Info)
    function any_extend_result1.render(arg1_10) -- Line 54
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(Info_upvr, {
            aspectRatio = 1.7777777777777777;
            verticalPaddingRatio = 128;
            attemptLeave = arg1_10.props.attemptLeave;
            playersClanId = nil;
            isPlayersClan = false;
            isAdminOfViewingClan = true;
            isAdminOfCurrentClan = true;
            clanName = "Baboyz";
            clanDisplayRating = "1500";
            leaderboardRank = 10;
            battlesPlayed = 425;
            battlesWLRatio = 2.13;
            numMembersOnline = 10;
            members = arg1_10.members;
            joinRequests = arg1_10.joinRequests;
            isReadiedUp = arg1_10.isReadiedUp;
            attemptBattleUserId = arg1_10.attemptBattleUserId;
            attemptViewUserIdClan = arg1_10.attemptViewUserIdClan;
            onClickAdmin = arg1_10.onClickAdmin;
            onClickUnAdmin = arg1_10.onClickUnAdmin;
            onClickKick = arg1_10.onClickKick;
            onClickToggleRequests = arg1_10.onClickToggleRequests;
            onClickRenameCrew = arg1_10.onClickRenameCrew;
            playerDisplayRating = "1600";
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 89
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end