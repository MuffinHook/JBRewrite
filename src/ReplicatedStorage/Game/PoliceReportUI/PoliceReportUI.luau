-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Math = require(ReplicatedStorage.Module.Math)
local t = {}
function t.Init()
	local PoliceReportGui = ReplicatedStorage.StarterGui:FindFirstChild("PoliceReportGui")
	PoliceReportGui.Parent = LocalPlayer.PlayerGui
	t.Gui = PoliceReportGui
end
function t.Display(reportData)
	if t.IsOpen() then
		t.Hide()
	end
	local Gui = t.Gui
	local maid = Maid.new()
	t.Maid = maid
	local List = Gui.Container.Top.List
	local sum = 0
	for i, v in ipairs(reportData) do
		local isAmount, hasSubtitle
		local reportTitle = assert(v.Title)
		local reportAmount = assert(v.Amount)
		isAmount = type(reportAmount) == "number"
		assert(isAmount)
		local SubTitle = v.SubTitle
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
		t.Hide()
	end))
	Gui.Enabled = true
	task.delay(5, function()
		if maid == t.Maid then
			t.Hide()
		end
	end)
end
function t.Hide()
	local Gui = t.Gui
	if t.IsOpen() then
		t.Maid:Destroy()
		t.Maid = nil
		Gui.Enabled = false
	end
end
function t.IsOpen()
	return t.Maid ~= nil
end
return t
