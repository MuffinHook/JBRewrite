local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local Utils_upvr = require(ReplicatedStorage_upvr.EzUi.Utils)
local Players_upvr = game:GetService("Players")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local createElement_upvr = Roact_upvr.createElement
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local MinimapConsts = require(ReplicatedStorage_upvr.App.MinimapConsts)
local SidebarUI_upvr = require(ReplicatedStorage_upvr.Game.SidebarUI)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local any_getWorld_result1 = RunUtils_upvr.getWorld()
local any_extend_result1 = Roact_upvr.Component:extend("App")
any_extend_result1.defaultProps = {
    mapImageId = assert(MinimapConsts.MAP_IMAGE_ID[any_getWorld_result1], "missing mapImageId");
    mapWorldWidth = assert(MinimapConsts.MAP_WORLD_WIDTH[any_getWorld_result1], "missing mapWorldWidth");
    mapWorldHeight = assert(MinimapConsts.MAP_WORLD_HEIGHT[any_getWorld_result1], "missing mapWorldHeight");
    mapWorldCenterX = assert(MinimapConsts.MAP_WORLD_CENTER_X[any_getWorld_result1], "missing mapWorldCenterX");
    mapWorldCenterY = assert(MinimapConsts.MAP_WORLD_CENTER_Y[any_getWorld_result1], "missing mapWorldCenterY");
    mapImageWidth = 512;
    mapImageHeight = 512;
}
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
local gameSettingType_upvr = require(ReplicatedStorage_upvr.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage_upvr.GameSettings.GameSettingsService)
local HotbarSystem_upvr = require(ReplicatedStorage_upvr.Hotbar.HotbarSystem)
local AdminPermUtils_upvr = require(ReplicatedStorage_upvr.App.AdminPermUtils)
local RunService_upvr = game:GetService("RunService")
local SpeedometerUtils_upvr = require(ReplicatedStorage_upvr.Speedometer.SpeedometerUtils)
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
local CCTVService_upvr = require(ReplicatedStorage_upvr.CCTV.CCTVService)
local GarageUtils_upvr = require(ReplicatedStorage_upvr.Garage.GarageUtils)
local GarageConsts_upvr_2 = require(ReplicatedStorage_upvr.Garage.GarageConsts)
local SaleConsts_upvr = require(ReplicatedStorage_upvr.Sale.SaleConsts)
local Notification_upvr = require(ReplicatedStorage_upvr.Game.Notification)
local Confirmation_upvr = require(ReplicatedStorage_upvr.Module.Confirmation)
local ItemUtils_upvr = require(ReplicatedStorage_upvr.App.ItemUtils)
local String_upvr = require(ReplicatedStorage_upvr.Std.String)
local PlayerUtils_upvr = require(ReplicatedStorage_upvr.Game.PlayerUtils)
local GarageConsts_upvr = require(ReplicatedStorage_upvr.Game.Garage.GarageConsts)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local CashBuyUI_upvr = require(ReplicatedStorage_upvr.Game.CashBuyUI)
local MinimapService_upvr = require(ReplicatedStorage_upvr.App.MinimapService)
local SpawnSelectionService_upvr = require(ReplicatedStorage_upvr.SpawnSelection.SpawnSelectionService)
function any_extend_result1.init(arg1) -- Line 94
    arg1._maid = Maid_upvr.new()
    arg1:setState({
        controlsEnabled = true;
        teamColor = Settings_upvr.TeamColor[GameUtil_upvr.Team];
        isSmallScreen = Utils_upvr.isSmallScreen();
        minimapOpen = true;
        megamapOpen = false;
        bounty = 0;
        speedometerEnabled = false;
        vehicleLocked = false;
        hasLicensePlate = false;
        licensePlateText = "JAILBRK";
        missilesEnabled = false;
        devPanelVisible = false;
        garageVisible = false;
    })
    arg1._maid:GiveTask(Utils_upvr.getViewportSizeChangedSignal():Connect(function() -- Line 111
        arg1:setState({
            isSmallScreen = Utils_upvr.isSmallScreen();
        })
    end))
    arg1._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(Players_upvr.LocalPlayer, "ChoosingTeam", function(arg1_2, arg2) -- Line 120
        arg2:GiveTask(arg1_2.Changed:Connect(function(arg1_3) -- Line 121, Named "handler"
            arg1:setState({
                controlsEnabled = not arg1_3;
            })
        end))
        arg1:setState({
            controlsEnabled = not arg1_2.Value;
        })
    end))
    arg1._maid:GiveTask(GameUtil_upvr.OnTeamChanged:Connect(function(arg1_4) -- Line 131
        arg1:setState({
            teamColor = Settings_upvr.TeamColor[arg1_4];
        })
    end))
    arg1:setState({
        bounty = GameUtil_upvr.bounty;
    })
    arg1._maid:GiveTask(GameUtil_upvr.onBountyChanged:Connect(function() -- Line 137, Named "updateBounty"
        arg1:setState({
            bounty = GameUtil_upvr.bounty;
        })
    end))
    local any_createBinding_result1_3, any_createBinding_result2_3 = Roact_upvr.createBinding(123456)
    arg1._spdDistance = any_createBinding_result1_3
    arg1._updateSpdDistance = any_createBinding_result2_3
    local any_createBinding_result1_2, any_createBinding_result2 = Roact_upvr.createBinding(878)
    arg1._spdSpeed = any_createBinding_result1_2
    arg1._updateSpdSpeed = any_createBinding_result2
    local any_createBinding_result1, any_createBinding_result2_2 = Roact_upvr.createBinding(0)
    arg1._spdAccelRatio = any_createBinding_result1
    arg1._updateSpdAccelRatio = any_createBinding_result2_2
    local tbl_15_upvr = {
        name = "hotbarWithSpeedometer";
        title = "Hotbar With Speedometer";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = false;
        order = 51;
    }
    GameSettingsService_upvr.add(tbl_15_upvr)
    if VehicleUtils_upvr.GetLocalVehiclePacket and VehicleUtils_upvr.GetLocalVehiclePacket() then
        if tbl_15_upvr:getValue() then
            HotbarSystem_upvr.show()
        else
            HotbarSystem_upvr.hide()
        end
    end
    tbl_15_upvr.onChanged:Connect(function(arg1_5) -- Line 157, Named "handleSetting"
        if VehicleUtils_upvr.GetLocalVehiclePacket and VehicleUtils_upvr.GetLocalVehiclePacket() then
            if arg1_5 then
                HotbarSystem_upvr.show()
                return
            end
            HotbarSystem_upvr.hide()
        end
    end)
    if AdminPermUtils_upvr.hasPerms(Players_upvr.LocalPlayer) then
        arg1._maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_6, arg2) -- Line 170
            if not arg2 and arg1_6.KeyCode == Enum.KeyCode.G and UserInputService_upvr:IsKeyDown(Enum.KeyCode.LeftShift) and arg1.state.inVehicle then
                arg1:setState({
                    speedometerEnabled = not arg1.state.speedometerEnabled;
                })
            end
        end))
    end
    arg1._maid:GiveTask(VehicleUtils_upvr.OnVehicleEntered:Connect(function(arg1_7, arg2) -- Line 182
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        if not arg2 then
            if arg1.state.garageVisible then
                arg1_7.LockMovement = true
            end
            store_upvr:dispatch({
                type = "setInVehicle";
                inVehicle = true;
            })
            local tbl_10 = {
                type = "setLocalVehiclePacket";
            }
            tbl_10.packet = arg1_7
            store_upvr:dispatch(tbl_10)
            arg1:setState({
                inVehicle = true;
            })
            arg1_7.seatMaid:GiveTask(function() -- Line 200
                store_upvr:dispatch({
                    type = "setInVehicle";
                    inVehicle = false;
                })
                arg1:setState({
                    inVehicle = false;
                    garageVisible = false;
                })
            end)
            local BoundingBox_upvr_2 = arg1_7.Model:FindFirstChild("BoundingBox")
            local var118
            if BoundingBox_upvr_2 then
                if not tbl_15_upvr:getValue() then
                    HotbarSystem_upvr.hide()
                end
                arg1_7.seatMaid:GiveTask(function() -- Line 216
                    if not tbl_15_upvr:getValue() then
                        HotbarSystem_upvr.show()
                    end
                end)
                local tbl_11 = {}
                var118 = true
                tbl_11.speedometerEnabled = var118
                var118 = false
                tbl_11.hasLicensePlate = var118
                if arg1_7.Bombs or arg1_7.Rockets then
                    var118 = true
                else
                    var118 = false
                end
                tbl_11.missilesEnabled = var118
                if arg1_7.Make == "Bionic" then
                else
                end
                tbl_11.speedometerSmallUI = false
                arg1:setState(tbl_11)
                arg1_7.seatMaid:GiveTask(function() -- Line 227
                    arg1:setState({
                        speedometerEnabled = false;
                        licensePromptEnabled = false;
                    })
                end)
                arg1._updateSpdDistance(0)
                VehicleUtils_upvr.updateSpdBarRatio(0)
                VehicleUtils_upvr._forceUpdateNitroBar = true
                arg1_7.seatMaid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 236
                    local absolute = math.abs(BoundingBox_upvr_2.Velocity:Dot(BoundingBox_upvr_2.CFrame.LookVector))
                    local any_sToH_result1_2 = SpeedometerUtils_upvr.sToH(SpeedometerUtils_upvr.studsToMi(absolute))
                    VehicleUtils_upvr.LastMPHClient = any_sToH_result1_2
                    arg1._updateSpdSpeed(any_sToH_result1_2)
                    if arg1_7.rpmVisual and arg1_7.rpmVisualMax then
                        arg1._updateSpdAccelRatio(arg1_7.rpmVisual / arg1_7.rpmVisualMax)
                    else
                        arg1._updateSpdAccelRatio(absolute / 100)
                    end
                end))
                local PlayerGui = Players_upvr.LocalPlayer:FindFirstChild("PlayerGui")
                if PlayerGui then
                    arg1_7.seatMaid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(PlayerGui:FindFirstChild("MapMakeOdometer"), arg1_7.Make, function(arg1_12, arg2_3) -- Line 256
                        arg1._updateSpdDistance(SpeedometerUtils_upvr.studsToMi(arg1_12.Value))
                        arg2_3:GiveTask(arg1_12.Changed:Connect(function(arg1_13) -- Line 258
                            arg1._updateSpdDistance(SpeedometerUtils_upvr.studsToMi(arg1_13))
                        end))
                    end))
                end
                local tbl_25 = {}
                if arg1_7.Model:GetAttribute("Locked") ~= true then
                else
                end
                tbl_25.vehicleLocked = true
                tbl_25.speedometerLockEnabled = VehicleUtils_upvr.canLocalLock()
                arg1:setState(tbl_25)
                arg1_7.seatMaid:GiveTask(arg1_7.Model:GetAttributeChangedSignal("Locked"):Connect(function() -- Line 267, Named "updateLocked"
                    local tbl_3 = {}
                    local var130
                    if arg1_7.Model:GetAttribute("Locked") ~= true then
                        var130 = false
                    else
                        var130 = true
                    end
                    tbl_3.vehicleLocked = var130
                    var130 = VehicleUtils_upvr
                    var130 = var130.canLocalLock()
                    tbl_3.speedometerLockEnabled = var130
                    arg1:setState(tbl_3)
                end))
                local function updatePassengers() -- Line 277
                    local any_map_result1 = TableUtils_upvr.map(TableUtils_upvr.filter(VehicleUtils_upvr.getSeats(arg1_7.Model), function(arg1_14) -- Line 279
                        local var133
                        if arg1_14.Player == Players_upvr.LocalPlayer then
                            var133 = false
                        else
                            var133 = true
                        end
                        return var133
                    end), function(arg1_15) -- Line 282
                        return arg1_15.Player
                    end)
                    local tbl_22 = {
                        passengers = any_map_result1;
                    }
                    local var137 = false
                    if 0 < #any_map_result1 then
                        var137 = VehicleUtils_upvr
                        var137 = var137.canLocalEject()
                    end
                    tbl_22.speedometerEjectEnabled = var137
                    arg1:setState(tbl_22)
                end
                updatePassengers()
                for i_upvr, v in ipairs(arg1_7.Model:GetChildren()) do
                    if v.Name == "Seat" or v.Name == "Passenger" then
                        arg1_7.seatMaid:GiveTask(v:FindFirstChild("PlayerName").Changed:Connect(updatePassengers))
                    end
                end
                if arg1_7.Model:FindFirstChild("Model") then
                    i_upvr = "plate"
                    local SOME_3 = arg1_7.Model:FindFirstChild("Model"):FindFirstChild(i_upvr)
                    if SOME_3 then
                        v = "SurfaceGui"
                        if SOME_3:FindFirstChild(v) then
                            i_upvr = SOME_3:FindFirstChild(v).Frame
                            i_upvr = i_upvr.TextLabel
                            v = arg1
                            v = v:setState
                            v({
                                hasLicensePlate = true;
                                licensePlateText = i_upvr.Text;
                            })
                            v = arg1_7.seatMaid
                            v = v:GiveTask
                            v(i_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 311
                                arg1:setState({
                                    licensePlateText = i_upvr.Text;
                                })
                            end))
                        end
                    end
                end
                local function updateMissiles() -- Line 321
                    arg1:setState({
                        missileCount = Players_upvr.LocalPlayer:GetAttribute("MissileCount") or 0;
                        missileMax = arg1_7.Model:GetAttribute("MissileMax") or 0;
                    })
                end
                updateMissiles()
                arg1_7.seatMaid:GiveTask(Players_upvr.LocalPlayer:GetAttributeChangedSignal("MissileCount"):Connect(updateMissiles))
                arg1_7.seatMaid:GiveTask(arg1_7.Model:GetAttributeChangedSignal("MissileMax"):Connect(updateMissiles))
            end
        end
    end))
    arg1._maid:GiveTask(CCTVService_upvr.onRequestPrompt:Connect(function(arg1_16, arg2) -- Line 338
        if arg1_16 == nil then
        end
        local tbl_8 = {
            cctvViewerEnabled = true;
        }
        if arg2 then
        else
        end
        tbl_8.cctvViewerExpireDistance = 20
        arg1:setState(tbl_8)
    end))
    arg1.consoleRef = Roact_upvr.createRef()
    arg1.settingsRef = Roact_upvr.createRef()
    arg1._maid:GiveTask(SidebarUI_upvr.onDevPanelToggle:Connect(function() -- Line 350
        arg1:setState({
            devPanelVisible = not arg1.state.devPanelVisible;
            devPanelCurrentPage = arg1.settingsRef:getValue();
        })
    end))
    local function setGarageUIOpen_upvr(arg1_17) -- Line 356, Named "setGarageUIOpen"
        local var157
        if var157 then
            var157 = GarageUtils_upvr
            var157 = var157.hasPremium()
            if not var157 then
                var157 = GarageUtils_upvr
                var157 = var157.inPhysicalGarage()
            end
        end
        if arg1_17 then
            if var157 then
                local SOME_8 = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.LOAD_LAST_SELECTION_REMOTE_NAME)
                if SOME_8 then
                    SOME_8:FireServer()
                end
            end
            local any_getState_result1_2 = store_upvr:getState()
            local tbl_31 = {}
            local var161 = "setPage"
            tbl_31.type = var161
            if var157 then
                var161 = "Customize"
            else
                var161 = "Spawn"
            end
            tbl_31.pageName = var161
            tbl_31.categoryName = SaleConsts_upvr.CATEGORY_NAME
            tbl_31.sortId = any_getState_result1_2.garageSort
            tbl_31.garageOwned = any_getState_result1_2.garageOwned
            store_upvr:dispatch(tbl_31)
        end
        local tbl_29 = {}
        tbl_29.garageVisible = arg1_17
        arg1:setState(tbl_29)
    end
    local SOME_9_upvr = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.INFORM_UI_IS_OPEN_REMOTE_NAME)
    SOME_9_upvr.OnClientEvent:Connect(setGarageUIOpen_upvr)
    arg1._maid:GiveTask(SidebarUI_upvr.onGarageToggle:Connect(function() -- Line 382
        if not arg1.state.garageVisible then
            local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr.GetLocalVehiclePacket()
            if any_GetLocalVehiclePacket_result1 then
                if any_GetLocalVehiclePacket_result1.Passenger then
                    Notification_upvr.new({
                        Title = "Garage";
                        Text = "Cannot customize as passenger.";
                    })
                    return
                end
                if any_GetLocalVehiclePacket_result1.Model:GetAttribute("DisableGarage") then
                    Notification_upvr.new({
                        Text = "Garage disabled on this vehicle.";
                    })
                    return
                end
            end
        end
        SOME_9_upvr:FireServer(not arg1.state.garageVisible)
        setGarageUIOpen_upvr(not arg1.state.garageVisible)
    end))
    function arg1.onClickLeaveGarage() -- Line 400
        SOME_9_upvr:FireServer(false)
        arg1:setState({
            garageVisible = false;
        })
    end
    function arg1.onClickSpawnVehicle(arg1_18) -- Line 406
        local SOME_2 = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.SPAWN_VEHICLE_REMOTE_NAME)
        if SOME_2 then
            SOME_2:FireServer(arg1_18.vehicleType, arg1_18.vehicleMake)
        end
        arg1.onClickLeaveGarage()
    end
    function arg1.onAttemptPurchaseVehicle(arg1_19, arg2) -- Line 414
        if arg1_19.limited then
        else
            if arg2.locked then
                local any_new_result1_2 = Confirmation_upvr.new("You need the Pro Garage gamepass to buy this here. Otherwise, find it in the world and buy it there. Want to buy Pro Garage?")
                arg1:setState({
                    garageVisible = false;
                })
                any_new_result1_2.Maid:GiveTask(function() -- Line 427
                    arg1:setState({
                        garageVisible = true;
                    })
                end)
                any_new_result1_2.Maid:GiveTask(any_new_result1_2.OnYes:Connect(function() -- Line 432
                    arg1.onRequestPremiumUpgrade()
                end))
                return
            end
            local vehicleMake_upvr = arg1_19.vehicleMake
            local any_new_result1_3 = Confirmation_upvr.new("Purchase the "..ItemUtils_upvr.getTranslatedTitleFromItemTable(ItemUtils_upvr.createVehicleItemTable(vehicleMake_upvr)).." for $"..String_upvr.comma(arg1_19.price)..'?')
            arg1:setState({
                garageVisible = false;
            })
            any_new_result1_3.Maid:GiveTask(function() -- Line 446
                arg1:setState({
                    garageVisible = true;
                })
            end)
            any_new_result1_3.Maid:GiveTask(any_new_result1_3.OnYes:Connect(function() -- Line 451
                ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.PURCHASE_VEHICLE_REMOTE_NAME):FireServer(vehicleMake_upvr)
            end))
        end
    end
    function arg1.getRemainingDebounce() -- Line 455
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local any_getState_result1_3 = store_upvr:getState()
        local var186
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if Players_upvr.LocalPlayer:GetAttribute(GarageConsts_upvr_2.AERIAL_SPAWN_ATTR_NAME) then
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            var186 = GarageConsts_upvr
            var186 = var186.SPAWN_DEBOUNCE_PHYSICAL
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        elseif any_getState_result1_3.garagePremium then
            var186 = GarageConsts_upvr
            var186 = var186.SPAWN_DEBOUNCE_PREMIUM
        else
            var186 = GarageConsts_upvr
            var186 = var186.SPAWN_DEBOUNCE_NON_PREMIUM
        end
        do
            return (var186) - (workspace:GetServerTimeNow() - PlayerUtils_upvr.getLastVehicleSpawnedAt())
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    function arg1.onDeleteSlot(arg1_20) -- Line 470
        local any_new_result1 = Confirmation_upvr.new("Are you sure you want to delete this save slot?")
        arg1:setState({
            garageVisible = false;
        })
        any_new_result1.Maid:GiveTask(function() -- Line 477
            arg1:setState({
                garageVisible = true;
            })
        end)
        any_new_result1.Maid:GiveTask(any_new_result1.OnYes:Connect(function() -- Line 482
            local tbl_2 = {
                type = "deleteSaveSlot";
            }
            tbl_2.name = arg1_20
            store_upvr:dispatch(tbl_2)
        end))
    end
    function arg1.attemptEquipGarageItem(arg1_21, arg2) -- Line 490
        local SOME_7 = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.EQUIP_ITEM_REMOTE_NAME)
        if SOME_7 then
            SOME_7:FireServer(arg1_21, arg2)
        end
    end
    function arg1.attemptFavoriteGarageItem(arg1_22, arg2, arg3) -- Line 496
        local SOME_4 = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.UPDATE_FAVORITED_REMOTE_NAME)
        if SOME_4 then
            SOME_4:FireServer(arg1_22, arg2, arg3)
        end
    end
    function arg1.attemptBuyGarageItem(arg1_23, arg2) -- Line 502
        local SOME = ReplicatedStorage_upvr:FindFirstChild(GarageConsts_upvr_2.PURCHASE_ITEM_REMOTE_NAME)
        if SOME then
            SOME:FireServer(arg1_23, arg2)
        end
    end
    function arg1.notify(arg1_24) -- Line 508
        local tbl_4 = {}
        tbl_4.Text = arg1_24
        Notification_upvr.new(tbl_4)
    end
    function arg1.onRequestPremiumUpgrade() -- Line 511
        GamepassUtils_upvr.PromptGamepass(GamepassUtils_upvr.EnumGamepass.PremiumGarage)
    end
    function arg1.garagePromptCashPurchase() -- Line 514
        arg1.onClickLeaveGarage()
        CashBuyUI_upvr.Open()
    end
    arg1.minimapBaseProps = {
        mapImageColor3 = MinimapService_upvr.mapImageColor3;
        mapImageId = arg1.props.mapImageId;
        mapWorldWidth = arg1.props.mapWorldWidth;
        mapWorldHeight = arg1.props.mapWorldHeight;
        mapWorldCenterX = arg1.props.mapWorldCenterX;
        mapWorldCenterY = arg1.props.mapWorldCenterY;
        mapImageWidth = arg1.props.mapImageWidth;
        mapImageHeight = arg1.props.mapImageHeight;
        worldPosition = MinimapService_upvr.mapWorldPosition;
        worldDirection = MinimapService_upvr.mapWorldDirection;
    }
    function arg1.minimapOnToggle() -- Line 531
        arg1:setState({
            minimapOpen = not arg1.state.minimapOpen;
        })
    end
    function arg1.megamapOnToggle() -- Line 536
        arg1:setState({
            megamapOpen = not arg1.state.megamapOpen;
        })
    end
    if RunUtils_upvr.isMainWorld() then
        store_upvr:dispatch({
            type = "addMinimapLabels";
            labels = {{
                title = "TOWN";
                position = Vector3.new(621.013, 27.5249, -1267.4);
            }, {
                title = "PRISON";
                position = Vector3.new(-1315.3, 14.6840, -1675.2);
            }, {
                title = "RISING CITY";
                position = Vector3.new(26.5249, 14.9200, 1059.65);
            }, {
                title = "CRIME PORT";
                position = Vector3.new(-450.30, 66.2979, 2057.05);
            }, {
                title = "VOLCANO";
                position = Vector3.new(2163.95, 61.5509, -2597.8);
            }, {
                title = "CRATER CITY";
                position = Vector3.new(-403.71, 40.2350, -5835.2);
            }, {
                title = "TRADE PORT";
                position = Vector3.new(2428.20, 20.7509, -3775.4);
            }};
        })
    end
    arg1._maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_25, arg2) -- Line 578
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    function arg1.onSpawnSelectionSpawnPressed(arg1_26) -- Line 593
        SpawnSelectionService_upvr.attemptSelect(arg1_26.name)
        GameUtil_upvr.removeDeathLighting()
    end
    function arg1.onSpawnSelectionShowSpawns() -- Line 597
        SpawnSelectionService_upvr.requestShowSpawns()
        GameUtil_upvr.removeDeathGui()
    end
    local tbl_14 = {
        name = "showTooltips";
        title = "Show Tooltips";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = true;
        order = 52;
    }
    GameSettingsService_upvr.add(tbl_14)
    store_upvr:dispatch({
        type = "setTooltipVisible";
        value = tbl_14:getValue();
    })
    tbl_14.onChanged:Connect(function(arg1_27) -- Line 610, Named "handleTooltips"
        local tbl_24 = {
            type = "setTooltipVisible";
        }
        tbl_24.value = arg1_27
        store_upvr:dispatch(tbl_24)
    end)
