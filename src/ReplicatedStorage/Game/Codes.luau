game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AlexWM = require(ReplicatedStorage.Module.AlexWM)
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
return {
	Init = function(service)
		local CodesGui = ReplicatedStorage.StarterGui:FindFirstChild("CodesGui")
		CodesGui.Parent = LocalPlayer.PlayerGui
		local codeEvent = service.Event
		local function WindowOpen()
			CodesGui.Enabled = true
		end
		local function WindowClose()
			CodesGui.Enabled = false
		end
		local function RemovedFun(atmPart)
			CircleAction.Remove(atmPart)
			return true
		end
		local codesWindow = AlexWM.MakeWindow()
		codesWindow.OpenFun = WindowOpen
		codesWindow.CloseFun = WindowClose
		AlexWM.WindowGroupAdd(service.MainWindowGroup, codesWindow)
		CodesGui.CodeContainer.Close.MouseButton1Down:Connect(function()
			AlexWM.WindowClose(codesWindow)
		end)
		local function preUpdateFun(guiElement)
			guiElement.Enabled = not codesWindow.IsOpen
		end
		local function action(guiElement, isActivated)
			if isActivated then
				AlexWM.WindowOpen(codesWindow)
				guiElement.Enabled = not codesWindow.IsOpen
			end
		end
		local function AddedFun(atmPart)
			CircleAction.Add({
				Part = atmPart,
				Name = "Open ATM",
				Timed = false,
				Dist = 7,
				Callback = action,
				ValidRoot = atmPart.Parent,
				PreUpdateFun = preUpdateFun,
				PreUpdatePeriod = 0.5
			}, atmPart)
			return true
		end
		local function Submit()
			local Text = CodesGui.CodeContainer.Background.CodeContainer.Code.Text
			if #Text <= 0 or #Text >= 30 then
				return false
			end
			CodesGui.CodeContainer.Background.CodeContainer.Code.Text = ""
			codeEvent:FireServer("khwitohx", Text)
			AlexWM.WindowClose(codesWindow)
		end
		CodesGui.CodeContainer.Background.Redeem.MouseButton1Down:Connect(Submit)
		CodesGui.CodeContainer.Background.CodeContainer.Code.FocusLost:Connect(function(focusEvent)
			if focusEvent then
				Submit()
			end
		end)
		local nextIterator = next
		local atmInstances, iterationState = CollectionService:GetTagged("ATM")
		for index, atmInstance in nextIterator, atmInstances, iterationState do
			CircleAction.Add({
				Part = atmInstance,
				Name = "Open ATM",
				Timed = false,
				Dist = 7,
				Callback = action,
				ValidRoot = atmInstance.Parent,
				PreUpdateFun = preUpdateFun,
				PreUpdatePeriod = 0.5
			}, atmInstance)
		end
		CollectionService:GetInstanceAddedSignal("ATM"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("ATM"):Connect(RemovedFun)
	end
}
