local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_upvr.new(arg1) -- Line 13
    assert(arg1)
    local module = {}
    setmetatable(module, module_upvr)
    module.Gui = arg1
    module.Maid = Maid_upvr.new()
    module.OnRefreshRequested = Signal_upvr.new()
    module.Maid:GiveTask(module.OnRefreshRequested)
    module.ListItem = {}
    return module
end
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local RadioPlayer_upvr = require(script.Parent.RadioPlayer)
local RadioUtils_upvr = require(script.Parent.RadioUtils)
function module_upvr.Populate(arg1, arg2) -- Line 26
    assert(arg2)
    local ScrollingFrame_upvr = arg1.Gui.Container.Sidebar.ScrollingFrame
    arg1.Maid:GiveTask(ScrollingFrame_upvr.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line 29
        ScrollingFrame_upvr.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame_upvr.UIListLayout.AbsoluteContentSize.Y)
    end))
    for i_upvr, var35_upvr in ipairs(arg2.Songs) do
        local clone_upvr = ScrollingFrame_upvr.ItemPreset:Clone()
        clone_upvr.Name = var35_upvr.AssetId
        local var23
        if not var23 then
            var23 = tostring(var35_upvr.AssetId)
        end
        clone_upvr.Title.Text = var23
        if var35_upvr.Name == nil then
            var23 = Promise_upvr
            var23 = var23.resolve()
            var23 = var23:andThen(function() -- Line 40
                return MarketplaceService_upvr:GetProductInfo(var35_upvr.AssetId)
            end)
            var23 = var23:andThen(function(arg1_2) -- Line 43
                var35_upvr.Name = tostring(arg1_2.Name)
                clone_upvr.Title.Text = var35_upvr.Name
            end)
            local var27_upvw
            var23 = var23:finally(function() -- Line 47
                if var27_upvw then
                    var27_upvw:cancel()
                end
            end)
            var27_upvw = var23
            var23 = arg1.Maid
            var23:GiveTask(function() -- Line 52
                if var27_upvw then
                    var27_upvw:cancel()
                end
            end)
        end
        clone_upvr.Visible = true
        clone_upvr.Parent = ScrollingFrame_upvr
        clone_upvr.LayoutOrder = i_upvr
        arg1.Maid:GiveTask(clone_upvr.Play.MouseButton1Down:Connect(function() -- Line 61
            local any_GetLocalVehiclePacket_result1_2 = VehicleUtils_upvr.GetLocalVehiclePacket()
            local any_IsPlayingThirdPerson_result1 = RadioPlayer_upvr.IsPlayingThirdPerson()
            if not any_IsPlayingThirdPerson_result1 then
                any_IsPlayingThirdPerson_result1 = false
                if any_GetLocalVehiclePacket_result1_2 ~= nil then
                    any_IsPlayingThirdPerson_result1 = not any_GetLocalVehiclePacket_result1_2.Passenger
                end
            end
            RadioPlayer_upvr.PlayId(var35_upvr.AssetId, nil, any_IsPlayingThirdPerson_result1)
        end))
        var23 = arg2.Editable
        clone_upvr.Delete.Visible = var23
        if arg2.Editable then
            arg1.Maid:GiveTask(clone_upvr.Delete.MouseButton1Down:Connect(function() -- Line 71
                table.remove(arg2.Songs, i_upvr)
                arg1.OnRefreshRequested:Fire()
                RadioPlayer_upvr.OnPlaylistUpdated:Fire(arg2)
            end))
        end
        arg1.Maid:GiveTask(clone_upvr)
        if #arg1.ListItem ~= i_upvr - 1 then
            var23 = false
        else
            var23 = true
        end
        assert(var23)
        var23 = arg1.ListItem
        table.insert(var23, clone_upvr)
    end
    if arg2.Editable then
        i_upvr = arg2.Songs
        ScrollingFrame_upvr.NewSong.LayoutOrder = #i_upvr + 1
        function var35_upvr() -- Line 83
            if RadioPlayer_upvr.CurrentSound == nil then
                error("Attempted to add song when no song is playing!")
            end
            for _, v_2 in ipairs(arg2.Songs) do
                if v_2.AssetId == RadioPlayer_upvr.CurrentSoundId then
                    error("Attempted to add repeat song to playlist.")
                end
            end
            if not RadioUtils_upvr.CheckOrPromptStereoGamepass() then
                return false
            end
            local tbl = {}
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            tbl.AssetId = RadioPlayer_upvr.CurrentSoundId
            table.insert(arg2.Songs, tbl)
            arg1.OnRefreshRequested:Fire()
            RadioPlayer_upvr.OnPlaylistUpdated:Fire(arg2)
        end
        arg1.Maid:GiveTask(ScrollingFrame_upvr.NewSong.Add.MouseButton1Down:Connect(var35_upvr))
    end
    ScrollingFrame_upvr.NewSong.Visible = arg2.Editable
end
function module_upvr.Destroy(arg1) -- Line 105
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr
