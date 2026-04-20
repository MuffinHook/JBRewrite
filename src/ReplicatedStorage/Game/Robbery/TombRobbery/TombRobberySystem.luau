local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local TombRobberyConsts_upvr = require(script.Parent.TombRobberyConsts)
local var10_upvw
local module_upvr = {}
local SoundService_upvr = game:GetService("SoundService")
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
function module_upvr.init(arg1) -- Line 21
    var10_upvw = arg1.Event
    local var14_upvw
    local var15_upvw
    local var16_upvw
    local var17_upvw
    local function playMusic_upvr() -- Line 30, Named "playMusic"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var18
        if var17_upvw then
            var17_upvw:cancel()
            var17_upvw = nil
        end
        if not var14_upvw then
            local tbl_4 = {}
            var18 = true
            tbl_4.Looped = var18
            var18 = 0
            tbl_4.Volume = var18
            var14_upvw = Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 9062816634, tbl_4)
            var14_upvw.SoundGroup = SoundService_upvr.RobberyMusic
        end
        if not var15_upvw then
            local tbl_7 = {}
            var18 = true
            tbl_7.Looped = var18
            var18 = 0
            tbl_7.Volume = var18
            var15_upvw = Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 9062816122, tbl_7)
            var15_upvw.SoundGroup = SoundService_upvr.RobberyMusic
        end
        local tbl_5 = {}
        if var16_upvw then
            var18 = 1
        else
            var18 = 0
        end
        local var22 = 3
        var18 = var15_upvw
        if not var16_upvw then
        else
        end
        tbl_5[1] = Audio_upvr.promiseFadeTo(var14_upvw, var18, var22)
        tbl_5[2] = Audio_upvr.promiseFadeTo(var18, 0, 3)
        var17_upvw = Promise_upvr.all(tbl_5):andThen(function() -- Line 46
            var17_upvw = nil
        end)
    end
    local function stopMusic_upvr() -- Line 50, Named "stopMusic"
        if var17_upvw then
            var17_upvw:cancel()
            var17_upvw = nil
        end
        var17_upvw = Promise_upvr.all({Audio_upvr.promiseFadeTo(var14_upvw, 0, 1):andThen(function() -- Line 56
            var14_upvw:Destroy()
            var14_upvw = nil
        end), Audio_upvr.promiseFadeTo(var15_upvw, 0, 1):andThen(function() -- Line 60
            var15_upvw:Destroy()
            var15_upvw = nil
        end)}):andThen(function() -- Line 64
            var17_upvw = nil
        end)
    end
    local function changeTrack_upvr() -- Line 68, Named "changeTrack"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var28
        if not var14_upvw or not var15_upvw then
        else
            if var17_upvw then
                var17_upvw:await()
            end
            if not var14_upvw or not var15_upvw then return end
            local tbl_6 = {}
            if var16_upvw then
                var28 = 1
            else
                var28 = 0
            end
            local var30 = 2
            var28 = var15_upvw
            if not var16_upvw then
            else
            end
            tbl_6[1] = Audio_upvr.promiseFadeTo(var14_upvw, var28, var30)
            tbl_6[2] = Audio_upvr.promiseFadeTo(var28, 0, 2)
            var17_upvw = Promise_upvr.all(tbl_6):andThen(function() -- Line 82
                var17_upvw = nil
            end)
        end
    end
    waitForChild_upvr(LocalPlayer_upvr.PlayerGui, TombRobberyConsts_upvr.MUSIC_ENABLED_VALUE_NAME):andThen(function(arg1_2) -- Line 87
        arg1_2.Changed:Connect(function(arg1_3) -- Line 88
            if arg1_3 then
                playMusic_upvr()
            else
                stopMusic_upvr()
            end
        end)
        if arg1_2.Value then
            playMusic_upvr()
        end
    end)
    waitForChild_upvr(LocalPlayer_upvr.PlayerGui, TombRobberyConsts_upvr.MUSIC_TRACK_VALUE_NAME):andThen(function(arg1_4) -- Line 100
        arg1_4.Changed:Connect(function(arg1_5) -- Line 101
            var16_upvw = arg1_5
            changeTrack_upvr()
        end)
        var16_upvw = arg1_4.Value
        changeTrack_upvr()
    end)
    local function hookCharacter(arg1_6) -- Line 109
        local Humanoid = arg1_6:WaitForChild("Humanoid")
        local any_LoadAnimation_result1_upvr = Humanoid:LoadAnimation(ReplicatedStorage_upvr.Resource.CartDuckAnimation)
        module_upvr._duckTrack = any_LoadAnimation_result1_upvr
        local var39_upvw
        var39_upvw = Humanoid.Died:Connect(function() -- Line 115
            var39_upvw:Disconnect()
            any_LoadAnimation_result1_upvr:Destroy()
            module_upvr._duckTrack = nil
        end)
    end
    if LocalPlayer_upvr.Character then
        hookCharacter(LocalPlayer_upvr.Character)
    end
    LocalPlayer_upvr.CharacterAdded:Connect(hookCharacter)
    module_upvr.setupSpikes()
    module_upvr.setupGems()
    module_upvr.setupWood()
    module_upvr.setupBranches()
