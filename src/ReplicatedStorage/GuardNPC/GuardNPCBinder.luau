local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPC_upvr = require(ReplicatedStorage.NPC.NPC)
local GuardNPCConsts_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, NPC_upvr)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local InventoryItemOwnerBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemOwnerBinder)
local ItemSystem_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local Math_upvr = require(ReplicatedStorage.Module.Math)
local MinimapService_upvr = require(ReplicatedStorage.App.MinimapService)
local Players_upvr = game:GetService("Players")
function module_upvr.new(arg1, arg2) -- Line 21
    local any_new_result1_upvr_2 = NPC_upvr.new(arg1, arg2)
    setmetatable(any_new_result1_upvr_2, module_upvr)
    local any_new_result1_upvr = Maid_upvr.new()
    any_new_result1_upvr_2._maid:GiveTask(any_new_result1_upvr)
    local function observePlayerObj(arg1_2) -- Line 27
        any_new_result1_upvr:DoCleaning()
        if not arg1_2 then
        else
            any_new_result1_upvr:GivePromise(InventoryItemOwnerBinder_upvr:Promise(arg1_2):andThen(function(arg1_3) -- Line 32
                local any_GetEquipped_result1 = ItemSystem_upvr.GetEquipped(arg1_3)
                if any_GetEquipped_result1 then
                    any_new_result1_upvr_2:_onItemEquipped(any_GetEquipped_result1)
                end
                any_new_result1_upvr:GiveTask(ItemSystem_upvr.onItemEquipped:Connect(function(arg1_4) -- Line 37
                    if arg1_4.Player ~= arg1_3 then
                    else
                        any_new_result1_upvr_2:_onItemEquipped(arg1_4)
                    end
                end))
            end))
        end
    end
    observePlayerObj(arg2.characterToPlayerObj.Value)
    any_new_result1_upvr_2._maid:GiveTask(arg2.characterToPlayerObj.Changed:Connect(observePlayerObj))
    any_new_result1_upvr_2._maid:GiveTask(MinimapService_upvr.add({
        part = any_new_result1_upvr_2.obj.PrimaryPart;
        color = Color3.fromRGB(255, 204, 0);
        name = Math_upvr.Base85UUID(5);
        size = UDim2.new(0, 12, 0, 12);
        flash = true;
    }))
    local function _() -- Line 58, Named "initializePlayerPushing"
        local tbl_upvr = {}
        any_new_result1_upvr_2._maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 60
            for _, v in Players_upvr:GetPlayers() do
                local Character = v.Character
                local var32
                if Character then
                    var32 = Character.PrimaryPart
                    var32 = var32.Position
                    var32 = nil
                    if tbl_upvr[v.UserId] then
                        var32 = workspace:GetServerTimeNow() - tbl_upvr[v.UserId]
                    else
                        var32 = math.huge
                    end
                    if (var32 - any_new_result1_upvr_2.obj.PrimaryPart.Position).Magnitude <= GuardNPCConsts_upvr.DIST_TO_PUSH_WITHIN and GuardNPCConsts_upvr.TIME_BETWEEN_PUSHES < var32 then
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        tbl_upvr[v.UserId] = workspace:GetServerTimeNow()
                        table.insert({}, Character)
                    end
                end
            end
            for _, v_2 in {} do
                v_2.PrimaryPart:ApplyImpulse((v_2.PrimaryPart.Position - any_new_result1_upvr_2.obj.PrimaryPart.Position).Unit * GuardNPCConsts_upvr.PUSH_IMPULSE_MULTIPLIER)
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            end
            return true
        end))
    end
    return any_new_result1_upvr_2
end
local NPCConsts_upvr = require(ReplicatedStorage.NPC.NPCConsts)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local GuardNPCShared_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCShared)
local GuardNPCUtils_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCUtils)
function module_upvr._onItemEquipped(arg1, arg2) -- Line 96
    arg2.SimulateLocal = true
    arg2.MinimalFx = true
    arg2.BulletEmitter.SimulateLocal = true
    arg2.BulletEmitter.IgnoreLocalPlayer = false
    arg2.BulletEmitter.ShieldBlockPct = 0.75
    arg2.BulletEmitter.IgnoreGuards = true
    arg2.BulletEmitter.Color = Color3.fromRGB(196, 40, 28)
    local var37_upvr = math.random() * 100
    local var38_upvw = 0
    local zero_vector3_upvw = Vector3.new()
    local os_clock_result1_upvw = os.clock()
    local var41_upvw = false
    local os_clock_result1_upvw_2 = os.clock()
    local var43_upvw = 0
    local function update_upvr() -- Line 118, Named "update"
        local var44 = os.clock() + var37_upvr
        if not arg1.obj.Humanoid or arg1.obj.Humanoid.Health <= 0 then
            return false
        end
        if arg1:GetTargetType() == NPCConsts_upvr.DEST_TYPE.IDLE then
            if 1.5 < var44 - var38_upvw then
                local any_randomPointInCircle_result1 = GeomUtils_upvr.randomPointInCircle()
                zero_vector3_upvw = Vector3.new(any_randomPointInCircle_result1.X, 0, any_randomPointInCircle_result1.Y)
                var38_upvw = var44
            end
            local var46 = arg1.obj.PrimaryPart.Position + arg1.obj.PrimaryPart.CFrame.LookVector * 10
            if arg1.obj.PrimaryPart.Velocity.Magnitude < 8 then
                var46 += zero_vector3_upvw * 7
            end
            arg2:SetThirdMousePosition(var46)
        else
            local any_GetTarget_result1 = arg1:GetTarget()
            if not any_GetTarget_result1 then
                return false
            end
            if typeof(any_GetTarget_result1) ~= "Instance" then
                return false
            end
            if 1 < var44 - os_clock_result1_upvw then
                var41_upvw = GuardNPCShared_upvr.canSeeTarget(arg1.obj, any_GetTarget_result1, arg1.occlusionCastParams)
                os_clock_result1_upvw = var44
            end
            if not var41_upvw then
                return false
            end
            local Parent = any_GetTarget_result1.Parent
            if not Parent then
                return false
            end
            arg2.BulletSpread = GuardNPCUtils_upvr.getBulletSpread(arg1.obj)
            arg2:SetThirdMousePosition(Parent:FindFirstChild("Head").Position)
            local any_getTriggerPressFreq_result1 = GuardNPCUtils_upvr.getTriggerPressFreq(arg1.obj)
            if 1 / any_getTriggerPressFreq_result1 < var44 - os_clock_result1_upvw_2 then
                os_clock_result1_upvw_2 = var44
                var43_upvw = math.random()
                arg2:InputBegan({
                    UserInputType = Enum.UserInputType.MouseButton1;
                })
                task.delay(math.min(0.5, 1 / any_getTriggerPressFreq_result1 * var43_upvw), function() -- Line 168
                    if arg2.Destroyed then
                    else
                        arg2:InputEnded({
                            UserInputType = Enum.UserInputType.MouseButton1;
                        })
                    end
                end)
                return true
            end
        end
        return false
    end
    arg1._maid.itemHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 179
        debug.profilebegin("GuardNPC Heartbeat")
        update_upvr()
        debug.profileend()
    end)
end
return require(ReplicatedStorage.ManifestBinder).new(GuardNPCConsts_upvr.TAG_NAME, {
    humanoid = "Humanoid";
    characterToPlayerObj = GuardNPCConsts_upvr.CHARCTER_TO_PLAYER_OBJ_NAME;
}, module_upvr)