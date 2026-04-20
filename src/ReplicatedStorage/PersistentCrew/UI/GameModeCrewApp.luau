local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Roact_upvr = require(ReplicatedStorage.Roact)
local function _() -- Line 20, Named "playClick"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
            Volume = 0.2;
        })
    end
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("PersistentCrewApp")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(0.9, 0.9);
    position = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Utils_upvr = require(ReplicatedStorage.EzUi.Utils)
function any_extend_result1.init(arg1) -- Line 32
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        showRequests = false;
        countdownTil = 0;
        countdownVisible = false;
        isSmallScreen = Utils_upvr.isSmallScreen();
    })
    arg1.maid:GiveTask(Utils_upvr.getViewportSizeChangedSignal():Connect(function() -- Line 41
        arg1:setState({
            isSmallScreen = Utils_upvr.isSmallScreen();
        })
    end))
    function arg1.onClickCloseWelcome() -- Line 46
        arg1:setState({
            welcomeVisible = false;
        })
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                Volume = 0.2;
            })
        end
    end
    function arg1.onCountdownElapsed(arg1_2) -- Line 52
        if arg1_2 < 0 then
            arg1:setState({
                countdownVisible = false;
            })
            arg1.props.onCountdownFinished()
        end
    end
end
local createElement_upvr = Roact_upvr.createElement
local Welcome_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.Welcome)
local Elapsed_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.Elapsed)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local BattleCrewInfo_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.BattleCrewInfo)
function any_extend_result1.render(arg1) -- Line 61
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local module = {}
    local var28
    if arg1.state.welcomeVisible then
        module.Welcome = createElement_upvr(Welcome_upvr, {
            onClickClose = arg1.onClickCloseWelcome;
        })
    end
    local CrewBattleTeam = Players_upvr.LocalPlayer:GetAttribute("CrewBattleTeam")
    for i in arg1.props.clanName do
        var28 = table.insert
        var28({}, i)
        local var32
    end
    if var32[1] == CrewBattleTeam then
        local _ = var32[2]
    else
    end
    local attackingClanId = arg1.props.attackingClanId
    var28 = 177
    local Color3_fromRGB_result1 = Color3.fromRGB(121, 251, var28)
    var28 = 49
    local penalty = arg1.props.penalty
    if penalty == nil then
        var28 = false
    else
        var28 = true
    end
    if arg1.props.isBattleServer then
        local tbl_4 = {}
        local tbl_5 = {}
        local tbl_6 = {}
        local var42 = 2
        tbl_6.Thickness = var42
        if var28 then
            var42 = Color3.fromRGB(255, var28, 49)
        else
            var42 = Color3_fromRGB_result1
        end
        tbl_6.Color = var42
        tbl_6.Transparency = 0.75
        tbl_5.UIStroke = createElement_upvr("UIStroke", tbl_6)
        tbl_5.UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 32);
        })
        tbl_4.BorderOuter = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(1, -48, 1, -48);
            Position = UDim2.fromOffset(24, 24);
        }, tbl_5)
        tbl_4.BorderInner = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(1, -84, 1, -84);
            Position = UDim2.fromOffset(42, 42);
        }, {
            UIStroke = createElement_upvr("UIStroke", {
                Thickness = 2;
                Color = Color3_fromRGB_result1;
                Transparency = 0.5;
            });
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 32);
            });
        })
        module.Container = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
        }, tbl_4)
        if var28 then
        end
        module.Penalty = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(0.5, 0, 0, 16);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0, 23);
            ZIndex = 3;
        }, {
            Timer = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.fromRGB(255, var28, 49);
                Size = UDim2.fromScale(0.1, 1);
                AnchorPoint = Vector2.new(0.5, 0);
                Position = UDim2.fromScale(0.5, 0);
            }, {
                UICorners = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0.25, 0);
                });
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = penalty;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
        })
        local tbl_8 = {}
        local tbl_7 = {
            UIStroke = createElement_upvr("UIStroke", {
                Thickness = 2;
                Color = Color3_fromRGB_result1;
                Transparency = 0.5;
            });
            UICorners = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0.25, 0);
            });
        }
        local tbl_3 = {
            font = Enum.Font.FredokaOne;
            position = UDim2.fromScale(0.5, 0.5);
            textColor = ColorUtils_upvr.saturateBy(Color3_fromRGB_result1, 0.8);
            createdAt = arg1.props.startedAt[attackingClanId];
        }
        local var61 = arg1.props.timeTook[attackingClanId]
        tbl_3.elapsed = var61
        if arg1.props.startedAt[attackingClanId] ~= nil then
            var61 = false
        else
            var61 = true
        end
        tbl_3.disabled = var61
        tbl_7.ElapsedContainer = createElement_upvr(Elapsed_upvr, tbl_3)
        tbl_8.Timer = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            Size = UDim2.fromScale(0.125, 1.5);
            AnchorPoint = Vector2.new(0.5, 0.25);
            Position = UDim2.fromScale(0.5, 0.5);
        }, tbl_7)
        local tbl = {
            clanName = arg1.props.clanName[CrewBattleTeam];
            backgroundColor = Color3_fromRGB_result1;
            size = UDim2.fromScale(0.4, 1);
            position = UDim2.fromScale(0, 0.5);
            anchorPoint = Vector2.new(0, 0.5);
            createdAt = arg1.props.startedAt[CrewBattleTeam];
        }
        if arg1.props.startedAt[CrewBattleTeam] == nil then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        tbl.elapsed = arg1.props.timeTook[CrewBattleTeam]
        if arg1.props.startedAt[CrewBattleTeam] ~= nil then
        else
        end
        tbl.disabled = true
        if CrewBattleTeam ~= attackingClanId then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        tbl.attacking = true
        tbl.robberiesCompleted = arg1.props.robberiesCompleted
        tbl_8.CrewOurs = createElement_upvr(BattleCrewInfo_upvr, tbl)
        local tbl_2 = {
            clanName = arg1.props.clanName[var32[1]];
            backgroundColor = Color3_fromRGB_result1;
            size = UDim2.fromScale(0.4, 1);
            position = UDim2.fromScale(1, 0.5);
            anchorPoint = Vector2.new(1, 0.5);
        }
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        tbl_2.createdAt = arg1.props.startedAt[var32[1]]
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if arg1.props.startedAt[var32[1]] == nil then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        tbl_2.elapsed = arg1.props.timeTook[var32[1]]
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if arg1.props.startedAt[var32[1]] ~= nil then
        else
        end
        tbl_2.disabled = true
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if var32[1] ~= attackingClanId then
        else
        end
        tbl_2.attacking = true
        tbl_2.robberiesCompleted = arg1.props.robberiesCompleted
        tbl_8.CrewTheirs = createElement_upvr(BattleCrewInfo_upvr, tbl_2, {
            Report = false;
        })
        module.TopBar = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(0.5, 0, 0, 24);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0, 41);
            ZIndex = 3;
        }, tbl_8)
        if arg1.state.countdownVisible then
            module.Countdown = createElement_upvr(Elapsed_upvr, {
                createdAt = arg1.state.countdownTil;
                countDown = true;
                onElapsed = arg1.onCountdownElapsed;
                textColor = Color3.new(0.2, 0.2, 0.2);
                alwaysShowMinutes = false;
            }, {
                UIStroke = createElement_upvr("UIStroke", {
                    Thickness = 2;
                    Color = Color3.fromRGB(255, 215, 0);
                });
            })
        end
    end
    return Roact_upvr.createFragment(module)
