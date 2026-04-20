-- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
local Players_upvr = game:GetService("Players")
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
local Maid = require(ReplicatedStorage_upvr.Std.Maid)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local WorldMarkerSystem_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerSystem)
local MinimapService_upvr = require(ReplicatedStorage_upvr.App.MinimapService)
Maid.new():GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 28
    local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
    if any_getRootPart_result1 then
        MinimapService_upvr.mapUpdateWorldPosition(any_getRootPart_result1.Position)
        MinimapService_upvr.mapUpdateWorldDirection(any_getRootPart_result1.CFrame.LookVector)
    end
end))
local function _(arg1) -- Line 38, Named "getColorFromTeam"
    if arg1 == Settings_upvr.Team.Police then
        return Settings_upvr.TeamColor[Settings_upvr.EnumTeam.Police]
    end
    return Settings_upvr.TeamColor[Settings_upvr.EnumTeam.Criminal]
end
local HapticEffect_upvr = require(ReplicatedStorage_upvr.App.HapticEffect)
CharacterUtils_upvr.observeLocalCharacterAdded(function(arg1, arg2) -- Line 46
    local Humanoid_upvr = arg1:FindFirstChild("Humanoid")
    local Health_upvw = Humanoid_upvr.Health
    arg2:GiveTask(Humanoid_upvr:GetPropertyChangedSignal("Health"):Connect(function() -- Line 49
        if Humanoid_upvr.Health <= 0 then
            HapticEffect_upvr.basic(1, 1)
        elseif Humanoid_upvr.Health < Health_upvw then
            HapticEffect_upvr.basic(1, 0.2)
        end
        Health_upvw = Humanoid_upvr.Health
    end))
end)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local HumanoidUnloadConsts_upvr = require(ReplicatedStorage_upvr.HumanoidUnload.HumanoidUnloadConsts)
CharacterUtils_upvr.observeCharacterAdded(function(arg1, arg2) -- Line 59
    local Humanoid_upvr_2 = arg1:FindFirstChild("Humanoid")
    assert(Humanoid_upvr_2)
    local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(arg1)
    if any_GetPlayerFromCharacter_result1 == Players_upvr.LocalPlayer then
    else
        local tbl_upvr = {
            name = any_GetPlayerFromCharacter_result1.Name;
            flash = false;
        }
        arg2:GivePromise(Promise_upvr.all({RxInstanceUtils_upvr.waitForChild(any_GetPlayerFromCharacter_result1, "TeamValue", 5), RxInstanceUtils_upvr.waitForChild(Players_upvr.LocalPlayer, "TeamValue", 5)}):andThen(function(arg1_2) -- Line 77
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local _1_upvr = arg1_2[1]
            local _2_upvr = arg1_2[2]
            local var39
            if _1_upvr.Value == Settings_upvr.Team.Police then
                var39 = Settings_upvr.TeamColor[Settings_upvr.EnumTeam.Police]
            else
                var39 = Settings_upvr.TeamColor[Settings_upvr.EnumTeam.Criminal]
            end
            local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(var39)
            tbl_upvr.color = any_createBinding_result1
            tbl_upvr.updateColor = any_createBinding_result2
            local function _() -- Line 83, Named "updateFlash"
                local var42 = true
                if _2_upvr.Value == _1_upvr.Value then
                    if Players_upvr.LocalPlayer:GetAttribute("DisablePlayerMarkers") ~= true then
                        var42 = false
                    else
                        var42 = true
                    end
                end
                tbl_upvr.flash = var42
            end
            any_createBinding_result2 = _1_upvr.Changed
            any_createBinding_result2 = any_createBinding_result2:Connect(function(arg1_3) -- Line 87
                local var44
                if arg1_3 == Settings_upvr.Team.Police then
                    var44 = Settings_upvr.TeamColor[Settings_upvr.EnumTeam.Police]
                else
                    var44 = Settings_upvr.TeamColor[Settings_upvr.EnumTeam.Criminal]
                end
                tbl_upvr.updateColor(var44)
                var44 = true
                if _2_upvr.Value == _1_upvr.Value then
                    if Players_upvr.LocalPlayer:GetAttribute("DisablePlayerMarkers") ~= true then
                        var44 = false
                    else
                        var44 = true
                    end
                end
                tbl_upvr.flash = var44
            end)
            arg2:GiveTask(any_createBinding_result2)
            any_createBinding_result2 = _2_upvr.Changed
            any_createBinding_result2 = any_createBinding_result2:Connect(function() -- Line 91
                local var46 = true
                if _2_upvr.Value == _1_upvr.Value then
                    if Players_upvr.LocalPlayer:GetAttribute("DisablePlayerMarkers") ~= true then
                        var46 = false
                    else
                        var46 = true
                    end
                end
                tbl_upvr.flash = var46
            end)
            arg2:GiveTask(any_createBinding_result2)
            any_createBinding_result2 = Players_upvr
            any_createBinding_result2 = any_createBinding_result2.LocalPlayer:GetAttributeChangedSignal("DisablePlayerMarkers")
            any_createBinding_result2 = any_createBinding_result2:Connect(function() -- Line 94
                local var48 = true
                if _2_upvr.Value == _1_upvr.Value then
                    if Players_upvr.LocalPlayer:GetAttribute("DisablePlayerMarkers") ~= true then
                        var48 = false
                    else
                        var48 = true
                    end
                end
                tbl_upvr.flash = var48
            end)
            arg2:GiveTask(any_createBinding_result2)
            any_createBinding_result2 = _2_upvr.Value
            if any_createBinding_result2 == _1_upvr.Value then
                any_createBinding_result2 = Players_upvr
                any_createBinding_result2 = any_createBinding_result2.LocalPlayer:GetAttribute("DisablePlayerMarkers")
                if any_createBinding_result2 ~= true then
                else
                end
            end
            tbl_upvr.flash = true
            any_createBinding_result2 = MinimapService_upvr
            any_createBinding_result2 = any_createBinding_result2.add(tbl_upvr)
            arg2:GiveTask(any_createBinding_result2)
        end))
        arg2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, "HumanoidRootPart", function(arg1_4, arg2_2) -- Line 102
            tbl_upvr.part = arg1_4
            arg2_2:GiveTask(function() -- Line 104
                tbl_upvr.part = nil
            end)
        end))
        arg2:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 108
            if tbl_upvr._position and not tbl_upvr.part and Humanoid_upvr_2:FindFirstChild(HumanoidUnloadConsts_upvr.SERVER_POSITION_OBJ_NAME) then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                tbl_upvr._updatePosition(tbl_upvr._position:getValue():Lerp(Humanoid_upvr_2:FindFirstChild(HumanoidUnloadConsts_upvr.SERVER_POSITION_OBJ_NAME).Value, 0.3333333333333333))
            end
        end))
    end
