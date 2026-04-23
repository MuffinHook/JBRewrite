local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DuffelBagBinder = require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder)
local DuffelBagConsts = require(ReplicatedStorage.Game.DuffelBag.DuffelBagConsts)
local RobberyMoneyUI = require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Time = require(ReplicatedStorage.Module.Time)
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid_2 = require(ReplicatedStorage.Std.Maid)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local v1 = nil
local v2 = nil
local function PlaySound(p1, p2) --[[ Line: 18 ]]
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(p2)
	Sound.Volume = 0.75
	Sound.Parent = p1
	Sound:Play()
	delay(1, function() --[[ Line: 24 | Upvalues: Sound (copy) ]]
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 31 | Upvalues: t (copy), Maid_2 (copy) ]]
	assert(p1 ~= nil)
	assert(p2 ~= nil)
	local t2 = {}
	setmetatable(t2, t)
	local v4 = p2.Layout:GetChildren()[1]
	assert(v4 ~= nil)
	t2.ModelLayout = v4
	t2.Maid = Maid_2.new()
	t2.BornAtSync = p1
	if t2.ModelLayout:FindFirstChild("Lasers") then
		t2:SetupLasers(v4)
	end
	return t2
end
function t.SetupLasers(p1, p2) --[[ Line: 51 | Upvalues: RunService (copy), Time (copy) ]]
	local Lasers = p2:WaitForChild("Lasers")
	assert(Lasers)
	local t = {}
	for i, v in ipairs(Lasers:GetChildren()) do
		if v.Name == "Laser" or (v.Name == "LaserWall" or v.Name == "LaserTrack") then
			local v1 = 2
			if v.Name == "LaserWall" then
				v1 = 5
			elseif v.Name == "LaserTrack" then
				v1 = 7
			end
			local Part = v:WaitForChild("Part", 3)
			table.insert(t, {
				Part = Part,
				Origin = Part.CFrame,
				Target = v.End.CFrame,
				Period = v1
			})
		end
	end
	p1.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 74 | Upvalues: Time (ref), p1 (copy), t (copy) ]]
		local v1 = Time.GetNowSync() - p1.BornAtSync
		for i, v in ipairs(t) do
			v.Part.CFrame = v.Origin:lerp(v.Target, math.cos(v1 * (6.283185307179586 / v.Period)) * -0.5 + 0.5)
		end
	end))
	p1.Maid:GiveTask(function() --[[ Line: 82 | Upvalues: t (copy) ]]
		for i, v in ipairs(t) do
			v.Part.CFrame = v.Origin
		end
	end)
end
function t.Destroy(p1) --[[ Line: 88 ]]
	p1.Maid:Destroy()
	p1.Maid = nil
