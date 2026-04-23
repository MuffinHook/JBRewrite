local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local JetPackUtil = require(ReplicatedStorage.Game.JetPack.JetPackUtil)
local Animation = require(ReplicatedStorage.Module.Animation)
local Signal = require(ReplicatedStorage.Std.Signal)
local function Ease_InOutQuad(p1) --[[ Line: 13 ]]
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local function SelectIfGamepad(p1) --[[ Line: 19 | Upvalues: EzUtils (copy) ]]
	EzUtils.selectIfGamepad(p1)
end
local t = {
	OnRefillClicked = Signal.new(),
	MaxFuel = 10
}
t.Fuel = t.MaxFuel
function t.Init() --[[ Line: 27 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t (copy) ]]
	local v1 = ReplicatedStorage.Resource.JetPack.JetPackGui:Clone()
	v1.Parent = LocalPlayer.PlayerGui
	v1.Refill.Exit.MouseButton1Down:Connect(function() --[[ Line: 32 | Upvalues: v1 (ref) ]]
		v1.Refill.Visible = false
	end)
	v1.Refill.Left.Buy.MouseButton1Down:Connect(function() --[[ Line: 35 | Upvalues: t (ref), v1 (ref) ]]
		t.OnRefillClicked:Fire("Standard")
		v1.Refill.Visible = false
	end)
	v1.Refill.Right.Buy.MouseButton1Down:Connect(function() --[[ Line: 39 | Upvalues: t (ref), v1 (ref) ]]
		t.OnRefillClicked:Fire("Rocket")
		v1.Refill.Visible = false
	end)
	v1.Fuel.Refill.MouseButton1Down:Connect(function() --[[ Line: 43 | Upvalues: t (ref) ]]
		t.OnRefillClicked:Fire("Standard")
	end)
	t.Gui = v1
end
function t.OpenFuel() --[[ Line: 56 | Upvalues: t (copy), Animation (copy) ]]
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
		OnUpdate = function(p1, p2, p3) --[[ Name: OnUpdate | Line: 69 | Upvalues: Gui (copy), t (ref) ]]
			local v1, v2
			if p3 < 0.5 then
				v1 = 2 * p3 * p3
				if not v1 then
					v2 = p3
					v1 = -1 - 2 * (p3 - 2) * p3
				end
			else
				v2 = p3
				v1 = -1 - 2 * (p3 - 2) * p3
			end
			Gui.Fuel.Meter.Value.Size = UDim2.new(v1 * t.Fuel / t.MaxFuel, 0, 1, 0)
			Gui.Fuel.Meter.BackgroundTransparency = 1 - v1
			Gui.Fuel.Meter.Value.BackgroundTransparency = 1 - v1
		end,
		OnComplete = function() --[[ Name: OnComplete | Line: 75 | Upvalues: t (ref) ]]
			t.AnimFuel = nil
		end
	})
end
function t.CloseFuel() --[[ Line: 80 | Upvalues: t (copy), Animation (copy) ]]
	local Gui = t.Gui
	if t.AnimFuel then
		t.AnimFuel:Destroy()
		t.AnimFuel = nil
	end
	t.AnimFuel = Animation.new({
		Duration = 0.5,
		OnUpdate = function(p1, p2, p3) --[[ Name: OnUpdate | Line: 89 | Upvalues: Gui (copy) ]]
			local v1, v2
			if p3 < 0.5 then
				v1 = 2 * p3 * p3
				if not v1 then
					v2 = p3
					v1 = -1 - 2 * (p3 - 2) * p3
				end
			else
				v2 = p3
				v1 = -1 - 2 * (p3 - 2) * p3
			end
			local v3 = 1 - v1
			Gui.Fuel.Meter.BackgroundTransparency = 1 - v3
			Gui.Fuel.Meter.Value.BackgroundTransparency = 1 - v3
		end,
		OnComplete = function() --[[ Name: OnComplete | Line: 95 | Upvalues: Gui (copy), t (ref) ]]
			Gui.Fuel.Meter.Visible = false
			t.AnimFuel = nil
		end
	})
end
function t.IsFuelAnimating() --[[ Line: 101 | Upvalues: t (copy) ]]
	return t.AnimFuel ~= nil
end
function t.IsFuelOpen() --[[ Line: 104 | Upvalues: t (copy) ]]
	return t.Gui.Fuel.Meter.Visible
end
function t.UpdateFuel(p1, p2) --[[ Line: 107 | Upvalues: t (copy) ]]
	assert(p1)
	assert(p2)
	if t.AnimFuel then
		t.Fuel = p1
		t.MaxFuel = p2
	else
		if math.abs(p1 - t.Fuel) > 0.0001 then
			t.Fuel = p1
			t.MaxFuel = p2
			t.Gui.Fuel.Meter.Value.Size = UDim2.new(t.Fuel / t.MaxFuel, 0, 1, 0)
		end
	end
end
function t.SetFuelType(p1) --[[ Line: 119 | Upvalues: JetPackUtil (copy), t (copy) ]]
	assert(p1)
	local v1 = JetPackUtil.Fuel[p1]
	assert(v1)
	t.Gui.Fuel.Meter.Value.BackgroundColor3 = v1.MeterColor
end
function t.FlashRefill() --[[ Line: 126 | Upvalues: t (copy), Animation (copy) ]]
	if t.FlashRefillOpen ~= true then
		t.FlashRefillOpen = true
		local Gui = t.Gui
		Gui.Fuel.Refill.Visible = true
		Gui.Fuel.Refill.Transparency = 1
		Animation.new({
			Duration = 0.5,
			OnUpdate = function(p1, p2, p3) --[[ Name: OnUpdate | Line: 135 | Upvalues: Gui (copy) ]]
				Gui.Fuel.Refill.Transparency = 1 - (p3 < 0.5 and 2 * p3 * p3 or -1 - 2 * (p3 - 2) * p3)
			end
		})
		task.delay(3, function() --[[ Line: 139 | Upvalues: Gui (copy), t (ref), Animation (ref) ]]
			Animation.new({
				Duration = 0.5,
				OnUpdate = function(p1, p2, p3) --[[ Name: OnUpdate | Line: 141 | Upvalues: Gui (ref) ]]
					Gui.Fuel.Refill.Transparency = p3 < 0.5 and 2 * p3 * p3 or -1 - 2 * (p3 - 2) * p3
				end,
				OnComplete = function() --[[ Name: OnComplete | Line: 144 | Upvalues: Gui (ref), t (ref) ]]
					Gui.Fuel.Refill.Visible = false
					t.FlashRefillOpen = false
				end
			})
		end)
	end
end
return t