end
local Runtime_upvr = require(ReplicatedStorage_upvr.ActionButton.UI.Runtime)
local Bounty_upvr = require(ReplicatedStorage_upvr.App.UI.Bounty)
local MinimapRodux_upvr = require(ReplicatedStorage_upvr.App.UI.MinimapRodux)
local Dictionary_upvr = require(ReplicatedStorage_upvr.EzUi.Dictionary)
local InputUtils_upvr = require(ReplicatedStorage_upvr.Std.InputUtils)
local SidebarHolder_upvr = require(ReplicatedStorage_upvr.App.UI.SidebarHolder)
local BigButtonService_upvr = require(ReplicatedStorage_upvr.App.BigButtonService)
local BigMinimap_upvr = require(ReplicatedStorage_upvr.App.UI.BigMinimap)
local CenterMessage_upvr = require(ReplicatedStorage_upvr.App.UI.CenterMessage)
local TrackService_upvr = require(ReplicatedStorage_upvr.RaceTrack.TrackService)
local LikePromptRodux_upvr = require(ReplicatedStorage_upvr.LikePrompt.UI.LikePromptRodux)
local TooltipRodux_upvr = require(ReplicatedStorage_upvr.Tooltip.UI.TooltipRodux)
local Speedometer_upvr = require(ReplicatedStorage_upvr.Speedometer.UI.Speedometer)
local LicensePlate_upvr = require(ReplicatedStorage_upvr.Speedometer.UI.LicensePlate)
local Viewer_upvr = require(ReplicatedStorage_upvr.CCTV.UI.Viewer)
local TabContainer_upvr = require(ReplicatedStorage_upvr.EzUi.TabContainer)
local Garage_upvr = require(ReplicatedStorage_upvr.Garage.UI.Garage)
local CasinoKeypad_upvr = require(ReplicatedStorage_upvr.Casino.UI.CasinoKeypad)
local DamageIndicators_upvr = require(ReplicatedStorage_upvr.DamageIndicator.UI.DamageIndicators)
local Trade_upvr = require(ReplicatedStorage_upvr.Trade.UI.Trade)
local TradeInitiations_upvr = require(ReplicatedStorage_upvr.Trade.UI.TradeInitiations)
local TradeResult_upvr = require(ReplicatedStorage_upvr.Trade.UI.TradeResult)
local RewardSpinner_upvr = require(ReplicatedStorage_upvr.RewardSpinner.UI.RewardSpinner)
local Safes_upvr = require(ReplicatedStorage_upvr.Safes.UI.Safes)
local SpawnSelection_upvr = require(ReplicatedStorage_upvr.SpawnSelection.UI.SpawnSelection)
local SpawnSelectionConsts_upvr = require(ReplicatedStorage_upvr.SpawnSelection.SpawnSelectionConsts)
local ChooseSpawn_upvr = require(ReplicatedStorage_upvr.SpawnSelection.UI.ChooseSpawn)
local OtherTradeServerListRodux_upvr = require(ReplicatedStorage_upvr.Trade.UI.OtherTradeServerListRodux)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
function any_extend_result1.render(arg1) -- Line 619
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.state.isSmallScreen then
        local tbl_5 = {
            Padding = createElement_upvr("UIPadding", {
                PaddingTop = UDim.new(0, 61);
            });
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Top;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Vertical;
                Padding = UDim.new(0, 8);
            });
        }
        local tbl_23 = {}
        local bounty = arg1.state.bounty
        tbl_23.amount = bounty
        if 0 >= arg1.state.bounty then
            bounty = false
        else
            bounty = true
        end
        tbl_23.enabled = bounty
        tbl_23.displayOrder = 2
        tbl_5.Bounty = createElement_upvr(Bounty_upvr, tbl_23)
        local tbl = {
            square = true;
            mapScale = 6;
            size = UDim2.new(0.9, 0, 0.9, 0);
            anchorPoint = Vector2.new(0.5, 0.5);
            isSmallScreen = arg1.state.isSmallScreen;
            color = arg1.state.teamColor;
        }
        local minimapOpen = arg1.state.minimapOpen
        if minimapOpen then
            minimapOpen = arg1.state
            minimapOpen = minimapOpen.controlsEnabled
        end
        tbl.open = minimapOpen
        tbl.showToggleButton = arg1.state.controlsEnabled
        tbl.time = SidebarUI_upvr.time
        tbl.displayOrder = 3
        tbl.onToggle = arg1.minimapOnToggle
        tbl.onClick = arg1.megamapOnToggle
        tbl_5.Minimap = createElement_upvr(MinimapRodux_upvr, Dictionary_upvr.merge(arg1.minimapBaseProps, tbl))
        ;({
            Controls = createElement_upvr(Runtime_upvr, {
                enabled = arg1.state.controlsEnabled;
                color = arg1.state.teamColor;
            });
        }).TopRight = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.1, 0, 1, 0);
            AnchorPoint = Vector2.new(1, 0);
            Position = UDim2.new(1, 0, 0, 0);
        }, tbl_5)
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 0.4, 0);
    }
    if InputUtils_upvr.isGamepad() then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local CmdrExtSystem_upvr = require(ReplicatedStorage_upvr.CmdrExt.CmdrExtSystem)
