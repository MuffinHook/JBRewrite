local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorldMarkerSystem_upvr = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Players_upvr = game:GetService("Players")
local tbl_upvr_2 = {4, {24, 0}, {math.huge, 8}}
local var9_upvr = require(ReplicatedStorage.Std.Enumer)({"Police", "Criminal", "Friend", "Spotted"})
local tbl_upvr = {
    [var9_upvr.Police] = Color3.fromRGB(84, 215, 253);
    [var9_upvr.Criminal] = Color3.fromRGB(253, 148, 81);
    [var9_upvr.Friend] = Color3.fromRGB(240, 240, 240);
    [var9_upvr.Spotted] = Color3.fromRGB(220, 220, 10);
}
local module_upvr = {
    _mapPlayerIdPlayerMarker = {};
    _playerMarkerGroup = nil;
    _setting = nil;
}
local WorldMarkerGroup_upvr = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local RunService_upvr = game:GetService("RunService")
local gameSettingType_upvr = require(ReplicatedStorage.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage.GameSettings.GameSettingsService)
function module_upvr.init() -- Line 35
    local any_new_result1 = WorldMarkerGroup_upvr.new()
    WorldMarkerSystem_upvr.addGroup(any_new_result1)
    module_upvr._playerMarkerGroup = any_new_result1
    RxInstanceUtils_upvr.observeChildren(Players_upvr, module_upvr._rxChildAdded)
    RunService_upvr.Heartbeat:Connect(module_upvr._draw)
    local tbl = {
        name = "playerMarkers";
        title = "Player Markers";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = true;
        order = 42;
    }
    module_upvr._setting = tbl
    GameSettingsService_upvr.add(tbl)
    module_upvr.updateEnabled()
    tbl.onChanged:Connect(module_upvr.updateEnabled)
    Players_upvr.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers"):Connect(module_upvr.updateEnabled)
end
function module_upvr.updateEnabled() -- Line 62
    local any_getValue_result1 = module_upvr._setting:getValue()
    if any_getValue_result1 then
        if Players_upvr.LocalPlayer:GetAttribute("DisablePlayerMarkers") == true then
            any_getValue_result1 = false
        else
            any_getValue_result1 = true
        end
    end
    module_upvr._playerMarkerGroup:SetEnabled(any_getValue_result1)
end
local HumanoidUnloadConsts_upvr = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
function module_upvr._draw() -- Line 71
    debug.profilebegin("PlayerMarker draw")
    for _, v in pairs(module_upvr._mapPlayerIdPlayerMarker) do
        local _player_2 = v._player
        if _player_2 then
            local Character_2 = _player_2.Character
            if Character_2 then
                local Humanoid = Character_2:FindFirstChild("Humanoid")
                local PrimaryPart_2 = Character_2.PrimaryPart
                if PrimaryPart_2 then
                    v._worldMarker:SetPosition(PrimaryPart_2.Position)
                elseif Humanoid then
                    local SOME = Humanoid:FindFirstChild(HumanoidUnloadConsts_upvr.SERVER_POSITION_OBJ_NAME)
                    if SOME then
                        local Value = SOME.Value
                        v._worldMarker:SetPosition(v._worldMarker:GetPosition() or Value:Lerp(Value, 0.3333333333333333))
                    end
                end
            end
        end
    end
    debug.profileend()
