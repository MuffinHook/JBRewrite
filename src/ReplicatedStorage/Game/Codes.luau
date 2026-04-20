local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local AlexWM_upvr = require(ReplicatedStorage_upvr.Module.AlexWM)
local CollectionService_upvr = game:GetService("CollectionService")
return {
    Init = function(arg1) -- Line 10, Named "Init"
        local CodesGui_upvr = ReplicatedStorage_upvr.StarterGui:FindFirstChild("CodesGui")
        CodesGui_upvr.Parent = LocalPlayer_upvr.PlayerGui
        local any_MakeWindow_result1_upvr = AlexWM_upvr.MakeWindow()
        function any_MakeWindow_result1_upvr.OpenFun() -- Line 18, Named "WindowOpen"
            CodesGui_upvr.Enabled = true
        end
        function any_MakeWindow_result1_upvr.CloseFun() -- Line 21, Named "WindowClose"
            CodesGui_upvr.Enabled = false
        end
        AlexWM_upvr.WindowGroupAdd(arg1.MainWindowGroup, any_MakeWindow_result1_upvr)
        CodesGui_upvr.CodeContainer.Close.MouseButton1Down:Connect(function() -- Line 33
            AlexWM_upvr.WindowClose(any_MakeWindow_result1_upvr)
        end)
        local function preUpdateFun_upvr(arg1_3) -- Line 36, Named "preUpdateFun"
            arg1_3.Enabled = not any_MakeWindow_result1_upvr.IsOpen
        end
        local function action_upvr(arg1_4, arg2) -- Line 39, Named "action"
            if arg2 then
                AlexWM_upvr.WindowOpen(any_MakeWindow_result1_upvr)
                arg1_4.Enabled = not any_MakeWindow_result1_upvr.IsOpen
            end
        end
        local Event_upvr = arg1.Event
        local function Submit_upvr() -- Line 59, Named "Submit"
            local Text = CodesGui_upvr.CodeContainer.Background.CodeContainer.Code.Text
            if #Text <= 0 or 30 <= #Text then
                return false
            end
            CodesGui_upvr.CodeContainer.Background.CodeContainer.Code.Text = ""
            Event_upvr:FireServer('p'.."b561y":sub(4, 4):reverse():reverse():reverse().."".."".."n2ulvilk":sub(5, 6):reverse().."".."".."qye482nlo":sub(5, 6):reverse():reverse():reverse():reverse():reverse().."".."61", Text)
            AlexWM_upvr.WindowClose(any_MakeWindow_result1_upvr)
        end
        CodesGui_upvr.CodeContainer.Background.Redeem.MouseButton1Down:Connect(Submit_upvr)
        CodesGui_upvr.CodeContainer.Background.CodeContainer.Code.FocusLost:Connect(function(arg1_6) -- Line 70
            if arg1_6 then
                Submit_upvr()
            end
        end)
        for _, v in next, CollectionService_upvr:GetTagged("ATM") do
            CircleAction_upvr.Add({
                Part = v;
                Name = "Open ATM";
                Timed = false;
                Dist = 7;
                Callback = action_upvr;
                ValidRoot = v.Parent;
                PreUpdateFun = preUpdateFun_upvr;
                PreUpdatePeriod = 0.5;
            }, v)
        end
        CollectionService_upvr:GetInstanceAddedSignal("ATM"):Connect(function(arg1_5) -- Line 45, Named "AddedFun"
            local tbl = {}
            tbl.Part = arg1_5
            tbl.Name = "Open ATM"
            tbl.Timed = false
            tbl.Dist = 7
            tbl.Callback = action_upvr
            tbl.ValidRoot = arg1_5.Parent
            tbl.PreUpdateFun = preUpdateFun_upvr
            tbl.PreUpdatePeriod = 0.5
            CircleAction_upvr.Add(tbl, arg1_5)
            return true
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("ATM"):Connect(function(arg1_2) -- Line 24, Named "RemovedFun"
            CircleAction_upvr.Remove(arg1_2)
            return true
        end)
    end;
}