end)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local tbl_3 = {
    type = "setPremium";
}
local any_DoesPlayerOwn_result1 = GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage)
if not any_DoesPlayerOwn_result1 then
    any_DoesPlayerOwn_result1 = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerUtils).getIsBattleServer()
end
tbl_3.premium = any_DoesPlayerOwn_result1
store_upvr:dispatch(tbl_3)
GamepassSystem_upvr.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.PremiumGarage):Connect(function() -- Line 130
    store_upvr:dispatch({
        type = "setPremium";
        premium = true;
    })
end)
for _, v in GamepassUtils.EnumGamepass:GetEnumItems() do
    local var97_upvr = GamepassUtils.EnumGamepass[v]
    store_upvr:dispatch({
        type = "setGamepassOwned";
        gamepassEnum = var97_upvr;
        gamepassOwned = GamepassSystem_upvr.DoesPlayerOwn(var97_upvr);
    })
    GamepassSystem_upvr.GetGamepassOwnedSignal(var97_upvr):Connect(function() -- Line 144
        store_upvr:dispatch({
            type = "setGamepassOwned";
            gamepassEnum = var97_upvr;
            gamepassOwned = GamepassSystem_upvr.DoesPlayerOwn(var97_upvr);
        })
    end)
end
local any_new_result1_upvr_3 = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerGroup).new()
WorldMarkerSystem_upvr.addGroup(any_new_result1_upvr_3)
local any_new_result1_upvr_2 = Maid.new()
local WorldMarker_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarker)
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local createElement_upvr = Roact_upvr.createElement
local function setWaypoint_upvr(arg1) -- Line 162, Named "setWaypoint"
    any_new_result1_upvr_2:DoCleaning()
    if arg1 then
        local part_upvr = arg1.part
        local clone_upvw_2 = ReplicatedStorage_upvr.App.Res:FindFirstChild("WaypointMarker"):Clone()
        if arg1.position then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            clone_upvw_2:PivotTo(CFrame.new(arg1.position))
        elseif part_upvr then
            local Position_upvw = part_upvr.Position
            clone_upvw_2:PivotTo(CFrame.new(Position_upvw))
            any_new_result1_upvr_2:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 176
                if part_upvr and part_upvr:IsDescendantOf(workspace) then
                    Position_upvw = part_upvr.Position
                    clone_upvw_2:PivotTo(CFrame.new(Position_upvw))
                else
                    store_upvr:dispatch({
                        type = "removeWaypointByName";
                        name = arg1.name;
                    })
                end
            end))
        end
        clone_upvw_2.Parent = workspace
        any_new_result1_upvr_2:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 189
            clone_upvw_2.Arrow.CFrame = clone_upvw_2.ArrowRoot.CFrame * CFrame.Angles(0, os.clock() % (-math.pi*2), 0)
        end))
        any_new_result1_upvr_2:GiveTask(clone_upvw_2)
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = clone_upvw_2.PrimaryPart
        local clone_upvw = ReplicatedStorage_upvr.App.Res:FindFirstChild("SlowArrowBeam"):Clone()
        clone_upvw.Attachment0 = Attachment
        clone_upvw.Parent = clone_upvw_2
        any_new_result1_upvr_2:GiveTask(clone_upvw)
        local any_new_result1_upvr = WorldMarker_upvr.new()
        any_new_result1_upvr:SetScreenGui(WorldMarkerSystem_upvr.gui)
        if Position_upvw then
            any_new_result1_upvr:SetPosition(Position_upvw)
        elseif part_upvr then
            any_new_result1_upvr:SetAdornee(part_upvr)
        end
        any_new_result1_upvr:SetIcon(5920742944)
        any_new_result1_upvr.FrameInner.ImageColor3 = Color3.fromRGB(255, 108, 98)
        any_new_result1_upvr_3:Add(any_new_result1_upvr)
        any_new_result1_upvr_2:GiveTask(function() -- Line 216
            any_new_result1_upvr_3:Remove(any_new_result1_upvr)
            any_new_result1_upvr:Destroy()
        end)
        store_upvr:dispatch({
            type = "addMinimapLabel";
            title = arg1.name..'_';
            imageId = 5920742944;
            position = any_new_result1_upvr:GetPosition();
            markerColor = any_new_result1_upvr.FrameInner.ImageColor3;
            scale = 1.5;
        })
        any_new_result1_upvr._maid:GiveTask(function() -- Line 229
            store_upvr:dispatch({
                type = "removeMinimapLabel";
                title = arg1.name..'_';
            })
        end)
        local minDist_upvr = arg1.minDist
        local function update() -- Line 237
            local any_getRootPart_result1_2 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
            if any_getRootPart_result1_2 then
                clone_upvw.Attachment1 = any_getRootPart_result1_2:FindFirstChildOfClass("Attachment")
                if ((clone_upvw_2.PrimaryPart.Position - any_getRootPart_result1_2.Position) * Vector3.new(1, 0, 1)).Magnitude < minDist_upvr then
                    store_upvr:dispatch({
                        type = "removeWaypointByName";
                        name = arg1.name;
                    })
                end
            end
        end
        update()
        any_new_result1_upvr_2:GiveTask(Interval_upvr.every(1):Connect(update))
        if arg1.message then
            local any_mount_result1_upvr = Roact_upvr.mount((function() -- Line 255, Named "getComponent"
                local module = {}
                local tbl_2 = {
                    LayoutOrder = 1;
                    BackgroundTransparency = 1;
                }
                local var90
                if not EzUtils_upvr.isSmallScreen() then
                    var90 = 0.045
                else
                    var90 = 0.07500000000000001
                end
                tbl_2.Size = UDim2.fromScale(0.6, var90)
                var90 = 1
                tbl_2.AnchorPoint = Vector2.new(0.5, var90)
                var90 = 0.75
                tbl_2.Position = UDim2.fromScale(0.5, var90)
                local tbl = {}
                var90 = "TextLabel"
                tbl.Text = createElement_upvr(var90, {
                    BackgroundTransparency = 1;
                    Size = UDim2.fromScale(1, 1);
                    Position = UDim2.fromScale(0.5, 0.5);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = arg1.message;
                    TextColor3 = Color3.new(0.95, 0.05, 0.05);
                    TextScaled = true;
                }, {
                    Stroke = createElement_upvr("UIStroke", {
                        Thickness = 1;
                        Color = Color3.new(0.1, 0.1, 0.1);
                        Transparency = 0.2;
                    });
                })
                module.Message = createElement_upvr("Frame", tbl_2, tbl)
                return createElement_upvr("ScreenGui", {
                    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                    ResetOnSpawn = false;
                    IgnoreGuiInset = true;
                }, module)
            end)(), Players_upvr.LocalPlayer.PlayerGui, "WaypointGui")
            any_new_result1_upvr_2:GiveTask(function() -- Line 334
                Roact_upvr.unmount(any_mount_result1_upvr)
            end)
        end
    end
end
local ChatUtils_upvr = require(ReplicatedStorage_upvr.Chat.ChatUtils)
function var97_upvr(arg1, arg2) -- Line 340
    if arg1.minimapWaypoints ~= arg2.minimapWaypoints then
        local minimapWaypoints = arg1.minimapWaypoints
        setWaypoint_upvr(minimapWaypoints[#minimapWaypoints])
    elseif arg1.otherTradeServerListConfig ~= arg2.otherTradeServerListConfig then
        if arg1.otherTradeServerListConfig.visible then
            ChatUtils_upvr.setEnabled(false)
            return
        end
        ChatUtils_upvr.setEnabled(true)
    end
end
store_upvr.changed:connect(var97_upvr)
if require(ReplicatedStorage_upvr.App.RunUtils).isTradeWorld() then
    require(ReplicatedStorage_upvr.App.TradeWorldApp).init()
end