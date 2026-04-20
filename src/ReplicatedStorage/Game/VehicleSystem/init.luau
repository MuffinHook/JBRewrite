local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local tbl_upvr_2 = {}
local tbl_upvr = {}
local function _(arg1) -- Line 23, Named "Isv2"
    local var6
    if arg1.Meta == nil then
        var6 = false
    else
        var6 = true
    end
    return var6
end
local tbl_upvr_3 = {}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local StreamingHelperUtils_upvr = require(ReplicatedStorage.App.StreamingHelperUtils)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local function GetVehiclePacket_upvr(arg1) -- Line 208, Named "GetVehiclePacket"
    for i_5 = 1, #tbl_upvr_2 do
        local var52 = tbl_upvr_2[i_5]
        for i_6 = 1, #var52.Seats do
            local var53 = var52.Seats[i_6]
            if var53.Occupied and var53.Player == arg1 then
                return var52, var53
            end
        end
    end
    return nil
end
return {
    Init = function(arg1) -- Line 26, Named "Init"
        local function DeepTransfer_upvr(arg1_2, arg2) -- Line 31, Named "DeepTransfer"
            for i, v in next, arg1_2 do
                if type(v) == "table" then
                    DeepTransfer_upvr(v, arg2)
                else
                    arg2[i] = v
                end
            end
        end
        local function ProcessPacket_upvr(arg1_3) -- Line 41, Named "ProcessPacket"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            assert(arg1_3)
            local Id = arg1_3.Id
            assert(Id)
            local var25_upvw
            if tbl_upvr_3[Id] == nil then
                local var26 = tbl_upvr[var25_upvw.ClassName]
                if var26 == nil then
                    error("No vehicle module has been registered for class name: "..var25_upvw.ClassName)
                end
                if var26.FromPacket then
                    var26.FromPacket(var25_upvw)
                else
                    var25_upvw = var26.new(var25_upvw)
                end
                if var25_upvw.Maid == nil then
                    warn("No maid for vehicle packet", var25_upvw)
                end
                assert(var25_upvw.Seats, "Vehicle needs seats")
                for _, v_2_upvr in var25_upvw.Seats do
                    local PlayerName_upvr = v_2_upvr.Part:WaitForChild("PlayerName")
                    v_2_upvr.Occupied = false
                    v_2_upvr.Maid = Maid_upvr.new()
                    local function update() -- Line 70
                        local SOME = Players_upvr:FindFirstChild(PlayerName_upvr.Value)
                        local var29
                        if SOME == nil then
                            var29 = false
                        else
                            var29 = true
                        end
                        if var29 then
                            v_2_upvr.Player = SOME
                            v_2_upvr.Occupied = var29
                            v_2_upvr.Maid:DoCleaning()
                        end
                        if var29 ~= v_2_upvr.Occupied then
                            if var29 then
                                var25_upvw:MountPlayer(v_2_upvr.Player, v_2_upvr)
                            else
                                var25_upvw:UnmountSeat(v_2_upvr)
                            end
                        end
                        if not var29 then
                            v_2_upvr.Player = SOME
                            v_2_upvr.Occupied = var29
                            v_2_upvr.Maid:DoCleaning()
                        end
                    end
                    update()
                    var25_upvw.Maid:GiveTask(PlayerName_upvr.Changed:Connect(update))
                    local _
                end
                table.insert(tbl_upvr_2, var25_upvw)
                tbl_upvr_3[Id] = var25_upvw
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            if tbl_upvr_3[Id].Meta == nil then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        local function removeIdFromList_upvr(arg1_4) -- Line 113, Named "removeIdFromList"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            for i_3 = #tbl_upvr_2, 1, -1 do
                local var39 = tbl_upvr_2[i_3]
                local var40
                if var39.Meta == nil then
                    var40 = false
                else
                    var40 = true
                end
                if var40 then
                    var40 = var39.Meta
                    local _ = var40.Id
                else
                end
                var40 = assert
                var40(var39.Id)
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if var39.Id == arg1_4 then
                    var40 = tbl_upvr_3
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    var40[var39.Id] = nil
                    var40 = table.remove
                    var40(tbl_upvr_2, i_3)
                    var40 = var39.Seats
                    if var40 then
                        var40 = #var39.Seats
                        for i_4 = 1, var40 do
                            local var42 = var39.Seats[i_4]
                            if var42.Occupied then
                                var39:UnmountSeat(var42)
                                var42.Maid:DoCleaning()
                            end
                        end
                    end
                    var40 = var39:Destroy
                    var40()
                end
            end
        end
        Binder_upvr.new("VehicleSystemPacket", function(arg1_5) -- Line 140
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            task.wait()
            local any_new_result1 = Maid_upvr.new()
            StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1_5)
            local any_createTableFromObjectValues_result1_upvr = TableUtils_upvr.createTableFromObjectValues(arg1_5)
            local create
            if any_createTableFromObjectValues_result1_upvr.Meta == nil then
                create = false
            else
                create = true
            end
            if create then
                create = any_createTableFromObjectValues_result1_upvr.Meta
            else
            end
            function create() -- Line 154
                ProcessPacket_upvr(any_createTableFromObjectValues_result1_upvr)
            end
            local Id_upvw = any_createTableFromObjectValues_result1_upvr.Id
            local function destroy_upvr() -- Line 157, Named "destroy"
                removeIdFromList_upvr(Id_upvw)
            end
            any_new_result1:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(any_createTableFromObjectValues_result1_upvr.Model, "BoundingBox", function(arg1_6, arg2) -- Line 161
                ProcessPacket_upvr(any_createTableFromObjectValues_result1_upvr)
                arg2:GiveTask(destroy_upvr)
            end))
            return any_new_result1
        end):Start()
        arg1.em.ugi9mg46 = function(arg1_7) -- Line 169, Named "ugi9mg46"
            local var49 = tbl_upvr_3[arg1_7]
            assert(var49)
            var49:FollowPlayer(LocalPlayer_upvr)
        end
    end;
    RegisterModule = function(arg1) -- Line 19, Named "RegisterModule"
        local var5
        if arg1.__ClassName == nil then
            var5 = false
        else
            var5 = true
        end
        assert(var5)
        var5 = arg1.__ClassName
        tbl_upvr[var5] = arg1
    end;
    GetVehiclePacket = GetVehiclePacket_upvr;
    WaitForVehiclePacket = function(arg1) -- Line 220, Named "WaitForVehiclePacket"
        while os.clock() - os.clock() < 5 do
            local GetVehiclePacket_upvr_result1, GetVehiclePacket_upvr_result2 = GetVehiclePacket_upvr(arg1)
            if GetVehiclePacket_upvr_result1 ~= nil then
                return GetVehiclePacket_upvr_result1, GetVehiclePacket_upvr_result2
            end
            task.wait()
        end
        return nil
    end;
    GetPlayerSeat = function(arg1, arg2) -- Line 231, Named "GetPlayerSeat"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        for i_7 = 1, #arg1.Seats do
            local var58 = arg1.Seats[i_7]
            if var58.Occupied and var58.Player == arg2 then
                return var58
            end
        end
        return nil
    end;
}