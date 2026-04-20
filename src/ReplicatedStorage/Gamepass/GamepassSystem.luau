local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local tbl_upvr_2 = {}
local tbl_upvr_4 = {}
local module_upvr = {
    OnAnyOwned = Signal_upvr.new();
    OnAnyPlayerAnyOwned = Signal_upvr.new();
}
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.Init() -- Line 25
    module_upvr.OnAnyOwned:Connect(function(arg1) -- Line 26
        tbl_upvr_4[arg1] = true
    end)
    waitForChild_upvr(LocalPlayer_upvr, "Gamepasses"):andThen(module_upvr.Listen)
    local tbl_upvr_3 = {}
    local function _(arg1) -- Line 36, Named "monitorGamepasses"
        tbl_upvr_3[arg1]:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1:WaitForChild("Gamepasses"), function(arg1_2, arg2) -- Line 39
            module_upvr.OnAnyPlayerAnyOwned:Fire(arg1, arg1_2.Value)
        end))
    end
    for _, v_upvr in Players_upvr:GetPlayers() do
        tbl_upvr_3[v_upvr] = Maid_upvr.new()
        tbl_upvr_3[v_upvr]:GiveTask(RxInstanceUtils_upvr.observeChildren(v_upvr:WaitForChild("Gamepasses"), function(arg1, arg2) -- Line 39
            module_upvr.OnAnyPlayerAnyOwned:Fire(v_upvr, arg1.Value)
        end))
    end
    Players_upvr.PlayerAdded:Connect(function(arg1) -- Line 45, Named "playerAdded"
        tbl_upvr_3[arg1] = Maid_upvr.new()
        tbl_upvr_3[arg1]:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1:WaitForChild("Gamepasses"), function(arg1_3, arg2) -- Line 39
            module_upvr.OnAnyPlayerAnyOwned:Fire(arg1, arg1_3.Value)
        end))
    end)
    Players_upvr.PlayerRemoving:Connect(function(arg1) -- Line 33, Named "playerRemoving"
        tbl_upvr_3[arg1] = nil
    end)
end
local GamepassUtils_upvr = require(script.Parent.GamepassUtils)
function module_upvr.SetOwned(arg1) -- Line 56
    assert(GamepassUtils_upvr.GetGamepassFromEnum(arg1))
    module_upvr.OnAnyOwned:Fire(arg1)
    if tbl_upvr_2[arg1] then
        tbl_upvr_2[arg1]:Fire(arg1)
    end
end
function module_upvr.DoesPlayerOwn(arg1) -- Line 64
    local var24 = arg1
    assert(var24)
    local var25
    if type(arg1) ~= "number" then
        var24 = false
    else
        var24 = true
    end
    var25 = assert
    var25(var24)
    if tbl_upvr_4[arg1] ~= true then
        var25 = false
    else
        var25 = true
    end
    return var25
end
function module_upvr.doesPlayerOwnCached(arg1, arg2) -- Line 69
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1 == nil then
    else
    end
    assert(true, "missing player")
    if arg1.DisplayName == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true, "player was not a player")
    if arg2 == nil then
    else
    end
    assert(true, "missing gamepassEnum")
    local Gamepasses = arg1:FindFirstChild("Gamepasses")
    if not Gamepasses then
        return false
    end
    for _, v_2 in ipairs(Gamepasses:GetChildren()) do
        if v_2.Value == arg2 then
            return true
        end
    end
    do
        return false
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.Listen(arg1) -- Line 84
    assert(arg1)
    for _, v_3 in ipairs(arg1:GetChildren()) do
        local var42
        if v_3:IsA("IntValue") then
            if 0 >= v_3.Value then
                var42 = false
            else
                var42 = true
            end
            assert(var42)
            var42 = v_3.Value
            module_upvr.SetOwned(var42)
        end
    end
    arg1.ChildAdded:Connect(function(arg1_4) -- Line 86, Named "OnObjAdded"
        local var38
        if arg1_4:IsA("IntValue") then
            if 0 >= arg1_4.Value then
                var38 = false
            else
                var38 = true
            end
            assert(var38)
            var38 = arg1_4.Value
            module_upvr.SetOwned(var38)
        end
    end)
end
function module_upvr.GetGamepassOwnedSignal(arg1) -- Line 97
    local var43 = tbl_upvr_2[arg1]
    if var43 == nil then
        var43 = Signal_upvr.new()
        tbl_upvr_2[arg1] = var43
    end
    return var43
end
local tbl_upvr = {}
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function module_upvr.promiseProperty(arg1, arg2) -- Line 106
    if tbl_upvr[arg1] then
        return Promise_upvr.resolve(tbl_upvr[arg1][arg2])
    end
    return Promise_upvr.defer(function(arg1_5) -- Line 110
        local any_GetProductInfo_result1 = MarketplaceService_upvr:GetProductInfo(arg1, Enum.InfoType.GamePass)
        tbl_upvr[arg1] = any_GetProductInfo_result1
        arg1_5(any_GetProductInfo_result1[arg2])
    end)
end
function module_upvr.promisePrice(arg1) -- Line 116
    return module_upvr.promiseProperty(arg1, "PriceInRobux")
end
function module_upvr.promiseImageId(arg1) -- Line 119
    return module_upvr.promiseProperty(arg1, "IconImageAssetId")
end
return module_upvr