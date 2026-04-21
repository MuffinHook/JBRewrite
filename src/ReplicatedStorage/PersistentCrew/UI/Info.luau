local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Info")
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
function any_extend_result1.init(arg1) -- Line 18
    arg1:setState({
        searchText = "";
        isRenamingClan = false;
    })
    function arg1.onClickLeave() -- Line 23
        arg1.props.attemptLeave()
    end
    function arg1.playerSearchTextBoxTextChanged(arg1_2) -- Line 27
        arg1:setState({
            searchText = arg1_2.Text;
        })
    end
    function arg1.crewSearchTextBoxFocusLost(arg1_3, arg2) -- Line 33
        if arg2 then
            arg1.onClickViewClan()
        end
    end
    arg1.crewSearchTextBoxRef = Roact_upvr.createRef()
    function arg1.onClickViewClan() -- Line 40
        local any_getValue_result1_2 = arg1.crewSearchTextBoxRef:getValue()
        local Text_2 = any_getValue_result1_2.Text
        if Text_2 == "" then
        else
            any_getValue_result1_2.Text = ""
            local any_GetUserIdFromNameAsync_result1 = Players_upvr:GetUserIdFromNameAsync(Text_2)
            if not any_GetUserIdFromNameAsync_result1 then return end
            arg1.props.attemptViewUserIdClan(any_GetUserIdFromNameAsync_result1)
        end
    end
    arg1.crewRenameTextBoxRef = Roact_upvr.createRef()
    function arg1.renameCrewTextFocusLost() -- Line 55
        local any_getValue_result1 = arg1.crewRenameTextBoxRef:getValue()
        if not any_getValue_result1 then
        else
            local Text = any_getValue_result1.Text
            if Text == "" then return end
            any_getValue_result1.Text = ""
            arg1:setState({
                isEditingClanName = false;
            })
            arg1.props.onClickRenameCrew(Text)
        end
    end
    function arg1.onClickBattle(arg1_4) -- Line 71
        local var20
        if typeof(arg1_4) ~= "number" then
            var20 = false
        else
            var20 = true
        end
        assert(var20, "count must be a number")
        return function() -- Line 73
            if arg1.props.isReadiedUp then
                Notification_upvr.new({
                    Text = "Cannot start unranked battle while in ranked matchamking!";
                })
            end
            arg1.props.attemptBattleClanId(arg1.props.clanId, arg1_4)
        end
    end
    arg1:_buildMembers()
    function arg1.uncurryPropsIndex(arg1_5, arg2) -- Line 86
        return function(arg1_6) -- Line 87
            return arg1_5(arg1.lastMembers[arg2])
        end
    end
end
any_extend_result1.defaultProps = {
    flagColor = Color3.new(1, 0, 0);
}
function any_extend_result1._buildMembers(arg1) -- Line 95
    local tbl_126 = {}
    local searchText = arg1.state.searchText
    local var32
    if arg1.props.showRequests then
        var32 = arg1.props.joinRequests
    else
        var32 = arg1.props.members
    end
    if var32 then
        for _, v in var32 do
            local var33
            if 0 < #searchText and not string.find(string.lower(v.displayName), string.lower(searchText)) then
                var33 = false
            end
            if var33 then
                if arg1.props.membersOnlineMap then
                    v.isOnline = arg1.props.membersOnlineMap[tostring(v.userId)]
                end
                table.insert(tbl_126, v)
            end
        end
    end
    if not arg1.props.showRequests then
        table.sort(tbl_126, function(arg1_7, arg2) -- Line 121
            local var35
            if arg1_7.isOnline ~= arg2.isOnline then
                return arg1_7.isOnline
            end
            if arg1_7.isAdmin ~= arg2.isAdmin then
                return arg1_7.isAdmin
            end
            local var36 = arg1_7.battlesWon / (arg1_7.battlesPlayed - arg1_7.battlesWon)
            var35 = arg2.battlesPlayed
            local var37 = var35 / (arg2.battlesPlayed - arg2.battlesWon)
            if var36 ~= var37 then
                if var37 >= var36 then
                    var35 = false
                else
                    var35 = true
                end
                return var35
            end
            if arg1_7.displayName >= arg2.displayName then
                var35 = false
            else
                var35 = true
            end
            return var35
        end)
    end
    arg1.lastMembers = tbl_126
