local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ZiplineConsts = require(ReplicatedStorage.Zipline.ZiplineConsts)
local v1 = nil
local v2 = nil
CharacterUtils.observeLocalCharacterAdded(function(p1, p2) --[[ Line: 11 | Upvalues: RxInstanceUtils (copy), ZiplineConsts (copy), v2 (ref), TweenService (copy), Audio (copy), Players (copy), v1 (ref) ]]
	p2:GiveTask(RxInstanceUtils.observeAttribute(p1, ZiplineConsts.OnZiplineAttrName, function(p12, p2) --[[ Line: 13 | Upvalues: p1 (copy), v2 (ref), TweenService (ref), Audio (ref), Players (ref), v1 (ref) ]]
		if p12 == true and p1:FindFirstChild("Head") then
			workspace.CurrentCamera.CameraSubject = p1.Head
			v2 = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				FieldOfView = 90
			})
			v2:Play()
			local v12 = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 114263747201737, {
				Looped = true,
				Volume = 0
			})
			v1 = Audio.promiseFadeTo(v12, 1.5, 0.5):finally(function() --[[ Line: 24 | Upvalues: v1 (ref) ]]
				v1 = nil
			end)
			p2:GiveTask(function() --[[ Line: 27 | Upvalues: p1 (ref), v1 (ref), v2 (ref), TweenService (ref), Audio (ref), v12 (copy) ]]
				workspace.CurrentCamera.CameraSubject = p1.Humanoid
				if v1 then
					v1:cancel()
					v1 = nil
				end
				if v2 then
					v2:Cancel()
					v2 = nil
				end
				v2 = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					FieldOfView = 70
				})
				v2:Play()
				Audio.promiseFadeTo(v12, 0, 0.4):finally(function() --[[ Line: 43 | Upvalues: v12 (ref) ]]
					v12:Destroy()
				end)
			end)
		end
	end))
end)