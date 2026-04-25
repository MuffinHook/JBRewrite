-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local JetPackUtil = require(ReplicatedStorage.Game.JetPack.JetPackUtil)
local Animation = require(ReplicatedStorage.Module.Animation)
local Signal = require(ReplicatedStorage.Std.Signal)
local function Ease_InOutQuad(time)
	return time < 0.5 and 2 * time * time or -1 - 2 * (time - 2) * time
end
local function SelectIfGamepad(element)
	EzUtils.selectIfGamepad(element)
end
local t = {
	OnRefillClicked = Signal.new(),
	MaxFuel = 10
}
t.Fuel = t.MaxFuel
function t.Init()
	local guiClone = ReplicatedStorage.Resource.JetPack.JetPackGui:Clone()
	guiClone.Parent = LocalPlayer.PlayerGui
	guiClone.Refill.Exit.MouseButton1Down:Connect(function()
		guiClone.Refill.Visible = false
	end)
	guiClone.Refill.Left.Buy.MouseButton1Down:Connect(function()
		t.OnRefillClicked:Fire("Standard")
		guiClone.Refill.Visible = false
	end)
	guiClone.Refill.Right.Buy.MouseButton1Down:Connect(function()
		t.OnRefillClicked:Fire("Rocket")
		guiClone.Refill.Visible = false
	end)
	guiClone.Fuel.Refill.MouseButton1Down:Connect(function()
		t.OnRefillClicked:Fire("Standard")
	end)
	t.Gui = guiClone
end
function t.OpenFuel()
	local Gui = t.Gui
	if t.AnimFuel then
		t.AnimFuel:Destroy()
		t.AnimFuel = nil
	end
	Gui.Fuel.Meter.Visible = true
	Gui.Fuel.Meter.BackgroundTransparency = 1
	Gui.Fuel.Meter.Value.BackgroundTransparency = 1
	t.AnimFuel = Animation.new({
		Duration = 0.5,
		OnUpdate = function(progress, animationDuration, time)
			local easeValue, baseTime
			if time < 0.5 then
				easeValue = 2 * time * time
				if not easeValue then
					baseTime = time
					easeValue = -1 - 2 * (time - 2) * time
				end
			else
				baseTime = time
				easeValue = -1 - 2 * (time - 2) * time
			end
			Gui.Fuel.Meter.Value.Size = UDim2.new(easeValue * t.Fuel / t.MaxFuel, 0, 1, 0)
			Gui.Fuel.Meter.BackgroundTransparency = 1 - easeValue
			Gui.Fuel.Meter.Value.BackgroundTransparency = 1 - easeValue
		end,
		OnComplete = function()
			t.AnimFuel = nil
		end
	})
end
function t.CloseFuel()
	local Gui = t.Gui
	if t.AnimFuel then
		t.AnimFuel:Destroy()
		t.AnimFuel = nil
	end
	t.AnimFuel = Animation.new({
		Duration = 0.5,
		OnUpdate = function(progress, animationDuration, time)
			local easeValue, baseTime
			if time < 0.5 then
				easeValue = 2 * time * time
				if not easeValue then
					baseTime = time
					easeValue = -1 - 2 * (time - 2) * time
				end
			else
				baseTime = time
				easeValue = -1 - 2 * (time - 2) * time
			end
			local inverseEase = 1 - easeValue
			Gui.Fuel.Meter.BackgroundTransparency = 1 - inverseEase
			Gui.Fuel.Meter.Value.BackgroundTransparency = 1 - inverseEase
		end,
		OnComplete = function()
			Gui.Fuel.Meter.Visible = false
			t.AnimFuel = nil
		end
	})
end
function t.IsFuelAnimating()
	return t.AnimFuel ~= nil
end
function t.IsFuelOpen()
	return t.Gui.Fuel.Meter.Visible
end
function t.UpdateFuel(currentFuel, maxFuel)
	assert(currentFuel)
	assert(maxFuel)
	if t.AnimFuel then
		t.Fuel = currentFuel
		t.MaxFuel = maxFuel
	else
		if math.abs(currentFuel - t.Fuel) > 0.0001 then
			t.Fuel = currentFuel
			t.MaxFuel = maxFuel
			t.Gui.Fuel.Meter.Value.Size = UDim2.new(t.Fuel / t.MaxFuel, 0, 1, 0)
		end
	end
end
function t.SetFuelType(fuelType)
	assert(fuelType)
	local fuelData = JetPackUtil.Fuel[fuelType]
	assert(fuelData)
	t.Gui.Fuel.Meter.Value.BackgroundColor3 = fuelData.MeterColor
end
function t.FlashRefill()
	if t.FlashRefillOpen ~= true then
		t.FlashRefillOpen = true
		local Gui = t.Gui
		Gui.Fuel.Refill.Visible = true
		Gui.Fuel.Refill.Transparency = 1
		Animation.new({
			Duration = 0.5,
			OnUpdate = function(progress, animationDuration, time)
				Gui.Fuel.Refill.Transparency = 1 - (time < 0.5 and 2 * time * time or -1 - 2 * (time - 2) * time)
			end
		})
		task.delay(3, function()
			Animation.new({
				Duration = 0.5,
				OnUpdate = function(progress, animationDuration, time)
					Gui.Fuel.Refill.Transparency = time < 0.5 and 2 * time * time or -1 - 2 * (time - 2) * time
				end,
				OnComplete = function()
					Gui.Fuel.Refill.Visible = false
					t.FlashRefillOpen = false
				end
			})
		end)
	end
end
return t