end
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local TextButton_upvr = require(script.Parent.TextButton)
local Flag_upvr = require(script.Parent.Flag)
local PersistentCrewBattleUtils_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local paddedScrollingGrid_upvr = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local Member_upvr = require(script.Parent.Member)
function any_extend_result1.render(arg1) -- Line 140
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local module_3 = {}
    arg1:_buildMembers()
    local var211
    if var211 then
        var211 = arg1.props
        var211 = var211.isPlayersClan
        if var211 then
            var211 = false
            if arg1.props.playersClanId ~= nil then
                var211 = not arg1.props.playerHasAcceptedInvite
            end
        end
    end
    local var212
    if arg1.props.isAdminOfCurrentClan and not arg1.props.isPlayersClan and arg1.props.playersClanId ~= nil then
        local var213 = not arg1.props.playerHasAcceptedInvite
    end
    local tbl_2 = {1, 2, 3, 4, 5}
    for i_2, v_2 in tbl_2 do
        local tbl_55 = {}
        var212 = 1
        tbl_55.backgroundTransparency = var212
        var212 = UDim2.fromScale(1 / #tbl_2, 1)
        tbl_55.size = var212
        var212 = UDim2.fromScale((i_2 - 1) / #tbl_2, 0)
        tbl_55.position = var212
        if 1 < i_2 then
            var212 = 0.5
        else
            var212 = 0
        end
        tbl_55.paddingLeft = var212
        if i_2 < #tbl_2 then
            var212 = 0.5
        else
            var212 = 0
        end
        tbl_55.paddingRight = var212
        var212 = 0
        tbl_55.paddingTop = var212
        var212 = 0
        tbl_55.paddingBottom = var212
        var212 = {}
        var212.Button = createElement_upvr(TextButton_upvr, {
            size = UDim2.new(1, 0, 1, 0);
            text = string.format("%dv%d", v_2, v_2);
            backgroundColor = Color3.fromRGB(88, 172, 246);
            onClick = arg1.onClickBattle(v_2);
            disabled = arg1.props.networkMutexLocked;
        })
        ;({})[i_2] = createElement_upvr(PaddedContainer_upvr, tbl_55, var212)
    end
    local var218 = 0.3055555555555556 * arg1.props.aspectRatio / 1.5
    local LocalPlayer_2 = Players_upvr.LocalPlayer
    if LocalPlayer_2 then
        LocalPlayer_2 = false
        if Players_upvr.LocalPlayer.UserId == arg1.props.clanOwnerUserId then
            LocalPlayer_2 = not arg1.state.isEditingClanName
        end
    end
    local LocalPlayer = Players_upvr.LocalPlayer
    if LocalPlayer then
        LocalPlayer = false
        if Players_upvr.LocalPlayer.UserId == arg1.props.clanOwnerUserId then
            LocalPlayer = arg1.state
            LocalPlayer = LocalPlayer.isEditingClanName
        end
    end
    local var221 = LocalPlayer_2 or LocalPlayer
    ;({}).UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, 4);
    })
    local tbl_98 = {}
    local tbl_94 = {}
    local var228 = LocalPlayer_2
    if var228 then
        var228 = createElement_upvr
        local tbl_101 = {
            size = UDim2.new(1, 0, 1, 0);
            text = "RENAME";
            backgroundColor = Color3.fromRGB(88, 172, 246);
        }
        local function onClick() -- Line 230
            arg1:setState({
                isEditingClanName = true;
            })
        end
        tbl_101.onClick = onClick
        tbl_101.disabled = arg1.props.networkMutexLocked
        var228 = var228(TextButton_upvr, tbl_101)
    end
    tbl_94.RenameButton = var228
    var228 = LocalPlayer
    local var231 = var228
    if var231 then
        var231 = createElement_upvr
        local tbl_92 = {
            size = UDim2.new(1, 0, 1, 0);
            text = "CANCEL";
            backgroundColor = Color3.fromRGB(88, 172, 246);
        }
        local function onClick() -- Line 239
            arg1:setState({
                isEditingClanName = false;
            })
        end
        tbl_92.onClick = onClick
        tbl_92.disabled = arg1.props.networkMutexLocked
        var231 = var231(TextButton_upvr, tbl_92)
    end
    tbl_94.CancelButton = var231
    tbl_98.ButtonContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(0.1, 0, 1, 0);
        paddingRight = 0.5;
        paddingTop = 0;
        paddingBottom = 0;
        paddingLeft = 0;
    }, tbl_94)
    local var234 = LocalPlayer
    if var234 then
        var234 = createElement_upvr
        var234 = var234(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            size = UDim2.new(0.9, 0, 1, 0);
            position = UDim2.new(0.1, 0, 0, 0);
            paddingRight = 0;
            paddingTop = 0;
            paddingBottom = 0;
            paddingLeft = 0.5;
        }, {
            RenameTextInput = createElement_upvr("TextBox", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 1);
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 1, 0);
                PlaceholderText = "RENAME CREW...";
                TextColor3 = Color3.new(1, 1, 1);
                TextXAlignment = Enum.TextXAlignment.Left;
                Text = "";
                Font = Enum.Font.Bangers;
                TextScaled = true;
                [Roact_upvr.Ref] = arg1.crewRenameTextBoxRef;
                [Roact_upvr.Event.FocusLost] = arg1.renameCrewTextFocusLost;
            });
        })
    end
    tbl_98.RenameNameContainer = var234
    local var238
    if not LocalPlayer then
        local tbl_86 = {}
        var238 = 1
        tbl_86.backgroundTransparency = var238
        if var221 then
            var238 = UDim2.fromScale(0.9, 1)
        else
            var238 = UDim2.fromScale(1, 1)
        end
        tbl_86.size = var238
        if var221 then
        else
        end
        tbl_86.position = UDim2.fromScale(0, 0)
        tbl_86.paddingRight = 0
        tbl_86.paddingTop = 0
        tbl_86.paddingBottom = 0
        if var221 then
        else
        end
        tbl_86.paddingLeft = 0
        ;({}).ClanName = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(1, 1);
            Font = Enum.Font.Bangers;
            TextXAlignment = Enum.TextXAlignment.Left;
            Text = arg1.props.clanName;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
        })
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    end
    tbl_98.NameContainer = createElement_upvr(PaddedContainer_upvr, tbl_86, {})
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    ;({}).TitleContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 1, 0);
    }, tbl_98)
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    ;({}).PlayerRatingContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(0.3, 0.8);
        position = UDim2.fromScale(0.7, 0.1);
        paddingRight = 0;
        paddingTop = 0;
        paddingBottom = 0;
        paddingLeft = 0;
    }, {
        PaddedClanName = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            size = UDim2.fromScale(1, 1);
            paddingRight = 1;
            paddingTop = 0;
            paddingBottom = 0;
            paddingLeft = 1;
        }, {
            ClanName = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.fromScale(1, 1);
                Font = Enum.Font.Bangers;
                TextXAlignment = Enum.TextXAlignment.Left;
                Text = "Personal Rating: "..(arg1.props.playerDisplayRating or "N/A");
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
        UIStroke = createElement_upvr("UIStroke", {
            Color = Color3.new(1, 1, 1);
            Thickness = 1;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    })
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    module_3.Header = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        size = UDim2.new(1, 0, 0.09090909090909091, 0);
        paddingLeft = 0;
        paddingRight = 0;
        paddingTop = 0;
        paddingBottom = 0.5;
    }, {})
    ;({}).UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, 4);
    })
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    ;({}).Flag = createElement_upvr(Flag_upvr, {
        flagColor = arg1.props.flagColor;
        userId = arg1.props.clanOwnerUserId;
    })
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    module_3.Flag = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0, 0, 0.09090909090909091, 0);
        size = UDim2.new(0.25, 0, 0.8181818181818181 * var218, 0);
        paddingLeft = 0;
        paddingRight = 0.5;
        paddingTop = 0.5;
        paddingBottom = 0.5;
    }, {})
    local any_calculateWLRatio_result1 = PersistentCrewBattleUtils_upvr.calculateWLRatio(arg1.props.battlesWon, arg1.props.battlesPlayed)
    local var252 = 0
    if arg1.props.membersOnlineMap then
        for _, _ in arg1.props.membersOnlineMap do
            var252 += 1
        end
    end
    local var253 = false
    if string.find(arg1.props.clanDisplayRating, '?') ~= nil then
        var253 = arg1.props
        var253 = var253.isPlayersClan
    end
    if var253 then
    else
    end
    if var253 then
        local const_number = 0.02
    else
    end
    if arg1.props.leaderboardRank then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    local tbl_17 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Rating = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            size = UDim2.new(1, 0, 0.15, 0);
            paddingTop = 0;
            paddingBottom = 0;
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Font = Enum.Font.FredokaOne;
                TextXAlignment = Enum.TextXAlignment.Center;
                Text = string.format("RATING: %s", arg1.props.clanDisplayRating);
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
    }
    if var253 then
    end
    tbl_17.ProvisionalRatingExplanation = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.09, 0);
        position = UDim2.new(0, 0, 0.08, 0);
        paddingTop = 0;
        paddingBottom = 0;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Font = Enum.Font.FredokaOne;
            TextXAlignment = Enum.TextXAlignment.Center;
            Text = string.format("Leaderboard unlocks at %d battles", PersistentCrewBattleConsts_upvr.NUM_PROVISIONAL_RATING_BATTLES);
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
        });
    })
    local tbl_29 = {}
    local tbl_113 = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Font = Enum.Font.FredokaOne;
    }
    local Center_2 = Enum.TextXAlignment.Center
    tbl_113.TextXAlignment = Center_2
    if var252 then
        Center_2 = string.format("%d online", var252)
    else
        Center_2 = "... online"
    end
    tbl_113.Text = Center_2
    tbl_113.LineHeight = 1
    tbl_113.TextScaled = true
    tbl_113.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    tbl_29.Text = createElement_upvr("TextLabel", tbl_113)
    tbl_17.Online = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.125, 0);
        position = UDim2.new(0, 0, 0 + 0.15, 0);
        paddingTop = 0;
        paddingBottom = 0;
    }, tbl_29)
    local tbl_24 = {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.125, 0);
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_24.position = UDim2.new(0, 0, 0 + 0.275, 0)
    tbl_24.paddingTop = 0
    tbl_24.paddingBottom = 0
    tbl_17.Won = createElement_upvr(PaddedContainer_upvr, tbl_24, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Font = Enum.Font.FredokaOne;
            TextXAlignment = Enum.TextXAlignment.Center;
            Text = string.format("%d battles", arg1.props.battlesPlayed or 0);
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(0.7, 0.7, 0.7);
        });
    })
    local tbl_83 = {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.125, 0);
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_83.position = UDim2.new(0, 0, 0 + 0.4, 0)
    tbl_83.paddingTop = 0
    tbl_83.paddingBottom = 0
    local tbl_51 = {}
    local tbl_97 = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Font = Enum.Font.FredokaOne;
        TextXAlignment = Enum.TextXAlignment.Center;
    }
    if not any_calculateWLRatio_result1 or not "W/L: "..any_calculateWLRatio_result1 then
    end
    tbl_97.Text = "W/L: ..."
    tbl_97.LineHeight = 1
    tbl_97.TextScaled = true
    tbl_97.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    tbl_51.Text = createElement_upvr("TextLabel", tbl_97)
    tbl_17.WLRatio = createElement_upvr(PaddedContainer_upvr, tbl_83, tbl_51)
    if var211 then
    end
    tbl_17.RankedBattleTitleContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.1, 0);
        position = UDim2.new(0, 0, 0.6, 0);
        paddingTop = 0;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Font = Enum.Font.FredokaOne;
            Text = string.format("BATTLE (RANKED, %dv%d)", PersistentCrewBattleConsts_upvr.RANKED_BATTLE_TEAM_SIZE, PersistentCrewBattleConsts_upvr.RANKED_BATTLE_TEAM_SIZE);
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
        });
    })
    local var277
    if var211 then
        local tbl_12 = {
            backgroundTransparency = 1;
        }
        var277 = 0
        tbl_12.size = UDim2.new(1, 0, 0.15, var277)
        tbl_12.position = UDim2.fromScale(0, 0.7)
        tbl_12.paddingTop = 0
        local tbl_37 = {}
        local tbl_78 = {}
        var277 = UDim2.new(1, 0, 1, 0)
        tbl_78.size = var277
        var277 = UDim2.new(1, 0, 0, 0)
        tbl_78.position = var277
        var277 = Vector2.new(1, 0)
        tbl_78.anchorPoint = var277
        if arg1.props.isReadiedUp then
            var277 = "LEAVE MATCHMAKING"
        else
            var277 = "ENTER MATCHMAKING"
        end
        tbl_78.text = var277
        tbl_78.backgroundColor = Color3.fromRGB(88, 172, 246)
        if not arg1.props.isReadiedUp or not arg1.props.onClickUnreadyUp then
        end
        tbl_78.onClick = arg1.props.onClickReadyUp
        tbl_78.disabled = arg1.props.networkMutexLocked
        tbl_37.Button = createElement_upvr(TextButton_upvr, tbl_78)
    end
    tbl_17.ReadyUpContainer = createElement_upvr(PaddedContainer_upvr, tbl_12, tbl_37)
    if arg1.props.isPlayersClan then
    end
    tbl_17.Leave = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(1, 0.15);
        position = UDim2.fromScale(0, 0.85);
        paddingTop = 0;
    }, {
        Button = createElement_upvr(TextButton_upvr, {
            size = UDim2.new(1, 0, 1, 0);
            text = "LEAVE CREW";
            backgroundColor = Color3.fromRGB(233, 76, 64);
            onClick = arg1.onClickLeave;
            disabled = arg1.props.networkMutexLocked;
        });
    })
    if arg1.props.playersClanId == nil then
    end
    tbl_17.JoinContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.15, 0);
        position = UDim2.fromScale(0, 0.85);
        paddingTop = 0;
    }, {
        Button = createElement_upvr(TextButton_upvr, {
            size = UDim2.new(1, 0, 1, 0);
            position = UDim2.new(1, 0, 0, 0);
            anchorPoint = Vector2.new(1, 0);
            text = "REQUEST JOIN CREW";
            backgroundColor = Color3.fromRGB(88, 172, 246);
            onClick = function() -- Line 542, Named "onClick"
                arg1.props.attemptRequestJoinUserId(arg1.props.clanOwnerUserId)
            end;
            disabled = arg1.props.networkMutexLocked;
        });
    })
    if var213 then
    end
    tbl_17.UnrankedBattleTitleContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.new(1, 0, 0.15, 0);
        position = UDim2.new(0, 0, 0.7, 0);
        paddingTop = 0;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Font = Enum.Font.FredokaOne;
            Text = "BATTLE (UNRANKED)";
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
        });
    })
    if var213 then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    end
    tbl_17.Battle = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(1, 0.15);
        position = UDim2.fromScale(0, 0.85);
        paddingTop = 0;
    }, {})
    module_3.Body1Bottom = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0, 0, 0.8181818181818181 * var218 + 0.09090909090909091, 0);
        size = UDim2.new(0.25, 0, 0.8181818181818181 * (1 - var218), 0);
        paddingLeft = 0;
        paddingRight = 0.5;
        paddingTop = 0.5;
        paddingBottom = 0.5;
    }, tbl_17)
    local isAdminOfViewingClan_2 = arg1.props.isAdminOfViewingClan
    local tbl_74 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    }
    local tbl_73 = {}
    local var296 = 1
    tbl_73.backgroundTransparency = var296
    if isAdminOfViewingClan_2 then
        var296 = UDim2.fromScale(0.5, 1)
    else
        var296 = UDim2.fromScale(1, 1)
    end
    tbl_73.size = var296
    if isAdminOfViewingClan_2 then
    else
    end
    tbl_73.paddingRight = 1
    tbl_74.Left = createElement_upvr(PaddedContainer_upvr, tbl_73, {
        Button = createElement_upvr(TextButton_upvr, {
            size = UDim2.new(1, 0, 1, 0);
            position = UDim2.new(1, 0, 0, 0);
            anchorPoint = Vector2.new(1, 0);
            text = string.format("MEMBERS (%d)", #arg1.props.members);
            backgroundColor = Color3.fromRGB(88, 172, 246);
            disabled = not arg1.props.showRequests;
            onClick = arg1.props.onClickToggleRequests;
        });
    })
    local var299 = isAdminOfViewingClan_2
    if var299 then
        var299 = createElement_upvr
        var299 = var299(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            position = UDim2.new(0.5, 0, 0, 0);
            size = UDim2.new(0.5, 0, 1, 0);
            paddingLeft = 0.5;
        }, {
            Button = createElement_upvr(TextButton_upvr, {
                size = UDim2.new(1, 0, 1, 0);
                position = UDim2.new(1, 0, 0, 0);
                anchorPoint = Vector2.new(1, 0);
                text = string.format("REQUESTS (%d)", #arg1.props.joinRequests);
                backgroundColor = Color3.fromRGB(88, 172, 246);
                disabled = arg1.props.showRequests;
                onClick = arg1.props.onClickToggleRequests;
            });
        })
    end
    tbl_74.Right = var299
    module_3.Body2TopLeft = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0.25, 0, 0.09090909090909091, 0);
        size = UDim2.new(0.375, 0, 0.1, 0);
        paddingLeft = 0.5;
        paddingRight = 0.5;
        paddingTop = 0.5;
        paddingBottom = 0.5;
    }, tbl_74)
    module_3.Search = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0.625, 0, 0.09090909090909091, 0);
        size = UDim2.new(0.375, 0, 0.1, 0);
        paddingLeft = 0.5;
        paddingRight = 0;
        paddingTop = 0.5;
        paddingBottom = 0.5;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Container = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
        }, {
            UsernameContainer = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.new(1, 1, 1);
                Size = UDim2.new(1, 0, 1, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.5, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Input = createElement_upvr("TextBox", {
                    BackgroundTransparency = 1;
                    BackgroundColor3 = Color3.new(1, 0, 1);
                    BorderSizePixel = 0;
                    Size = UDim2.new(0.8, 0, 1, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    PlaceholderText = "Find a member...";
                    TextColor3 = Color3.new(0, 0, 0);
                    Text = "";
                    Font = Enum.Font.Bangers;
                    TextScaled = true;
                    [Roact_upvr.Change.Text] = arg1.playerSearchTextBoxTextChanged;
                });
            });
        });
    })
    module_3.Body2Bottom = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0.25, 0, 0.19090909090909092, 0);
        size = UDim2.new(0.75, 0, 0.7181818181818181, 0);
        paddingLeft = 0.5;
        paddingRight = 0;
        paddingTop = 0.5;
        paddingBottom = 0.5;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Scrolling = createElement_upvr(paddedScrollingGrid_upvr, {
            exposePaddedContainerProps = true;
            rowsPerPage = 7.5;
            colsPerRow = 1;
            component = Member_upvr;
            items = arg1.lastMembers;
            itemDefaults = {
                networkMutexLocked = arg1.props.networkMutexLocked;
                showRequests = arg1.props.showRequests;
                uncurryPropsIndex = arg1.uncurryPropsIndex;
                onClickAdmin = arg1.props.onClickAdmin;
                onClickUnAdmin = arg1.props.onClickUnAdmin;
                onClickKick = arg1.props.onClickKick;
                onClickJoinRequestAccept = arg1.props.onClickJoinRequestAccept;
                onClickJoinRequestDeny = arg1.props.onClickJoinRequestDeny;
            };
        });
    })
    local tbl_59 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Left = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(1, 1);
        }, {
            UIListLayout = createElement_upvr("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SortOrder = Enum.SortOrder.LayoutOrder;
            });
            SearchContainer = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.3333333333333333, 0, 1, 0);
                LayoutOrder = 10;
            }, {
                Search = createElement_upvr(PaddedContainer_upvr, {}, {
                    UsernameContainer = createElement_upvr("Frame", {
                        BorderSizePixel = 0;
                        BackgroundColor3 = Color3.new(1, 1, 1);
                        Size = UDim2.new(1, 0, 1, 0);
                        AnchorPoint = Vector2.new(0.5, 0.5);
                        Position = UDim2.new(0.5, 0, 0.5, 0);
                    }, {
                        UICorner = createElement_upvr("UICorner", {
                            CornerRadius = UDim.new(0, 4);
                        });
                        Input = createElement_upvr("TextBox", {
                            BackgroundTransparency = 1;
                            BackgroundColor3 = Color3.new(1, 0, 1);
                            BorderSizePixel = 0;
                            Size = UDim2.new(0.9, 0, 1, 0);
                            AnchorPoint = Vector2.new(0.5, 0.5);
                            Position = UDim2.new(0.5, 0, 0.5, 0);
                            PlaceholderText = "Search for another player's crew";
                            TextColor3 = Color3.new(0, 0, 0);
                            Text = "";
                            Font = Enum.Font.Bangers;
                            TextScaled = true;
                            [Roact_upvr.Ref] = arg1.crewSearchTextBoxRef;
                            [Roact_upvr.Event.FocusLost] = arg1.crewSearchTextBoxFocusLost;
                            [Roact_upvr.Change.Text] = arg1.crewSearchTextBoxTextChanged;
                        });
                    });
                });
            });
        });
    }
    local tbl_61 = {
        UIListLayout = createElement_upvr("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            SortOrder = Enum.SortOrder.LayoutOrder;
        });
        CloseContainer = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.15, 0, 1, 0);
            LayoutOrder = 10;
        }, {
            Container = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                paddingLeft = 0.5;
                paddingRight = 1;
            }, {
                Button = createElement_upvr(TextButton_upvr, {
                    size = UDim2.new(1, 0, 1, 0);
                    position = UDim2.new(1, 0, 0, 0);
                    anchorPoint = Vector2.new(1, 0);
                    text = "CLOSE";
                    backgroundColor = Color3.fromRGB(233, 76, 64);
                    onClick = arg1.props.onClickClose;
                });
            });
        });
    }
    local var337 = not arg1.props.isPlayersClan
    if var337 then
        var337 = createElement_upvr
        var337 = var337("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.15, 0, 1, 0);
            LayoutOrder = 1;
        }, {
            Container = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                paddingLeft = 0.5;
                paddingRight = 0.5;
            }, {
                Button = createElement_upvr(TextButton_upvr, {
                    size = UDim2.new(1, 0, 1, 0);
                    position = UDim2.new(1, 0, 0, 0);
                    anchorPoint = Vector2.new(1, 0);
                    text = "BACK";
                    backgroundColor = Color3.fromRGB(88, 172, 246);
                    onClick = arg1.props.onClickViewMe;
                    disabled = arg1.props.networkMutexLocked;
                });
            });
        })
    end
    tbl_61.BackContainer = var337
    tbl_59.Right = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
    }, tbl_61)
    module_3.Footer = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0, 0, 0.9090909090909091, 0);
        size = UDim2.new(1, 0, 0.09090909090909091, 0);
        paddingLeft = 0;
        paddingRight = 0;
        paddingTop = 0.5;
        paddingBottom = 0;
    }, tbl_59)
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        backgroundColor = Color3.new(1, 1, 1);
        aspectRatio = arg1.props.aspectRatio;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
    }, module_3)
end
return any_extend_result1