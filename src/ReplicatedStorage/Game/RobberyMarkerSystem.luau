local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RobberyConsts_upvr = require(ReplicatedStorage_upvr.Robbery.RobberyConsts)
local module_upvr = {}
local tbl_upvr = {
    [RobberyConsts_upvr.ENUM_ROBBERY.MONEY_TRUCK] = require(ReplicatedStorage_upvr.Resource.Settings).EnumTeam.Police;
}
local tbl_upvr_2 = {
    [RobberyConsts_upvr.ENUM_ROBBERY.MONEY_TRUCK] = true;
}
module_upvr._enabled = true
local WorldMarkerGroup_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerGroup)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local PlayerUtils_upvr = require(script.Parent.PlayerUtils)
local Players_upvr = game:GetService("Players")
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local RunService_upvr = game:GetService("RunService")
local WorldMarker_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarker)
local WorldMarkerSystem_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerSystem)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local ROBBERY_STATE_FOLDER_NAME_upvr = RobberyConsts_upvr.ROBBERY_STATE_FOLDER_NAME
local CollectionService_upvr = game:GetService("CollectionService")
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local gameSettingType_upvr = require(ReplicatedStorage_upvr.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage_upvr.GameSettings.GameSettingsService)
local GameUtil_upvr = require(script.Parent.GameUtil)
function module_upvr.init() -- Line 29
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tbl_6_upvr = {}
    for _, v in ipairs(RobberyConsts_upvr.LIST_ROBBERY) do
        local var44 = RobberyConsts_upvr.ENUM_ROBBERY[v]
        local var45 = RobberyConsts_upvr.DATA_ROBBERY[var44]
        if var45.markerName then
            local tbl_3 = {
                RobberyId = var44;
                Name = assert(var45.markerName, "missing markerName");
                ImageId = assert(var45.imageId, "missing imageId");
                _stateId = RobberyConsts_upvr.ENUM_STATUS.CLOSED;
                _stateIncr = 0;
            }
            tbl_6_upvr[tbl_3.Name] = tbl_3
            ;({})[tbl_3.RobberyId] = tbl_3
        end
    end
    local any_new_result1_upvr = WorldMarkerGroup_upvr.new()
    local tbl_2_upvr = {}
    local os_clock_result1_upvr = os.clock()
    local function setRobberyMarkerState_upvr(arg1, arg2) -- Line 51, Named "setRobberyMarkerState"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local var54 = tbl_2_upvr[arg1]
        local var55
        if not var54 then return end
        var54._stateIncr += 1
        local _listWorldMarker = var54._listWorldMarker
        if not _listWorldMarker then return end
        for _, v_2 in pairs(_listWorldMarker) do
            if v_2._maid.robberyMarkerFx ~= nil then
                v_2._maid.robberyMarkerFx = nil
                var55 = 0
                v_2.Frame.ImageColor3 = Color3.new(var55, 0, 0)
            end
        end
        local ipairs_result1, ipairs_result2, ipairs_result3 = ipairs(store_upvr:getState().minimapLabels)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [61.2147483650]
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    for _, v_3 in ipairs(CollectionService_upvr:GetTagged("RobberyMarker")) do
        (function(arg1) -- Line 155, Named "addRobberyMarker"
            local var78 = tbl_6_upvr[arg1.Name]
            if not var78 then
                error("Missing robbery marker entry for: %s":format(arg1.Name))
            end
            local ImageId_2 = var78.ImageId
            assert(ImageId_2)
            local any_new_result1_2 = WorldMarker_upvr.new()
            any_new_result1_2:SetScreenGui(WorldMarkerSystem_upvr.gui)
            any_new_result1_2:SetAdornee(arg1)
            any_new_result1_2:SetIcon(ImageId_2, Color3.fromRGB(0, 0, 0))
            any_new_result1_2.FrameInner.ImageColor3 = Color3.new(1, 0, 0)
            if not var78._listWorldMarker then
                var78._listWorldMarker = {any_new_result1_2}
            else
                table.insert(var78._listWorldMarker, any_new_result1_2)
            end
            any_new_result1_upvr:Add(any_new_result1_2)
            local any_createBinding_result1_3, any_createBinding_result2_3_upvr = Roact_upvr.createBinding(any_new_result1_2:GetPosition())
            local any_createBinding_result1_2, any_createBinding_result2_2 = Roact_upvr.createBinding(Color3.new(1, 0, 0))
            store_upvr:dispatch({
                type = "addMinimapLabel";
                title = arg1.Name;
                imageId = ImageId_2;
                position = any_createBinding_result1_3;
                updatePosition = any_createBinding_result2_3_upvr;
                markerColor = any_createBinding_result1_2;
                updateMarkerColor = any_createBinding_result2_2;
            })
            any_new_result1_2._maid:GiveTask(function() -- Line 187
                store_upvr:dispatch({
                    type = "removeMinimapLabel";
                    title = arg1.Name;
                })
            end)
            any_new_result1_2._maid:GiveTask(Interval_upvr.every(0.3333333333333333):Connect(function() -- Line 193
                any_createBinding_result2_3_upvr(arg1.Position)
            end))
            local SOME = ReplicatedStorage_upvr:FindFirstChild(ROBBERY_STATE_FOLDER_NAME_upvr)
            local var91 = false
            if SOME then
                local SOME_4 = SOME:FindFirstChild(var78.RobberyId)
                if SOME_4 and setRobberyMarkerState_upvr(tonumber(SOME_4.Name), SOME_4.Value) == true then
                    var91 = true
                end
            end
            if not var91 then
                any_new_result1_2:SetEnabled(false)
            end
        end)(v_3)
        local var96
    end
    CollectionService_upvr:GetInstanceAddedSignal("RobberyMarker"):Connect(var96)
    CollectionService_upvr:GetInstanceRemovedSignal("RobberyMarker"):Connect(function(arg1) -- Line 221, Named "cleanupAfterRobberyMarker"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local _ = #tbl_6_upvr[arg1.Name]._listWorldMarker
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.6]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.65666]
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    WorldMarkerSystem_upvr.addGroup(any_new_result1_upvr)
    RxInstanceUtils_upvr.waitForChild(ReplicatedStorage_upvr, ROBBERY_STATE_FOLDER_NAME_upvr):andThen(function(arg1) -- Line 242
        RxInstanceUtils_upvr.observeChildren(arg1, function(arg1_2, arg2) -- Line 243
            local tonumber_result1_upvr = tonumber(arg1_2.Name)
            assert(tonumber_result1_upvr)
            arg2:GiveTask(arg1_2.Changed:Connect(function(arg1_3) -- Line 246, Named "update"
                local var102 = arg1_3
                assert(var102)
                if typeof(arg1_3) ~= "number" then
                    var102 = false
                else
                    var102 = true
                end
                assert(var102)
                setRobberyMarkerState_upvr(tonumber_result1_upvr, arg1_3)
            end))
            local Value = arg1_2.Value
            local var104 = Value
            assert(var104)
            if typeof(Value) ~= "number" then
                var104 = false
            else
                var104 = true
            end
            assert(var104)
            setRobberyMarkerState_upvr(tonumber_result1_upvr, Value)
        end)
    end)
    local function updateAllRobberyStatus_upvr() -- Line 256, Named "updateAllRobberyStatus"
        local SOME_2 = ReplicatedStorage_upvr:FindFirstChild(ROBBERY_STATE_FOLDER_NAME_upvr)
        if not SOME_2 then
        else
            for _, v_4 in SOME_2:GetChildren() do
                local tonumber_result1 = tonumber(v_4.Name)
                assert(tonumber_result1)
                setRobberyMarkerState_upvr(tonumber_result1, v_4.Value)
            end
        end
    end
    local tbl_4 = {
        name = "robberyMarkers";
        title = "Robbery Markers";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = true;
        order = 41;
    }
    GameSettingsService_upvr.add(tbl_4)
    module_upvr._enabled = tbl_4:getValue()
    updateAllRobberyStatus_upvr()
    tbl_4.onChanged:Connect(function(arg1) -- Line 277, Named "handleSetting"
        module_upvr._enabled = arg1
        updateAllRobberyStatus_upvr()
    end)
    GameUtil_upvr.OnTeamChanged:Connect(updateAllRobberyStatus_upvr)
end
return module_upvr