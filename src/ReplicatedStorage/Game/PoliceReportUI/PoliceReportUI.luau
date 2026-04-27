local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Math = require(ReplicatedStorage.Module.Math)
local PoliceReportUI = {}
function PoliceReportUI.Init()
	local PoliceReportGui = ReplicatedStorage.StarterGui:FindFirstChild("PoliceReportGui")
	PoliceReportGui.Parent = LocalPlayer.PlayerGui
	PoliceReportUI.Gui = PoliceReportGui
end
function PoliceReportUI.Display(reportData)
	if PoliceReportUI.IsOpen() then
		PoliceReportUI.Hide()
	end
	local Gui = PoliceReportUI.Gui
	local maid = Maid.new()
	PoliceReportUI.Maid = maid
	local List = Gui.Container.Top.List
	local sum = 0
	for i, reportEntry in ipairs(reportData) do
		local isAmount, hasSubtitle
		local reportTitle = assert(reportEntry.Title)
		local reportAmount = assert(reportEntry.Amount)
		isAmount = type(reportAmount) == "number"
		assert(isAmount)
		local SubTitle = reportEntry.SubTitle
		local reportItem = List.Preset:Clone()
		reportItem.LayoutOrder = i
		reportItem.Parent = List
		reportItem.Title.Text = reportTitle
		reportItem.Amount.Text = Math.FormatMoney(reportAmount)
		if SubTitle ~= nil then
			reportItem.SubTitle.Text = SubTitle
		end
		hasSubtitle = SubTitle ~= nil
		reportItem.SubTitle.Visible = hasSubtitle
		reportItem.Visible = true
		maid:GiveTask(reportItem)
		sum = sum + reportAmount
	end
	Gui.Container.Bottom.Container.Sum.Text = ("+%s"):format(Math.FormatMoney(sum))
	maid:GiveTask(Gui.Container.Close.MouseButton1Down:Connect(function()
		PoliceReportUI.Hide()
	end))
	Gui.Enabled = true
	task.delay(5, function()
		if maid == PoliceReportUI.Maid then
			PoliceReportUI.Hide()
		end
	end)
end
function PoliceReportUI.Hide()
	local Gui = PoliceReportUI.Gui
	if PoliceReportUI.IsOpen() then
		PoliceReportUI.Maid:Destroy()
		PoliceReportUI.Maid = nil
		Gui.Enabled = false
	end
end
function PoliceReportUI.IsOpen()
	return PoliceReportUI.Maid ~= nil
end
return PoliceReportUI
