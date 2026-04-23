local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
require(ReplicatedStorage.Std.Promise)
game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local function EphThread(p1, p2) --[[ Line: 7 | Upvalues: RunService (copy) ]]
	local v1 = tick()
	local v2 = nil
	v2 = RunService.Heartbeat:Connect(function() --[[ Line: 10 | Upvalues: p1 (copy), v1 (copy), p2 (copy), v2 (ref) ]]
		local v12 = tick()
		if p1 then
			local v22 = (v12 - v1) / p1
			local v3
			if v22 >= 1 then
				v22 = 1
				v3 = true
			else
				v3 = false
			end
			if p2(v22) then
				v3 = true
			end
			if v3 then
				v2:Disconnect()
			end
		elseif p2(v12 - v1) then
			v2:Disconnect()
		end
	end)
end
local t = {}
local function AnimateDoor(p1, p2, p3) --[[ Line: 34 | Upvalues: t (copy), RunService (copy) ]]
	if t[p1] then
		return false
	end
	t[p1] = true
	local v1 = p1:GetChildren()
	local v2 = v1[1]
	local v3 = v1[2]
	local Unit = (v3.Position - v2.Position).Unit
	local v4 = v2.CFrame
	local v5 = v3.CFrame
	local v6 = v4 - Unit * p2
	local v7 = v5 + Unit * p2
	v2.CanCollide = false
	v3.CanCollide = false
	local v8 = p3 * 0.5
	local function f9(p1) --[[ Line: 47 | Upvalues: v2 (copy), v4 (copy), v6 (copy), v3 (copy), v5 (copy), v7 (copy) ]]
		v2.CFrame = v4:lerp(v6, p1)
		v3.CFrame = v5:lerp(v7, p1)
	end
	local v10 = tick()
	local v11 = nil
	v11 = RunService.Heartbeat:Connect(function() --[[ Line: 10 | Upvalues: v8 (copy), v10 (copy), f9 (copy), v11 (ref) ]]
		local v1 = tick()
		if v8 then
			local v2 = (v1 - v10) / v8
			local v3
			if v2 >= 1 then
				v2 = 1
				v3 = true
			else
				v3 = false
			end
			if f9(v2) then
				v3 = true
			end
			if v3 then
				v11:Disconnect()
			end
		elseif f9(v1 - v10) then
			v11:Disconnect()
		end
	end)
	delay(p3 * 0.5 + 1, function() --[[ Line: 51 | Upvalues: p3 (copy), v2 (copy), v6 (copy), v4 (copy), v3 (copy), v7 (copy), v5 (copy), RunService (ref) ]]
		local v1 = p3 * 0.5
		local function f2(p1) --[[ Line: 52 | Upvalues: v2 (ref), v6 (ref), v4 (ref), v3 (ref), v7 (ref), v5 (ref) ]]
			v2.CFrame = v6:lerp(v4, p1)
			v3.CFrame = v7:lerp(v5, p1)
		end
		local v32 = tick()
		local v42 = nil
		v42 = RunService.Heartbeat:Connect(function() --[[ Line: 10 | Upvalues: v1 (copy), v32 (copy), f2 (copy), v42 (ref) ]]
			local v12 = tick()
			if v1 then
				local v2 = (v12 - v32) / v1
				local v3
				if v2 >= 1 then
					v2 = 1
					v3 = true
				else
					v3 = false
				end
				if f2(v2) then
					v3 = true
				end
				if v3 then
					v42:Disconnect()
				end
			elseif f2(v12 - v32) then
				v42:Disconnect()
			end
		end)
	end)
	delay(p3 + 1.1, function() --[[ Line: 57 | Upvalues: v2 (copy), v3 (copy), t (ref), p1 (copy) ]]
		v2.CanCollide = true
		v3.CanCollide = true
		t[p1] = nil
	end)
end
return {
	Init = function(p1) --[[ Name: Init | Line: 64 | Upvalues: AnimateDoor (copy), DoorUtils (copy), RunService (copy) ]]
		local _ = p1.Event
		local em = p1.em
		function em.ukfy8gb8(p1, p2, p3) --[[ Line: 67 | Upvalues: AnimateDoor (ref) ]]
			AnimateDoor(p1, p2, p3)
		end
		function em.hfdr6rmx(p1, p2) --[[ Line: 70 | Upvalues: DoorUtils (ref) ]]
			DoorUtils.setOpen(p1, p2)
		end
		local v1 = false
		function em.bsjrqs6c(p1, p2) --[[ Line: 75 | Upvalues: v1 (ref), RunService (ref) ]]
			if v1 then
				return false
			end
			v1 = true
			delay(0, function() --[[ Line: 80 | Upvalues: p1 (copy), p2 (copy), RunService (ref) ]]
				local function f1(p12) --[[ Line: 81 | Upvalues: p1 (ref), p2 (ref) ]]
					p1:SetPrimaryPartCFrame(p2 + Vector3.new(0, 20, 0) * p12)
				end
				local v2 = tick()
				local v3 = nil
				local v4 = 2
				v3 = RunService.Heartbeat:Connect(function() --[[ Line: 10 | Upvalues: v4 (copy), v2 (copy), f1 (copy), v3 (ref) ]]
					local v1 = tick()
					if v4 then
						local v22 = (v1 - v2) / v4
						local v32
						if v22 >= 1 then
							v22 = 1
							v32 = true
						else
							v32 = false
						end
						if f1(v22) then
							v32 = true
						end
						if v32 then
							v3:Disconnect()
						end
					elseif f1(v1 - v2) then
						v3:Disconnect()
					end
				end)
			end)
			delay(4, function() --[[ Line: 85 | Upvalues: p1 (copy), p2 (copy), RunService (ref) ]]
				local function f1(p12) --[[ Line: 86 | Upvalues: p1 (ref), p2 (ref) ]]
					p1:SetPrimaryPartCFrame(p2 + Vector3.new(0, 20, 0) * (1 - p12))
				end
				local v2 = tick()
				local v3 = nil
				local v4 = 2
				v3 = RunService.Heartbeat:Connect(function() --[[ Line: 10 | Upvalues: v4 (copy), v2 (copy), f1 (copy), v3 (ref) ]]
					local v1 = tick()
					if v4 then
						local v22 = (v1 - v2) / v4
						local v32
						if v22 >= 1 then
							v22 = 1
							v32 = true
						else
							v32 = false
						end
						if f1(v22) then
							v32 = true
						end
						if v32 then
							v3:Disconnect()
						end
					elseif f1(v1 - v2) then
						v3:Disconnect()
					end
				end)
			end)
			wait(6)
			v1 = false
		end
	end
}