game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AlexWM = require(ReplicatedStorage.Module.AlexWM)
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
return {
	Init = function(p1) --[[ Name: Init | Line: 10 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), CircleAction (copy), AlexWM (copy), CollectionService (copy) ]]
		local CodesGui = ReplicatedStorage.StarterGui:FindFirstChild("CodesGui")
		CodesGui.Parent = LocalPlayer.PlayerGui
		local v1 = p1.Event
		local function WindowOpen() --[[ Line: 18 | Upvalues: CodesGui (copy) ]]
			CodesGui.Enabled = true
		end
		local function WindowClose() --[[ Line: 21 | Upvalues: CodesGui (copy) ]]
			CodesGui.Enabled = false
		end
		local function RemovedFun(p1) --[[ Line: 24 | Upvalues: CircleAction (ref) ]]
			CircleAction.Remove(p1)
			return true
		end
		local v2 = AlexWM.MakeWindow()
		v2.OpenFun = WindowOpen
		v2.CloseFun = WindowClose
		AlexWM.WindowGroupAdd(p1.MainWindowGroup, v2)
		CodesGui.CodeContainer.Close.MouseButton1Down:Connect(function() --[[ Line: 33 | Upvalues: AlexWM (ref), v2 (copy) ]]
			AlexWM.WindowClose(v2)
		end)
		local function preUpdateFun(p1) --[[ Line: 36 | Upvalues: v2 (copy) ]]
			p1.Enabled = not v2.IsOpen
		end
		local function action(p1, p2) --[[ Line: 39 | Upvalues: AlexWM (ref), v2 (copy) ]]
			if p2 then
				AlexWM.WindowOpen(v2)
				p1.Enabled = not v2.IsOpen
			end
		end
		local function AddedFun(p1) --[[ Line: 45 | Upvalues: action (copy), preUpdateFun (copy), CircleAction (ref) ]]
			CircleAction.Add({
				Part = p1,
				Name = "Open ATM",
				Timed = false,
				Dist = 7,
				Callback = action,
				ValidRoot = p1.Parent,
				PreUpdateFun = preUpdateFun,
				PreUpdatePeriod = 0.5
			}, p1)
			return true
		end
		local function Submit() --[[ Line: 59 | Upvalues: CodesGui (copy), v1 (copy), AlexWM (ref), v2 (copy) ]]
			local Text = CodesGui.CodeContainer.Background.CodeContainer.Code.Text
			if #Text <= 0 or #Text >= 30 then
				return false
			end
			CodesGui.CodeContainer.Background.CodeContainer.Code.Text = ""
			v1:FireServer("k" .. ("ufdiwhmg"):sub(4, 6):reverse():reverse():reverse() .. "" .. "" .. ("yklotvu"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "hx", Text)
			AlexWM.WindowClose(v2)
		end
		CodesGui.CodeContainer.Background.Redeem.MouseButton1Down:Connect(Submit)
		CodesGui.CodeContainer.Background.CodeContainer.Code.FocusLost:Connect(function(p1) --[[ Line: 70 | Upvalues: Submit (copy) ]]
			if p1 then
				Submit()
			end
		end)
		local v3 = next
		local v4, v5 = CollectionService:GetTagged("ATM")
		for v6, v7 in v3, v4, v5 do
			CircleAction.Add({
				Part = v7,
				Name = "Open ATM",
				Timed = false,
				Dist = 7,
				Callback = action,
				ValidRoot = v7.Parent,
				PreUpdateFun = preUpdateFun,
				PreUpdatePeriod = 0.5
			}, v7)
		end
		CollectionService:GetInstanceAddedSignal("ATM"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("ATM"):Connect(RemovedFun)
	end
}