end
local GameUtil_upvr = require(ReplicatedStorage.Game.GameUtil)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local FriendsService_upvr = require(ReplicatedStorage.Friends.FriendsService)
function module_upvr._rxChildAdded(arg1, arg2) -- Line 98
    assert(arg1:IsA("Player"))
    if arg1 == Players_upvr.LocalPlayer then
    else
        arg2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, "TeamValue", function(arg1_2, arg2_2) -- Line 104
            local function update() -- Line 105
                -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
                local var49
                if var49 == Settings_upvr.EnumTeam.Police then
                    local _ = Settings_upvr.EnumTeam.Police
                else
                end
                if arg1_2.Value == Settings_upvr.Team.Police then
                    var49 = Settings_upvr
                    var49 = var49.EnumTeam
                    var49 = var49.Police
                else
                    var49 = Settings_upvr
                    var49 = var49.EnumTeam
                    var49 = var49.Criminal
                end
                if var49 == Settings_upvr.EnumTeam.Criminal then
                    if var49 == Settings_upvr.EnumTeam.Police then
                    else
                    end
                end
                if FriendsService_upvr.getIsFriendsWith(Players_upvr.LocalPlayer, arg1.UserId, true) then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    if var49 == Settings_upvr.EnumTeam.Criminal then
                    end
                end
                if arg1:GetAttribute("CCTVSpotted") == true then
                    local Spotted = var9_upvr.Spotted
                end
                if Spotted then
                    if not module_upvr._doesMarkerExist(arg1) then
                        module_upvr._constructMarker(arg1)
                    end
                    module_upvr._setColor(arg1, tbl_upvr[Spotted])
                elseif module_upvr._doesMarkerExist(arg1) then
                    module_upvr._destructMarker(arg1)
                end
            end
            update()
            arg2_2._listenTeamChange = arg1_2.Changed:Connect(update)
            arg2_2._listenMyTeamChange = GameUtil_upvr.OnTeamChanged:Connect(update)
            arg2_2._listenMyFriendsChange = FriendsService_upvr.friendsUpdated:Connect(update)
            arg2_2:GiveTask(arg1:GetAttributeChangedSignal("CCTVSpotted"):Connect(update))
        end))
        arg2:GiveTask(function() -- Line 149
            if module_upvr._doesMarkerExist(arg1) then
                module_upvr._destructMarker(arg1)
            end
        end)
    end
end
function module_upvr._doesMarkerExist(arg1) -- Line 166
    local var53
    if module_upvr._mapPlayerIdPlayerMarker[arg1.UserId] == nil then
        var53 = false
    else
        var53 = true
    end
    return var53
end
local WorldMarker_upvr = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
function module_upvr._constructMarker(arg1) -- Line 169
    if arg1 == nil then
    else
    end
    assert(true)
    if arg1 == Players_upvr.LocalPlayer then
    else
    end
    assert(true)
    if module_upvr._mapPlayerIdPlayerMarker[arg1.UserId] then
        error("Player marker already exists for: %s":format(arg1.Name))
    else
        local any_new_result1_2 = WorldMarker_upvr.new()
        any_new_result1_2:SetScreenGui(WorldMarkerSystem_upvr.gui)
        any_new_result1_2:SetSizes(tbl_upvr_2)
        any_new_result1_2:SetIcon(7028057307)
        module_upvr._playerMarkerGroup:Add(any_new_result1_2)
        local tbl_2 = {
            _worldMarker = any_new_result1_2;
        }
        tbl_2._player = arg1
        module_upvr._mapPlayerIdPlayerMarker[arg1.UserId] = tbl_2
    end
end
function module_upvr._setColor(arg1, arg2) -- Line 188
    module_upvr._mapPlayerIdPlayerMarker[arg1.UserId]._worldMarker.FrameInner.ImageColor3 = arg2
end
function module_upvr._destructMarker(arg1) -- Line 193
    if arg1 == nil then
    else
    end
    assert(true)
    local var57 = module_upvr._mapPlayerIdPlayerMarker[arg1.UserId]
    if not var57 then
        error("Player marker does not exist for: %s":format(arg1.Name))
    else
        module_upvr._mapPlayerIdPlayerMarker[arg1.UserId] = nil
        module_upvr._playerMarkerGroup:Remove(var57._worldMarker)
        var57._worldMarker:Destroy()
        var57._worldMarker = nil
        var57._player = nil
    end
end
return module_upvr