end
local DoorUtils_upvr = require(ReplicatedStorage_upvr.Door2.DoorUtils)
function module_upvr.setupSpikes() -- Line 143
    local var42_upvw = 0
    Binder_upvr.new(TombRobberyConsts_upvr.SPIKE_TAG_NAME, function(arg1) -- Line 145
        RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
        local any_getInnerModel_result1 = DoorUtils_upvr.getInnerModel(arg1)
        RxInstanceUtils_upvr.yieldForProperty(any_getInnerModel_result1, "PrimaryPart")
        local var44_upvw = 0
        any_getInnerModel_result1.PrimaryPart.Touched:Connect(function(arg1_7) -- Line 153
            if arg1_7.Parent ~= LocalPlayer_upvr.Character then
            else
                if 32 < (arg1_7.Position - LocalPlayer_upvr.Character.PrimaryPart.Position).Magnitude then return end
                local os_clock_result1 = os.clock()
                if 1 < os_clock_result1 - var44_upvw and 0.5 < os_clock_result1 - var42_upvw then
                    var44_upvw = os_clock_result1
                    var42_upvw = os_clock_result1
                    var10_upvw:FireServer('y'.."".."zpzrmy9":sub(2, 3):reverse().."".."lkho3", 36, "Spikes")
                end
            end
        end)
        DoorUtils_upvr.getDoorOpenChangedSignal(arg1):Connect(function() -- Line 168
            if DoorUtils_upvr.getOpen(arg1) then
                var44_upvw = 0
            end
        end)
        return Maid_upvr.new()
    end):Start()
end
function module_upvr.setupGems() -- Line 178
    Binder_upvr.new(TombRobberyConsts_upvr.GEM_TAG_NAME, function(arg1) -- Line 179
        RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
        local any_new_result1_2 = Maid_upvr.new()
        local function action(arg1_8, arg2) -- Line 183
            if arg2 then
                local SOME = arg1:FindFirstChild(TombRobberyConsts_upvr.GEM_COLLECT_REMOTE_NAME)
                assert(SOME)
                SOME:FireServer()
                return true
            end
        end
        local function preUpdateFun(arg1_9) -- Line 191
            local var51
            if arg1_9.Part.Transparency >= 0.999 then
                var51 = false
            else
                var51 = true
            end
            arg1_9.Enabled = var51
        end
        local PrimaryPart_upvr = arg1.PrimaryPart
        CircleAction_upvr.Add({
            Part = PrimaryPart_upvr;
            Name = "Collect";
            NoRay = true;
            Timed = false;
            Dist = 8;
            Callback = action;
            PreUpdateFun = preUpdateFun;
            PreUpdatePeriod = 0.5;
        }, PrimaryPart_upvr)
        any_new_result1_2:GiveTask(function() -- Line 206
            CircleAction_upvr.Remove(PrimaryPart_upvr)
        end)
        return any_new_result1_2
    end):Start()
end
function module_upvr.duck() -- Line 215
    local _duckTrack_upvr = module_upvr._duckTrack
    if not _duckTrack_upvr then
    else
        if module_upvr._duckPromise then
            module_upvr._duckPromise:cancel()
            module_upvr._duckPromise = nil
        end
        _duckTrack_upvr:Play()
        module_upvr._duckPromise = Promise_upvr.delay(2):andThen(function() -- Line 225
            _duckTrack_upvr:Stop()
            module_upvr._duckPromise = nil
        end)
    end