end
return {
	Init = function(p1) --[[ Name: Init | Line: 93 | Upvalues: v1 (ref), v2 (ref), LocalPlayer (copy), DuffelBagConsts (copy), RunService (copy), DuffelBagBinder (copy), RobberyMoneyUI (copy), t (copy), Audio (copy), Binder (copy), Maid (copy), CircleAction (copy) ]]
		local em = p1.em
		v1 = p1.Event
		v2 = em
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://1848209466"
		Sound.Looped = true
		Sound.Volume = 0
		Sound.SoundGroup = game:GetService("SoundService").RobberyMusic
		Sound.Parent = LocalPlayer.PlayerGui
		local v22 = nil
		local v3 = nil
		local v4 = nil
		function em.qqzqeh08(p1, p2, p3, p4) --[[ Line: 110 | Upvalues: v4 (ref), DuffelBagConsts (ref), RunService (ref), DuffelBagBinder (ref), RobberyMoneyUI (ref) ]]
			if not v4 then
				local v1 = nil
				local v2 = p4:FindFirstChild(DuffelBagConsts.MAXIMUM_VALUE_NAME)
				local v3 = p4:FindFirstChild(DuffelBagConsts.MULT_VALUE_NAME)
				local v42 = p4:FindFirstChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
				v4 = RunService.RenderStepped:Connect(function() --[[ Line: 118 | Upvalues: v1 (ref), DuffelBagBinder (ref), p4 (copy), p2 (copy), p1 (copy), p3 (copy), v42 (copy), v2 (copy), v3 (copy), RobberyMoneyUI (ref) ]]
					if not v1 then
						v1 = DuffelBagBinder:Get(p4)
					end
					if v1 and p4.Parent then
						local v22 = math.floor(p2 + (workspace:GetServerTimeNow() - p1) * p3)
						local v32 = v42.Value and math.ceil(v2.Value * v3.Value) or v2.Value
						RobberyMoneyUI.SetMoney(math.clamp(v22, 0, v32), v32, true)
					end
				end)
			end
		end
		function em.jpukwdz9(p1) --[[ Line: 131 | Upvalues: v4 (ref), DuffelBagConsts (ref) ]]
			if v4 then
				v4:Disconnect()
				v4 = nil
			end
			local v1 = p1 and p1:FindFirstChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
			if v1 then
				v1.Value = not v1.Value
				v1.Value = not v1.Value
			end
		end
		function em.d0ltid0f(p1, p2) --[[ Line: 143 | Upvalues: v3 (ref), t (ref), Audio (ref), LocalPlayer (ref), v22 (ref), Sound (copy) ]]
			assert(v3 == nil)
			assert(p2 ~= nil)
			v3 = t.new(p1, p2)
			Audio.ObjectLocal(LocalPlayer, 1837831244)
			delay(1, function() --[[ Line: 149 | Upvalues: Audio (ref), LocalPlayer (ref) ]]
				Audio.ObjectLocal(LocalPlayer, 1843025542)
			end)
			if v22 ~= nil then
				v22:Disconnect()
				v22 = nil
			end
			if Sound.Playing == false then
				Sound:Play()
			end
			v22 = Audio.FadeTo(Sound, 1, 5)
		end
		function em.zwfzfdnm() --[[ Line: 161 | Upvalues: v3 (ref), v22 (ref), Audio (ref), Sound (copy), v4 (ref) ]]
			if v3 ~= nil then
				v3:Destroy()
				v3 = nil
			end
			if v22 ~= nil then
				v22:Disconnect()
				v22 = nil
			end
			v22 = Audio.FadeTo(Sound, 0, 5, function() --[[ Line: 170 | Upvalues: Sound (ref) ]]
				Sound:Stop()
			end)
			if v4 then
				v4:Disconnect()
				v4 = nil
			end
		end
		Binder.new("BankDoorEscapeRoute", function(p1) --[[ Line: 179 | Upvalues: Maid (ref), v1 (ref), CircleAction (ref) ]]
			local v12 = Maid.new()
			local t = {
				Part = p1,
				Name = "Place Dynamite",
				Timed = true,
				Duration = 5,
				Dist = 8,
				Callback = function(p12, p2) --[[ Name: Action | Line: 182 | Upvalues: v1 (ref), p1 (copy) ]]
					if p2 then
						v1:FireServer("b" .. ("uxo0p3bs0ymu4"):sub(5, 9):reverse() .. "pj", p1)
					end
					return true
				end
			}
			local function update() --[[ Line: 197 | Upvalues: t (copy), p1 (copy) ]]
				t.Enabled = p1:GetAttribute("Open") == nil
			end
			t.Enabled = p1:GetAttribute("Open") == nil
			v12:GiveTask(CircleAction.Add(t, p1))
			v12:GiveTask(p1:GetAttributeChangedSignal("Open"):Connect(update))
			return v12
		end):Start()
		Binder.new("BankTopFloorButton", function(p1) --[[ Line: 207 | Upvalues: Maid (ref), Audio (ref), CircleAction (ref) ]]
			local v1 = Maid.new()
			local t = {
				Part = p1,
				Name = "Open Shutters",
				Timed = false,
				Dist = 8,
				Callback = function(p12, p2) --[[ Name: action | Line: 209 | Upvalues: Audio (ref), p1 (copy) ]]
					if p2 then
						Audio.ObjectLocal(p1, 9553471217, {
							Volume = 0.5
						})
						p1:FindFirstChild("OpenTopFloorRemote"):FireServer()
					end
					return true
				end
			}
			local function update() --[[ Line: 223 | Upvalues: t (copy), p1 (copy) ]]
				t.Enabled = p1:GetAttribute("ButtonDisabled") ~= true
			end
			t.Enabled = p1:GetAttribute("ButtonDisabled") ~= true
			v1:GiveTask(CircleAction.Add(t, p1))
			v1:GiveTask(p1:GetAttributeChangedSignal("ButtonDisabled"):Connect(update))
			return v1
		end):Start()
	end
}