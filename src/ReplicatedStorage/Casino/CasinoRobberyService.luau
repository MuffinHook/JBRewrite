local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local CasinoRobberyConsts_upvr = require(script.Parent.CasinoRobberyConsts)
local module_upvr = {}
function module_upvr.init() -- Line 19
    module_upvr.setupCollect()
    module_upvr.setupComputers()
    module_upvr.setupRobberyDoor()
    module_upvr.setupMusic()
    module_upvr.setupAlarm()
end
function module_upvr.setupCollect() -- Line 26
    Binder_upvr.new(CasinoRobberyConsts_upvr.LOOT_TAG_NAME, function(arg1) -- Line 27
        local any_new_result1 = Maid_upvr.new()
        local function action(arg1_2, arg2) -- Line 29
            if arg2 then
                arg1:FindFirstChild(CasinoRobberyConsts_upvr.LOOT_COLLECT_REMOTE_NAME):FireServer()
                return true
            end
        end
        local var11_upvw
        if arg1:IsA("Model") then
            RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
            var11_upvw = arg1.PrimaryPart
        elseif arg1:IsA("BasePart") then
            var11_upvw = arg1
        else
            error("Invalid ClassName for Casino Collect obj")
        end
        CircleAction_upvr.Add({
            Part = var11_upvw;
            Name = "Collect";
            NoRay = true;
            Timed = true;
            Duration = 0.5;
            Dist = 8;
            Callback = action;
        }, var11_upvw)
        any_new_result1:GiveTask(function() -- Line 60
            CircleAction_upvr.Remove(var11_upvw)
        end)
        return any_new_result1
    end):Start()
end
function module_upvr.setupComputers() -- Line 67
    Binder_upvr.new(CasinoRobberyConsts_upvr.COMPUTER_TAG_NAME, function(arg1) -- Line 68
        RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
        local any_new_result1_3 = Maid_upvr.new()
        local function action(arg1_3, arg2) -- Line 71
            if arg2 then
                arg1:FindFirstChild(CasinoRobberyConsts_upvr.COMPUTER_HACK_REMOTE_NAME):FireServer()
                return true
            end
        end
        local PrimaryPart_upvr = arg1.PrimaryPart
        local tbl_upvr = {
            Part = PrimaryPart_upvr;
            Name = "Hack";
            NoRay = true;
            Timed = true;
            Duration = 0.5;
            Dist = 8;
            Callback = action;
        }
        local function update() -- Line 88
            local var18
            if arg1:GetAttribute("ComputerActive") ~= true then
                var18 = false
            else
                var18 = true
            end
            tbl_upvr.Enabled = var18
            local var19 = "Hack"
            var18 = false
            if arg1:GetAttribute("ShowDisableSecurityPrompt") == true then
                var19 = "Disable Vault Security"
                var18 = true
            end
            tbl_upvr.Name = var19
            tbl_upvr.Timed = var18
        end
        local var20
        if arg1:GetAttribute("ComputerActive") ~= true then
            var20 = false
        else
            var20 = true
        end
        tbl_upvr.Enabled = var20
        var20 = "Hack"
        local var21 = false
        if arg1:GetAttribute("ShowDisableSecurityPrompt") == true then
            var20 = "Disable Vault Security"
            var21 = true
        end
        tbl_upvr.Name = var20
        tbl_upvr.Timed = var21
        any_new_result1_3:GiveTask(arg1:GetAttributeChangedSignal("ComputerActive"):Connect(update))
        any_new_result1_3:GiveTask(arg1:GetAttributeChangedSignal("ShowDisableSecurityPrompt"):Connect(update))
        CircleAction_upvr.Add(tbl_upvr, PrimaryPart_upvr)
        any_new_result1_3:GiveTask(function() -- Line 104
            CircleAction_upvr.Remove(PrimaryPart_upvr)
        end)
        return any_new_result1_3
    end):Start()