end
local CartSystem_upvr = require(ReplicatedStorage_upvr.Game.Cart.CartSystem)
local function preUpdateFun_upvr(arg1) -- Line 230, Named "preUpdateFun"
    local tbl_2 = {}
    if LocalPlayer_upvr.Character then
        table.insert(tbl_2, LocalPlayer_upvr.Character)
        local any_getCartForCharacter_result1_2 = CartSystem_upvr.getCartForCharacter(LocalPlayer_upvr.Character)
        if any_getCartForCharacter_result1_2 then
            table.insert(tbl_2, any_getCartForCharacter_result1_2._obj)
        end
    end
    arg1.IgnoreOverride = tbl_2
end
function module_upvr.setupWood() -- Line 241
    Binder_upvr.new(TombRobberyConsts_upvr.WOOD_TAG_NAME, function(arg1) -- Line 242
        local any_new_result1 = Maid_upvr.new()
        local function action(arg1_10, arg2) -- Line 244
            if arg2 then
                module_upvr.duck()
                arg1_10.Enabled = false
                Promise_upvr.delay(2):andThen(function() -- Line 248
                    arg1_10.Enabled = true
                end)
                return true
            end
        end
        local tbl_3 = {}
        tbl_3.Part = arg1
        tbl_3.Name = "Duck"
        tbl_3.NoRay = true
        tbl_3.Timed = false
        tbl_3.Dist = 36
        tbl_3.Callback = action
        tbl_3.PreUpdateFun = preUpdateFun_upvr
        tbl_3.PreUpdatePeriod = 0.2
        CircleAction_upvr.Add(tbl_3, arg1)
        any_new_result1:GiveTask(function() -- Line 265
            CircleAction_upvr.Remove(arg1)
        end)
        local var68_upvw = 0
        any_new_result1:GiveTask(arg1.Touched:Connect(function(arg1_11) -- Line 270
            if not arg1_11:IsDescendantOf(LocalPlayer_upvr.Character) then
            else
                if 32 < (arg1_11.Position - LocalPlayer_upvr.Character.PrimaryPart.Position).Magnitude then return end
                local os_clock_result1_2 = os.clock()
                if os_clock_result1_2 - var68_upvw < 10 then return end
                var68_upvw = os_clock_result1_2
                if module_upvr._duckTrack and not module_upvr._duckTrack.IsPlaying then
                    var10_upvw:FireServer('y'.."".."wmspzvtu":sub(4, 5):reverse():reverse():reverse().."".."".."bxshklh":sub(4, 6):reverse().."".."o3", 30, "Duck")
                    Audio_upvr.ObjectLocal(arg1, 6875020869, {
                        Volume = 0.6;
                        RollOffMaxDistance = 64;
                    })
                    return
                end
                Audio_upvr.ObjectLocal(arg1, 3772601178, {
                    Volume = 0.2;
                    RollOffMaxDistance = 64;
                })
            end
        end))
        return any_new_result1
    end):Start()
end
function module_upvr.setupBranches() -- Line 295
    Binder_upvr.new(TombRobberyConsts_upvr.BRANCH_SWITCH_TAG_NAME, function(arg1) -- Line 296
        local any_new_result1_3 = Maid_upvr.new()
        CircleAction_upvr.Add({
            Part = arg1.PrimaryPart;
            ValidRoot = arg1.Parent;
            Name = "Switch";
            Dist = 80;
            Callback = function(arg1_12, arg2) -- Line 298, Named "action"
                if arg2 then
                    arg1:WaitForChild(TombRobberyConsts_upvr.BRANCH_SWITCH_REMOTE_NAME):FireServer()
                    return true
                end
            end;
            PreUpdateFun = preUpdateFun_upvr;
            PreUpdatePeriod = 0.2;
        }, arg1)
        any_new_result1_3:GiveTask(function() -- Line 315
            CircleAction_upvr.Remove(arg1)
        end)
        return any_new_result1_3
    end):Start()
end
return module_upvr