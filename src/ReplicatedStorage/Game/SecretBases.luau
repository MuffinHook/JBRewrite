-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
require(ReplicatedStorage.Std.Promise)
game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local function EphThread(p1, p2)
	local v1 = tick()
	local v2 = nil
	v2 = RunService.Heartbeat:Connect(function()
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
local function AnimateDoor(p1, p2, p3)
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
	local function f9(p1)
		v2.CFrame = v4:lerp(v6, p1)
		v3.CFrame = v5:lerp(v7, p1)
	end
	local v10 = tick()
	local v11 = nil
	v11 = RunService.Heartbeat:Connect(function()
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
	delay(p3 * 0.5 + 1, function()
		local v1 = p3 * 0.5
		local function f2(p1)
			v2.CFrame = v6:lerp(v4, p1)
			v3.CFrame = v7:lerp(v5, p1)
		end
		local v32 = tick()
		local v42 = nil
		v42 = RunService.Heartbeat:Connect(function()
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
	delay(p3 + 1.1, function()
		v2.CanCollide = true
		v3.CanCollide = true
		t[p1] = nil
	end)
end
return {
	Init = function(p1)
		local _ = p1.Event
		local em = p1.em
		function em.ukfy8gb8(p1, p2, p3)
			AnimateDoor(p1, p2, p3)
		end
		function em.hfdr6rmx(p1, p2)
			DoorUtils.setOpen(p1, p2)
		end
		local v1 = false
		function em.bsjrqs6c(p1, p2)
			if v1 then
				return false
			end
			v1 = true
			delay(0, function()
				local function f1(p12)
					p1:SetPrimaryPartCFrame(p2 + Vector3.new(0, 20, 0) * p12)
				end
				local v2 = tick()
				local v3 = nil
				local v4 = 2
				v3 = RunService.Heartbeat:Connect(function()
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
			delay(4, function()
				local function f1(p12)
					p1:SetPrimaryPartCFrame(p2 + Vector3.new(0, 20, 0) * (1 - p12))
				end
				local v2 = tick()
				local v3 = nil
				local v4 = 2
				v3 = RunService.Heartbeat:Connect(function()
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