end
local Notification_upvr = require(ReplicatedStorage_upvr.Game.Notification)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
function module_upvr.setupRobberyDoor() -- Line 111
    Binder_upvr.new(CasinoRobberyConsts_upvr.KEYPAD_TAG_NAME, function(arg1) -- Line 114
        local any_new_result1_4 = Maid_upvr.new()
        local tbl = {}
        tbl.Part = arg1
        tbl.ValidRoot = arg1.Parent
        tbl.Name = "Open Keypad"
        tbl.Dist = 8
        function tbl.Callback(arg1_4, arg2) -- Line 116, Named "action"
            local var27
            if workspace:FindFirstChild(CasinoRobberyConsts_upvr.WORKSPACE_MODEL_NAME):GetAttribute(CasinoRobberyConsts_upvr.OPEN_ATTR_NAME) ~= true then
                var27 = false
            else
                var27 = true
            end
            if not var27 then
                Notification_upvr.new({
                    Text = "Wait for the Crown Jewel to open...";
                })
                return false
            end
            if arg2 then
                store_upvr:dispatch({
                    type = "setCasinoKeypadVisible";
                    visible = true;
                })
                store_upvr:dispatch({
                    type = "setCasinoKeypadCallback";
                    callback = function(arg1_5) -- Line 130, Named "callback"
                        arg1:FindFirstChild(CasinoRobberyConsts_upvr.KEYPAD_SUBMIT_REMOTE_NAME):FireServer(arg1_5)
                    end;
                })
                return true
            end
        end
        CircleAction_upvr.Add(tbl, arg1)
        any_new_result1_4:GiveTask(function() -- Line 147
            CircleAction_upvr.Remove(arg1)
        end)
        return any_new_result1_4
    end):Start()
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module_upvr.setupMusic() -- Line 154
    local var35_upvw
    local var36_upvw
    Players_upvr.LocalPlayer:GetAttributeChangedSignal(CasinoRobberyConsts_upvr.ROBBERY_MUSIC_PLAYING_ATTR_NAME):Connect(function() -- Line 160
        if var35_upvw then
            var35_upvw:cancel()
            var35_upvw = nil
        end
        if var36_upvw then
            local var37_upvr = var36_upvw
            var36_upvw = nil
            Audio_upvr.promiseFadeTo(var37_upvr, 0, 3):finally(function() -- Line 169
                var37_upvr:Destroy()
            end)
        end
        if Players_upvr.LocalPlayer:GetAttribute(CasinoRobberyConsts_upvr.ROBBERY_MUSIC_PLAYING_ATTR_NAME) then
            var37_upvr = Audio_upvr
            var37_upvr = var37_upvr.ObjectLocal
            var37_upvr = var37_upvr(Players_upvr.LocalPlayer.PlayerGui, 1837987527, {
                Looped = true;
                Volume = 0;
            })
            var36_upvw = var37_upvr
            var37_upvr = var36_upvw
            var37_upvr.Name = "CasinoMusic"
            var37_upvr = var36_upvw
            var37_upvr.SoundGroup = game:GetService("SoundService").RobberyMusic
            var37_upvr = Audio_upvr
            var37_upvr = var37_upvr.promiseFadeTo(var36_upvw, 0.5, 3)
            var37_upvr = var37_upvr:finally(function() -- Line 177
                var35_upvw = nil
            end)
            var35_upvw = var37_upvr
        end
    end)
end
function module_upvr.setupAlarm() -- Line 183
    Binder_upvr.new("CasinoTriggerAlarm", function(arg1) -- Line 184
        local any_new_result1_2 = Maid_upvr.new()
        local var44_upvw = 0
        any_new_result1_2:GiveTask(arg1.Touched:Connect(function(arg1_6) -- Line 189
            if arg1_6:IsDescendantOf(Players_upvr.LocalPlayer.Character) then
                local os_clock_result1 = os.clock()
                if os_clock_result1 - var44_upvw < 0.3 then return end
                var44_upvw = os_clock_result1
                ReplicatedStorage_upvr:FindFirstChild(CasinoRobberyConsts_upvr.TRIGGER_ALARM_REMOTE_NAME):FireServer()
            end
        end))
        return any_new_result1_2
    end):Start()
end
return module_upvr