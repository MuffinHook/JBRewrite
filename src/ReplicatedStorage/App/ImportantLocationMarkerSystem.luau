local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local WorldMarkerGroup_upvr = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerGroup)
local WorldMarkerSystem_upvr = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local String_upvr = require(ReplicatedStorage.Std.String)
local WorldMarker_upvr = require(ReplicatedStorage.Game.WorldMarker.WorldMarker)
local Roact_upvr = require(ReplicatedStorage.Roact)
local store_upvr = require(ReplicatedStorage.App.store)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local gameSettingType_upvr = require(ReplicatedStorage.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage.GameSettings.GameSettingsService)
function module.init() -- Line 16
    local var14_upvw = true
    local tbl_2_upvr = {
        Gun = {
            ImageId = 15632538723;
            Color = Color3.fromRGB(141, 81, 255);
        };
        Garage = {
            ImageId = 117787277684275;
            Color = Color3.fromRGB(217, 66, 120);
        };
    }
    local any_new_result1_upvr = WorldMarkerGroup_upvr.new()
    WorldMarkerSystem_upvr.addGroup(any_new_result1_upvr)
    local tbl_3_upvr = {}
    tbl_3_upvr.__index = tbl_3_upvr
    setmetatable(tbl_3_upvr, BaseObject_upvr)
    function tbl_3_upvr.new(arg1) -- Line 30
        local any_new_result1 = BaseObject_upvr.new(arg1)
        setmetatable(any_new_result1, tbl_3_upvr)
        local var21 = tbl_2_upvr[arg1.Name]
        if not var21 then
            error("Missing important location marker entry for: %s":format(arg1.Name))
        end
        local ImageId = var21.ImageId
        local var23_upvr = arg1.Name..String_upvr.base85UUID(10)
        assert(ImageId)
        local any_new_result1_upvr_2 = WorldMarker_upvr.new()
        any_new_result1_upvr_2:SetScreenGui(WorldMarkerSystem_upvr.gui)
        any_new_result1_upvr_2:SetAdornee(arg1)
        any_new_result1_upvr_2:SetIcon(ImageId)
        any_new_result1_upvr_2.FrameInner.ImageColor3 = var21.Color
        any_new_result1_upvr:Add(any_new_result1_upvr_2)
        any_new_result1.maid:GiveTask(function() -- Line 48
            any_new_result1_upvr:Remove(any_new_result1_upvr_2)
        end)
        any_new_result1.worldMarker = any_new_result1_upvr_2
        local any_createBinding_result1, any_createBinding_result2_2_upvr = Roact_upvr.createBinding(any_new_result1_upvr_2:GetPosition())
        local any_createBinding_result1_2, any_createBinding_result2 = Roact_upvr.createBinding(var21.Color)
        store_upvr:dispatch({
            type = "addMinimapLabel";
            title = var23_upvr;
            imageId = ImageId;
            position = any_createBinding_result1;
            updatePosition = any_createBinding_result2_2_upvr;
            markerColor = any_createBinding_result1_2;
            updateMarkerColor = any_createBinding_result2;
        })
        any_new_result1_upvr_2._maid:GiveTask(function() -- Line 64
            store_upvr:dispatch({
                type = "removeMinimapLabel";
                title = var23_upvr;
            })
        end)
        any_new_result1_upvr_2._maid:GiveTask(Interval_upvr.every(0.3333333333333333):Connect(function() -- Line 70
            any_createBinding_result2_2_upvr(arg1.Position)
        end))
        any_new_result1_upvr_2:SetEnabled(var14_upvw)
        return any_new_result1
    end
    Binder_upvr.new("ImportantLocationMarker", tbl_3_upvr):Start()
    local function _() -- Line 81, Named "setEnabled"
        any_new_result1_upvr:SetEnabled(var14_upvw)
    end
    local tbl = {
        name = "locationMarkers";
        title = "Location Markers";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = true;
        order = 41;
    }
    GameSettingsService_upvr.add(tbl)
    var14_upvw = tbl:getValue()
    any_new_result1_upvr:SetEnabled(var14_upvw)
    tbl.onChanged:Connect(function(arg1) -- Line 93, Named "handleSetting"
        var14_upvw = arg1
        any_new_result1_upvr:SetEnabled(var14_upvw)
    end)
end
return module