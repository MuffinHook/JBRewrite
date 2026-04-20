local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Roact_upvr = require(ReplicatedStorage.Roact)
local function _() -- Line 26, Named "playClick"
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
function any_extend_result1.init(arg1) -- Line 38
    arg1.maid = Maid_upvr.new()
    function arg1.onClickAdmin(arg1_2) -- Line 41
        arg1.props.attemptAdmin(arg1_2.userId)
    end
    function arg1.onClickRenameCrew(arg1_3) -- Line 44
        arg1.props.attemptRenameCrew(arg1_3)
    end
    function arg1.onClickUnAdmin(arg1_4) -- Line 47
        arg1.props.attemptUnAdmin(arg1_4.userId)
    end
    function arg1.onClickKick(arg1_5) -- Line 50
        arg1.props.attemptKick(arg1_5.userId)
    end
    function arg1.onClickJoinRequestAccept(arg1_6) -- Line 53
        arg1.props.onClickJoinRequestAccept(arg1_6.userId)
    end
    function arg1.onClickJoinRequestDeny(arg1_7) -- Line 56
        arg1.props.onClickJoinRequestDeny(arg1_7.userId)
    end
    arg1:setState({
        showRequests = false;
        countdownTil = 0;
        countdownVisible = false;
        isSmallScreen = Utils_upvr.isSmallScreen();
    })
    arg1.maid:GiveTask(Utils_upvr.getViewportSizeChangedSignal():Connect(function() -- Line 65
        arg1:setState({
            isSmallScreen = Utils_upvr.isSmallScreen();
        })
    end))
    function arg1.onClickToggleRequests() -- Line 70
        arg1:setState({
            showRequests = not arg1.state.showRequests;
        })
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                Volume = 0.2;
            })
        end
    end
    function arg1.onClickCloseWelcome() -- Line 76
        arg1:setState({
            welcomeVisible = false;
        })
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                Volume = 0.2;
            })
        end
    end
    function arg1.onClickViewMe() -- Line 82
        arg1.props.attemptViewUserIdClan(Players_upvr.LocalPlayer.UserId)
        arg1.props.onClickViewMe()
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                Volume = 0.2;
            })
        end
    end
    function arg1.onCountdownElapsed(arg1_8) -- Line 87
        if arg1_8 < 0 then
            arg1:setState({
                countdownVisible = false;
            })
            arg1.props.onCountdownFinished()
        end
    end
    function arg1.onReportDialogClose() -- Line 96
        arg1:setState({
            reportDialogVisible = false;
        })
    end
    function arg1.onReportDialogSubmit(arg1_9, arg2) -- Line 101
        arg1.props.attemptReportCrew(arg1_9, arg2)
    end
end
local Glicko2Consts_upvr = require(ReplicatedStorage.Glicko2.Glicko2Consts)
local createElement_upvr = Roact_upvr.createElement
local Info_upvr = require(script.Parent.Info)
local JoinOrCreate_upvr = require(script.Parent.JoinOrCreate)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
local Welcome_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.Welcome)
local BattleInvites_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.BattleInvites)
local Elapsed_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.Elapsed)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local BattleCrewInfo_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.BattleCrewInfo)
local ReportCrew_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.ReportCrew)
local Responses_upvr = require(ReplicatedStorage.PersistentCrewBattle.UI.Responses)
function any_extend_result1.render(arg1) -- Line 105
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var48 = arg1.props.viewingClanInfo or arg1.props.currentClanInfo
    local tbl = {}
    local groupVisible = arg1.props.groupVisible
    local var51
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var51 = createElement_upvr
    local tbl_2 = {
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
    }
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [335.5]
    tbl_2.Size = nil
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [337.6]
    tbl_2.Position = nil
    tbl_2.AnchorPoint = arg1.props.anchorPoint
    var51 = var51("Frame", tbl_2, Dictionary_upvr.merge({
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1.7777777777777777;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 8);
        });
    }, groupVisible))
    tbl.Group = var51
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.state.welcomeVisible then
        local tbl_4 = {}
        var51 = arg1.onClickCloseWelcome
        tbl_4.onClickClose = var51
        tbl.Welcome = createElement_upvr(Welcome_upvr, tbl_4)
    end
    local tbl_3 = {}
    var51 = UDim2.new(0.3333333333333333, 0, 0.3333333333333333, 0)
    tbl_3.size = var51
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var51 = UDim2.new(0.5, 0, 0.6666666666666666, 0)
        return var51
    end
    if not arg1.state.isSmallScreen or not decompInlinedCondition() then
        var51 = UDim2.new(1, 0, 0.5, 0)
    end
    tbl_3.position = var51
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var51 = Vector2.new(0.5, 0.5)
        return var51
    end
    if not arg1.state.isSmallScreen or not decompInlinedCondition_2() then
        var51 = Vector2.new(1, 0.5)
    end
    tbl_3.anchorPoint = var51
    var51 = arg1.props
    var51 = var51.onAcceptBattleInvite
    tbl_3.onAccept = var51
    var51 = arg1.props
    var51 = var51.onDeclineBattleInvite
    tbl_3.onDecline = var51
    tbl.BattleInvites = createElement_upvr(BattleInvites_upvr, tbl_3)
    local var58 = var48
    if var58 then
        var58 = var48.ClanId
    end
    var51 = nil
    for i in arg1.props.clanName, var51 do
        table.insert({}, i)
        local var60
    end
    var51 = var60[1]
    if var51 == var58 then
    else
    end
    var51 = arg1.props
    var51 = var51.attackingClanId
    if arg1.props.penalty == nil then
    else
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local PersistentCrewBattleUtils_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
function any_extend_result1.didMount(arg1) -- Line 479
    arg1:_updateWelcomeVisible()
    local function updateCountdown() -- Line 482
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
function any_extend_result1._updateWelcomeVisible(arg1) -- Line 494
    if arg1.props.isBattleServer then
        arg1:setState({
            welcomeVisible = true;
        })
    end
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 501
    if arg1.props.isBattleServer ~= arg2.isBattleServer then
        arg1:_updateWelcomeVisible()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 506
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 509
    return {
        viewingClanInfo = arg1.viewingClanInfo;
        currentClanInfo = arg1.currentClanInfo;
        membersOnlineMap = arg1.membersOnlineMap;
        members = arg1.members;
        joinRequests = arg1.joinRequests;
        isReadiedUp = arg1.isReadiedUp;
        groupVisible = arg1.groupVisible;
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
end, function(arg1) -- Line 529
    return {
        onClickClose = function() -- Line 531, Named "onClickClose"
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
        onClickViewMe = function() -- Line 538, Named "onClickViewMe"
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