game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
require(ReplicatedStorage.App.RunUtils)
local function _(p1, p2) --[[ Unused ]]
	for v1, v2 in p1.Part:GetChildren() do
		local ParticleEmitter = v2:FindFirstChildOfClass("ParticleEmitter")
		local Sound = v2:FindFirstChildOfClass("Sound")
		if ParticleEmitter then
			ParticleEmitter.Enabled = p2
		end
		if Sound then
			Sound.Playing = p2
		end
	end
end
local function _() --[[ Unused | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref) ]]
	if not (v1 <= 0) then
		local v12 = workspace:GetServerTimeNow()
		for v22, v32 in v2 do
			local v42 = (v12 + v32.Offset) % v3.Total
			if v42 < v3.RestingTime then
				if v32.Phase == "Resting" then
					_ = v22
					_2 = v32
					break
				end
				v32.Phase = "Resting"
				v4(v32, false)
				v32.Part.CFrame = v32.Origin
			elseif v42 < v3.RestingTime + v3.ActivatingTime then
				if v32.Phase == "Activating" then
					_ = v22
					_2 = v32
					break
				end
				v32.Phase = "Activating"
				v4(v32, true)
			elseif v42 < v3.RestingTime + v3.ActivatingTime + v3.UpTime then
				if v32.Phase ~= "Up" then
					v4(v32, true)
					v32.Phase = "Up"
				end
				v32.Part.CFrame = v32.Origin:Lerp(v32.Up, (v42 - (v3.RestingTime + v3.ActivatingTime)) / v3.UpTime)
			elseif v42 < v3.RestingTime + v3.ActivatingTime + v3.UpTime + v3.AirTime then
				if v32.Phase ~= "Air" then
					v4(v32, false)
					v32.Phase = "Air"
				end
				local v6 = math.noise(v12 * v3.SwaySpeed * v3.SwayAmount)
				local v7 = math.noise(v12 * v3.SwaySpeed * 0.8 * v3.SwayAmount * 0.5)
				local v9 = math.sin(v12 * v3.SwaySpeed)
				local v10 = v9 * math.rad(v3.SwayTilt)
				local v122 = math.cos(v12 * v3.SwaySpeed * 0.8)
				local v13 = v122 * math.rad(v3.SwayTilt)
				v32.Part.CFrame = v32.Pivot * CFrame.Angles(v10, 0, v13) * CFrame.new(v6, 0, v7) * v32.Pivot:ToObjectSpace(v32.Up)
			else
				if v32.Phase ~= "Down" then
					v32.Phase = "Down"
				end
				v32.Part.CFrame = v32.Up:Lerp(v32.Origin, (v42 - (v3.RestingTime + v3.ActivatingTime + v3.UpTime + v3.AirTime)) / v3.DownTime)
			end
		end
	end
end
local function _(p1) --[[ Unused | Upvalues: v5 (ref), v6 (ref), v7 (ref) ]]
	local t = {
		Offset = p1:GetAttribute("Offset") or 0,
		Part = p1:WaitForChild("Main"),
		Origin = p1.Main.CFrame
	}
	t.Up = p1.Main.CFrame + Vector3.new(0, v6.UpDist, 0)
	t.Pivot = p1.Main.CFrame + Vector3.new(0, v6.UpDist + v6.UpPivot, 0)
	t.Phase = "Resting"
	v5[p1] = t
	v7 = v7 + 1
end
local function _(p1) --[[ Unused | Upvalues: v8 (ref), v9 (ref) ]]
	if v8[p1] then
		if v8[p1].Part then
			v8[p1].Part.CFrame = v8[p1].Origin
		end
		v8[p1] = nil
		v9 = v9 - 1
	end
end