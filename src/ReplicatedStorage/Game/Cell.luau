local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
local InventoryItemBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local InventoryItemSystem_upvr = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local var6_upvw
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local var8_upvw
local tbl_upvr = {}
local function ShowFun_upvr(arg1) -- Line 32, Named "ShowFun"
    local ValidRoot_3 = arg1.ValidRoot
    ValidRoot_3:SetPrimaryPartCFrame(tbl_upvr[ValidRoot_3.Drawer].Opened)
end
local function HideFun_upvr(arg1) -- Line 38, Named "HideFun"
    local ValidRoot = arg1.ValidRoot
    ValidRoot:SetPrimaryPartCFrame(tbl_upvr[ValidRoot.Drawer].Closed)
end
local var12_upvw = 0
local function Update_upvr(arg1) -- Line 44, Named "Update"
    local tick_result1_2 = tick()
    local var14
    if tick_result1_2 - var12_upvw < 0.1 then
    else
        var12_upvw = tick_result1_2
        local _1 = InventoryItemSystem_upvr.getEquippedFor(LocalPlayer_upvr)[1]
        local ValidRoot_2 = arg1.ValidRoot
        var14 = nil
        local var17 = var8_upvw
        if var17 then
            if var8_upvw.Model ~= ValidRoot_2.Parent.Parent then
                var17 = false
            else
                var17 = true
            end
        end
        if var17 then
            local SOME = BinderUtils_upvr.findFirstChild(InventoryItemBinder_upvr, ValidRoot_2)
            if _1 then
                if SOME then
                    arg1.Name = "Replace %s with %s":format(SOME:GetName(), _1:GetName())
                    var14 = 0.5
                else
                    arg1.Name = "Store %s":format(_1:GetName())
                    var14 = 0.5
                end
            elseif SOME then
                arg1.Name = "Take out %s":format(SOME:GetName())
                var14 = 0.5
            else
                arg1.Name = "Inspect Drawer"
                var14 = 0.5
            end
        else
            arg1.Name = "Inspect Drawer"
            var14 = 3
        end
        assert(var14)
        arg1.Duration = var14
    end
end
local function Action_upvr(arg1, arg2) -- Line 85, Named "Action"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _1_2 = InventoryItemSystem_upvr.getEquippedFor(LocalPlayer_upvr)[1]
    local ValidRoot_4 = arg1.ValidRoot
    local var21 = var8_upvw
    if var21 then
        if var8_upvw.Model ~= ValidRoot_4.Parent.Parent then
            var21 = false
        else
            var21 = true
        end
    end
    if var21 then
        if _1_2 then
            var6_upvw:FireServer('x'.."m01v6qmokfl":sub(4, 9):reverse():reverse():reverse()..""..'k', ValidRoot_4, _1_2.obj)
        elseif BinderUtils_upvr.findFirstChild(InventoryItemBinder_upvr, ValidRoot_4) then
            var6_upvw:FireServer('c'.."lvkglmbq":sub(3, 4):reverse().."".."".."xhvtx":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."f8qg", ValidRoot_4)
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    else
        var6_upvw:FireServer('x'.."w41tt3zf":sub(3, 7):reverse().."".."".."ggs5a8":sub(2, 2):reverse():reverse():reverse():reverse():reverse()..""..'n', ValidRoot_4)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function AddedFun_upvr(arg1) -- Line 105, Named "AddedFun"
    CircleAction_upvr.Add({
        Part = arg1.Parent.Handle;
        WorldPosition = arg1.Parent.Handle.Position;
        ValidRoot = arg1.Parent;
        Name = "Inspect Drawer";
        Timed = true;
        Duration = 1;
        Dist = 5;
        Callback = Action_upvr;
        Update = Update_upvr;
        ShowFun = ShowFun_upvr;
        HideFun = HideFun_upvr;
    }, arg1)
    tbl_upvr[arg1] = {
        Closed = arg1.CFrame;
        Opened = arg1.CFrame * CFrame.new(0, 0, -1.5);
    }
end
local function RemovedFun_upvr(arg1) -- Line 123, Named "RemovedFun"
    tbl_upvr[arg1] = nil
    CircleAction_upvr.Remove(arg1)
end
local var24_upvw
local var25_upvw
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local CollectionService_upvr = game:GetService("CollectionService")
return {
    Init = function(arg1) -- Line 128, Named "Init"
        var24_upvw = arg1.Inventory
        var6_upvw = arg1.Event
        var25_upvw = arg1.em
        function var25_upvw.a13d3zx8(arg1_2) -- Line 133
            assert(arg1_2)
            var8_upvw = arg1_2
        end
        local var30_upvw = 0
        local ScreenGui_upvr = arg1.ScreenGui
        function var25_upvw.dzjrhbvz() -- Line 139
            local var32 = var30_upvw + 1
            var30_upvw = var32
            local Cell = Settings_upvr.Time.Cell
            local CellTime = ScreenGui_upvr.CellTime
            CellTime.Time.Text = "%ds":format(Cell)
            CellTime.Visible = true
            local tick_result1 = tick()
            repeat
                wait(1)
                if var32 ~= var30_upvw then return end
                CellTime.Time.Text = "%ds":format(Settings_upvr.Time.Cell - tick() + tick_result1)
            until Cell <= tick() - tick_result1
            if var32 ~= var30_upvw then
            else
                CellTime.Visible = false
            end
        end
        for _, v in next, CollectionService_upvr:GetTagged("StashDrawer") do
            AddedFun_upvr(v)
        end
        CollectionService_upvr:GetInstanceAddedSignal("StashDrawer"):Connect(AddedFun_upvr)
        CollectionService_upvr:GetInstanceRemovedSignal("StashDrawer"):Connect(RemovedFun_upvr)
    end;
}