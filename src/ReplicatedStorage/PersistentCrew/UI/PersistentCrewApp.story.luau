local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 7
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    persistentCrewStore_upvr:dispatch({
        type = "setGroupVisible";
        value = true;
    })
    persistentCrewStore_upvr:dispatch({
        type = "setRobberiesCompleted";
        value = {{
            robberyType = 1;
            robberyCompleted = false;
        }, {
            robberyType = 2;
            robberyCompleted = true;
        }, {
            robberyType = 3;
            robberyCompleted = true;
        }, {
            robberyType = 8;
            robberyCompleted = false;
        }};
    })
    persistentCrewStore_upvr:dispatch({
        type = "setClanName";
        clanId = "aaa";
        value = "Baboyz";
    })
    persistentCrewStore_upvr:dispatch({
        type = "setClanName";
        clanId = "bbb";
        value = "Goonz";
    })
    persistentCrewStore_upvr:dispatch({
        type = "setViewingClanInfo";
        value = {
            ClanId = "aaa";
            ClanName = "Baboyz";
            DisplayRating = 1500;
            BattlesPlayed = 100;
            BattlesWon = 50;
            AdminIdMap = {};
        };
    })
    persistentCrewStore_upvr:dispatch({
        type = "setAttackingClanId";
        value = "bbb";
    })
    persistentCrewStore_upvr:dispatch({
        type = "setBattleResponseData";
        value = {
            BattleUniqueId = "123";
            NumPlayersPerTeam = 4;
            OurClanInfo = {
                ClanId = "aaa";
                ClanName = "Baboyz";
                FlagColorStr = "#00FF00";
                OwnerUserId = 1;
                RatingData = {
                    LastBattle = 0;
                    Rating = 1500;
                    RatingDeviation = 10;
                    Sigma = 1;
                };
            };
            TheirClanInfo = {
                ClanId = "bbb";
                ClanName = "GoodGoonz";
                FlagColorStr = "#FF0000";
                OwnerUserId = 1;
                RatingData = {
                    LastBattle = 0;
                    Rating = 1500;
                    RatingDeviation = 10;
                    Sigma = 1;
                };
            };
            OurClanAccepted = {{
                UserId = 2025110;
                IsAdmin = true;
            }, {
                UserId = 2837719;
                IsAdmin = false;
            }, {
                UserId = 2829005475;
                IsAdmin = false;
            }, {
                UserId = 820499;
                IsAdmin = true;
            }};
            TheirClanAccepted = {{
                UserId = 147296825;
                IsAdmin = true;
            }, {
                UserId = 1721673063;
                IsAdmin = true;
            }};
        };
    })
    function any_extend_result1.init(arg1_2) -- Line 157
        function arg1_2.attemptLeave() -- Line 162
            persistentCrewStore_upvr:dispatch({
                type = "setViewingClanInfo";
                value = nil;
            })
        end
        function arg1_2.attemptCreate(arg1_3) -- Line 169
            persistentCrewStore_upvr:dispatch({
                type = "setViewingClanInfo";
                value = {
                    ClanName = "Baboyz";
                    DisplayRating = 1500;
                    BattlesPlayed = 100;
                    BattlesWon = 50;
                };
            })
            persistentCrewStore_upvr:dispatch({
                type = "setMembers";
                value = {{
                    displayName = "badcc";
                    isAdmin = true;
                    userId = 2025110;
                }, {
                    displayName = "CritStyx";
                    userId = 12345;
                    showAdmin = true;
                }, {
                    displayName = "asimo3089";
                    showUnAdmin = true;
                    isAdmin = true;
                    userId = 5678;
                }, {
                    displayName = "asimo3089";
                    showKick = true;
                    userId = 692671;
                }, {
                    displayName = "asimo3089";
                }, {
                    displayName = "asimo3089";
                }, {
                    displayName = "asimo3089";
                }, {
                    displayName = "badcc";
                }, {
                    displayName = "CritStyx";
                }, {
                    displayName = "asimo3089";
                }};
            })
            persistentCrewStore_upvr:dispatch({
                type = "setJoinRequests";
                value = {{
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
                }};
            })
        end
        function arg1_2.attemptJoinUserId(arg1_4) -- Line 208
            print("player wants to request to join", arg1_4)
        end
        function arg1_2.attemptBattleUserId(arg1_5) -- Line 211
            print("player wants to battle", arg1_5, "crew")
        end
        function arg1_2.attemptKick(arg1_6) -- Line 214
            print("player wants to kick", arg1_6)
        end
        function arg1_2.attemptAdmin(arg1_7) -- Line 217
            print("player wants to admin", arg1_7)
        end
        function arg1_2.attemptUnAdmin(arg1_8) -- Line 220
            print("player wants to UNadmin", arg1_8)
        end
    end
    local PersistentCrewApp_upvr = require(script.Parent.PersistentCrewApp)
    function any_extend_result1.render(arg1_9) -- Line 225
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(PersistentCrewApp_upvr, {
            attemptLeave = arg1_9.attemptLeave;
            attemptCreate = arg1_9.attemptCreate;
            attemptJoinUserId = arg1_9.attemptJoinUserId;
            attemptBattleUserId = arg1_9.attemptBattleUserId;
            attemptKick = arg1_9.attemptKick;
            attemptAdmin = arg1_9.attemptAdmin;
            attemptUnAdmin = arg1_9.attemptUnAdmin;
            numMembersOnline = 11;
            attemptReportCrew = function(arg1_10, arg2, arg3) -- Line 242, Named "attemptReportCrew"
                print("player wants to report", arg1_10, arg2, arg3)
            end;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 250
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end