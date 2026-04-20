local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local ZiplineConsts_upvr = require(ReplicatedStorage.Zipline.ZiplineConsts)
local var5_upvw
local TweenService_upvr = game:GetService("TweenService")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Players_upvr = game:GetService("Players")
local var9_upvw
require(ReplicatedStorage.Std.CharacterUtils).observeLocalCharacterAdded(function(arg1, arg2) -- Line 11
    arg2:GiveTask(RxInstanceUtils_upvr.observeAttribute(arg1, ZiplineConsts_upvr.OnZiplineAttrName, function(arg1_2, arg2_2) -- Line 13
        if arg1_2 == true and arg1:FindFirstChild("Head") then
            workspace.CurrentCamera.CameraSubject = arg1.Head
            var5_upvw = TweenService_upvr:Create(workspace.CurrentCamera, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                FieldOfView = 90;
            })
            var5_upvw:Play()
            local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 114263747201737, {
                Looped = true;
                Volume = 0;
            })
            var9_upvw = Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 1.5, 0.5):finally(function() -- Line 24
                var9_upvw = nil
            end)
            arg2_2:GiveTask(function() -- Line 27
                workspace.CurrentCamera.CameraSubject = arg1.Humanoid
                if var9_upvw then
                    var9_upvw:cancel()
                    var9_upvw = nil
                end
                if var5_upvw then
                    var5_upvw:Cancel()
                    var5_upvw = nil
                end
                var5_upvw = TweenService_upvr:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FieldOfView = 70;
                })
                var5_upvw:Play()
                Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 0, 0.4):finally(function() -- Line 43
                    any_ObjectLocal_result1_upvr:Destroy()
                end)
            end)
        end
    end))
end)