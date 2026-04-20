local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local TrackService_upvr = require(ReplicatedStorage.RaceTrack.TrackService)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
RxInstanceUtils_upvr.waitForChild(ReplicatedStorage, "RaceTrackScreenText"):andThen(function(arg1) -- Line 14
    local var12_upvw
    arg1.OnClientEvent:Connect(function(arg1_2) -- Line 16
        TrackService_upvr.updateScreenText(arg1_2)
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6874682609, {
            Volume = 0.8;
        })
        if var12_upvw then
            var12_upvw:cancel()
            var12_upvw = nil
        end
        var12_upvw = Promise_upvr.delay(3):andThen(function() -- Line 24
            TrackService_upvr.updateScreenText("")
        end)
    end)
end)
local any_extend_result1_upvr = Roact_upvr.PureComponent:extend("Board")
function any_extend_result1_upvr.init(arg1) -- Line 31
    arg1._maid = Maid_upvr.new()
end
function any_extend_result1_upvr._fetch(arg1) -- Line 34
    arg1:setState({
        numEntries = #arg1.props.dataFolder:GetChildren();
    })
end
function any_extend_result1_upvr.didMount(arg1) -- Line 39
    arg1:_fetch()
    arg1._maid:GiveTask(arg1.props.dataFolder.ChildAdded:Connect(function() -- Line 41
        arg1:_fetch()
    end))
    arg1._maid:GiveTask(arg1.props.dataFolder.ChildRemoved:Connect(function() -- Line 44
        arg1:_fetch()
    end))
end
local Board_upvr = require(ReplicatedStorage.RaceTrack.UI.Board)
function any_extend_result1_upvr.render(arg1) -- Line 48
    local tbl_3 = {}
    for _, v in ipairs(arg1.props.dataFolder:GetChildren()) do
        local var28 = "Time"
        local attribute = v:GetAttribute(var28)
        if typeof(attribute) ~= "number" then
            var28 = false
        else
            var28 = true
        end
        assert(var28, "time was not a number")
        table.insert(tbl_3, {
            name = v.Value;
            userId = tonumber(v.Name);
            time = attribute;
            message = "%d:%02d.%03d":format(math.floor(attribute % 3600000 / 60000), math.floor(attribute % 60000 / 1000), math.floor(attribute % 1000));
        })
    end
    table.sort(tbl_3, function(arg1_3, arg2) -- Line 64
        local var32
        if arg1_3.time >= arg2.time then
            var32 = false
        else
            var32 = true
        end
        return var32
    end)
    return createElement_upvr("SurfaceGui", {
        ResetOnSpawn = false;
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        PixelsPerStud = 80;
        Adornee = arg1.props.adornee;
    }, {
        Board = createElement_upvr(Board_upvr, {
            entries = tbl_3;
        });
    })
end
function any_extend_result1_upvr.willUnmount(arg1) -- Line 79
    arg1._maid:DoCleaning()
end
local tbl_2_upvr = {}
tbl_2_upvr.__index = tbl_2_upvr
function tbl_2_upvr.new(arg1) -- Line 86
    local module = {}
    setmetatable(module, tbl_2_upvr)
    module._maid = Maid_upvr.new()
    module._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1.Parent.Parent, "Data", function(arg1_4, arg2) -- Line 91
        local tbl = {}
        tbl.adornee = arg1
        tbl.dataFolder = arg1_4
        local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(any_extend_result1_upvr, tbl), Players_upvr.LocalPlayer.PlayerGui, "BoardGui")
        arg2:GiveTask(function() -- Line 101
            Roact_upvr.unmount(any_mount_result1_upvr)
        end)
    end))
    return module
end
function tbl_2_upvr.Destroy(arg1) -- Line 108
    arg1._maid:Destroy()
end
require(ReplicatedStorage.Std.Binder).new("RaceTrackBoard", tbl_2_upvr):Start()