local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("CrewLeaderboard")
any_extend_result1.defaultProps = {
    verticalPaddingRatio = 96;
    aspectRatio = 1.7777777777777777;
}
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local createElement_upvr = Roact.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local paddedScrollingGrid_upvr = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local ClanRating_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.ClanRating)
function any_extend_result1.render(arg1) -- Line 15
    assert(arg1.props.displayType, "No display type set")
    local module = {}
    local var15
    local var16
    if arg1.props.displayType == PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
        var15 = "CREW BATTLES LEADERBOARD"
        var16 = 7.5
    elseif arg1.props.displayType == PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
        var16 = 7.5
        var15 = "CREWS IN SERVER"
        assert(arg1.props.attemptViewClanId, "No attemptViewClanId function set")
        for i, v in arg1.props.leaderboardInfo do
            v.attemptViewClanId = arg1.props.attemptViewClanId
            v.showCrewView = true
            local _
        end
    else
        v = arg1.props
        v = v.displayType
        i = tostring(v)
        error("Invalid display type: "..i)
    end
    module.Header = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.fromRGB(57, 58, 65);
        backgroundTransparency = 0;
        size = UDim2.new(1, 0, 0.1111111111111111, 0);
        paddingTop = 0;
        paddingBottom = 0.5;
        paddingLeft = 0;
        paddingRight = 0;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        TitleContainer = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            size = UDim2.new(0.7, 0, 1, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Font = Enum.Font.FredokaOne;
                TextXAlignment = Enum.TextXAlignment.Left;
                Text = var15;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.fromRGB(255, 169, 0);
            });
        });
    })
    module.Body = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0, 0, 0.1111111111111111, 0);
        size = UDim2.new(1, 0, 0.8888888888888888, 0);
        paddingTop = 0.5;
        paddingBottom = 0;
        paddingLeft = 0;
        paddingRight = 0;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Scrolling = createElement_upvr(paddedScrollingGrid_upvr, {
            exposePaddedContainerProps = true;
            rowsPerPage = var16;
            colsPerRow = 1;
            component = ClanRating_upvr;
            items = arg1.props.leaderboardInfo;
        });
    })
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        backgroundColor = Color3.new(1, 1, 1);
        aspectRatio = arg1.props.aspectRatio;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
    }, module)
end
return any_extend_result1