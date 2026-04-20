local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    local Responses_upvr = require(script.Parent.Responses)
    function any_extend_result1.render(arg1_3) -- Line 11
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(Responses_upvr, {
            anchorPoint = Vector2.new(0.5, 0.5);
            position = UDim2.fromScale(0.5, 0.5);
            size = UDim2.fromScale(0.8, 1);
            aspectRatio = 2.7;
            verticalPaddingRatio = 64;
            numPlayersPerTeam = 5;
            clanColorOurs = Color3.fromHSV(0.6782, 0.6, 0.8);
            clanNameOurs = "BaBoyz!";
            clanOwnerOurs = 2025110;
            clanMembersOurs = {{
                UserId = 2025110;
                IsAdmin = true;
                RespondedAt = 0;
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
            clanMembersTheirs = {{
                RespondedAt = 0;
                IsAdmin = true;
            }, {
                RespondedAt = 0;
                IsAdmin = true;
            }, {
                RespondedAt = 0;
                IsAdmin = false;
            }};
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 81
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end