function any_extend_result1.didMount(arg1) -- Line 953
    arg1._maid:GivePromise(CmdrExtSystem_upvr.promiseCmdr():andThen(function(arg1_28, arg2) -- Line 954
        arg1.cmdr = arg1_28
        arg1.cmdrFrame = arg2
        arg2.Parent = arg1.consoleRef.current
        arg1_28:SetEnabled(true)
        arg1._maid:GiveTask(function() -- Line 960
            arg1_28:SetEnabled(false)
        end)
        arg1._maid:GiveTask(function() -- Line 963
            arg2.Parent = Players_upvr.LocalPlayer
        end)
        if arg1.state.devPanelVisible and arg1.state.devPanelCurrentPage == arg1.consoleRef:getValue() then
            arg1_28:Show()
        else
            arg1_28:Hide()
        end
        arg1._maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_29, arg2_4) -- Line 972
            if arg1_29.UserInputType == Enum.UserInputType.Keyboard and arg1_29.KeyCode == Enum.KeyCode.Backquote then
                if arg2_4 and not arg1.state.devPanelVisible then return end
                arg1:setState({
                    devPanelVisible = not arg1.state.devPanelVisible;
                    devPanelCurrentPage = arg1.consoleRef:getValue();
                })
            end
        end))
        arg1._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(ReplicatedStorage_upvr, "OpenCmdrMenu", function(arg1_30) -- Line 986
            arg1_30.OnClientEvent:Connect(function() -- Line 987
                arg1:setState({
                    devPanelVisible = true;
                    devPanelCurrentPage = arg1.consoleRef:getValue();
                })
            end)
        end))
    end))