end
local PersistentCrewBattleUtils_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
function any_extend_result1.didMount(arg1) -- Line 270
    arg1:_updateWelcomeVisible()
    local function updateCountdown() -- Line 273
        local any_getRoundStartsAt_result1 = PersistentCrewBattleUtils_upvr.getRoundStartsAt()
        if any_getRoundStartsAt_result1 and workspace:GetServerTimeNow() < any_getRoundStartsAt_result1 then
            arg1:setState({
                countdownVisible = true;
                countdownTil = any_getRoundStartsAt_result1;
            })
        end
    end
    arg1.maid:GiveTask(PersistentCrewBattleUtils_upvr.getRoundStartsAtAttributeChangedSignal():Connect(updateCountdown))
    updateCountdown()
end
function any_extend_result1._updateWelcomeVisible(arg1) -- Line 285
    if arg1.props.isBattleServer then
        arg1:setState({
            welcomeVisible = true;
        })
    end
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 292
    if arg1.props.isBattleServer ~= arg2.isBattleServer then
        arg1:_updateWelcomeVisible()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 297
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 300
    return {
        timeTook = arg1.timeTook;
        startedAt = arg1.startedAt;
        isBattleServer = arg1.isBattleServer;
        clanName = arg1.clanName;
        networkMutexLocked = arg1.networkMutexLocked;
        robberiesCompleted = arg1.robberiesCompleted;
        attackingClanId = arg1.attackingClanId;
        battleResponseData = arg1.battleResponseData;
        penalty = arg1.penalty;
    }
end, function(arg1) -- Line 313
    return {
        onClickClose = function() -- Line 315, Named "onClickClose"
            arg1({
                type = "setGroupVisible";
                value = false;
            })
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onClickViewMe = function() -- Line 322, Named "onClickViewMe"
            arg1({
                type = "setMembers";
                value = {};
            })
            arg1({
                type = "setViewingClanInfo";
                value = nil;
            })
        end;
    }
end)(any_extend_result1)