end
local ActionButtonService_upvr = require(ReplicatedStorage_upvr.ActionButton.ActionButtonService)
local ChatUtils_upvr = require(ReplicatedStorage_upvr.Chat.ChatUtils)
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 997
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.state.devPanelCurrentPage ~= arg3.devPanelCurrentPage then
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1.state.devPanelVisible and arg1.state.devPanelCurrentPage == arg1.consoleRef:getValue() then
            if arg1.cmdr then
                arg1.cmdr:Show()
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        elseif arg1.cmdr then
            arg1.cmdr:Hide()
            if arg1.cmdrFrame then
                for _, v_2 in arg1.cmdrFrame:GetChildren() do
                    if v_2:IsA("TextBox") and v_2:IsFocused() then
                        v_2:ReleaseFocus()
                    end
                end
            end
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    if arg1.state.garageVisible ~= arg3.garageVisible then
        local any_GetLocalVehiclePacket_result1_2 = VehicleUtils_upvr.GetLocalVehiclePacket()
        if any_GetLocalVehiclePacket_result1_2 then
            any_GetLocalVehiclePacket_result1_2.LockMovement = arg1.state.garageVisible
        end
        if arg1.state.garageVisible then
            ActionButtonService_upvr.hide()
            ChatUtils_upvr.setEnabled(false)
            return
        end
        ActionButtonService_upvr.show()
        ChatUtils_upvr.setEnabled(true)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function any_extend_result1.willUnmount(arg1) -- Line 1034
    arg1._maid:DoCleaning()
end
Roact_upvr.mount(createElement_upvr("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ResetOnSpawn = false;
    IgnoreGuiInset = true;
    DisplayOrder = 8;
}, {createElement_upvr(any_extend_result1)}), Players_upvr.LocalPlayer.PlayerGui, "AppUI")
RxInstanceUtils_upvr.observeOneChildNamed(Players_upvr.LocalPlayer.PlayerGui, "TouchGui", function(arg1, arg2) -- Line 1050
    arg2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, "TouchControlFrame", function(arg1_31, arg2_5) -- Line 1055
        arg2_5:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_31, "JumpButton", function(arg1_32) -- Line 1057
            task.defer(arg1_32.Destroy, arg1_32)
        end))
    end))
end)