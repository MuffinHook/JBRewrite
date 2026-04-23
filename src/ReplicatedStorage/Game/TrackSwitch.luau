local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetSync = require(ReplicatedStorage.Module.NetSync)
local Audio = require(ReplicatedStorage.Std.Audio)
local RunService = game:GetService("RunService")
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 10 | Upvalues: t (copy), RunService (copy) ]]
	local v2 = setmetatable({}, t)
	local v3 = tick()
	local function Heartbeat(p1) --[[ Line: 13 | Upvalues: v3 (copy), v2 (copy), p2 (copy) ]]
		local v1 = tick() - v3
		if v1 >= 1 then
			v2.Event:Disconnect()
			v2.Done = true
			v1 = 1
		end
		p2(v1, p1)
	end
	v2.Event = RunService.Heartbeat:Connect(Heartbeat)
	v2.Done = false
	return v2
end
function t.Destroy(p1) --[[ Line: 27 ]]
	p1.Event:Disconnect()
	p1.Event = nil
	p1.Done = true
end
return {
	Init = function(p1) --[[ Name: Init | Line: 33 | Upvalues: t (copy), Audio (copy), NetSync (copy) ]]
		local _ = p1.Event
		local em = p1.em
		local v1 = nil
		local function Update(p1) --[[ Line: 59 | Upvalues: v1 (ref), t (ref), Audio (ref) ]]
			if not p1.Tagged then
				return false
			end
			if p1.Type ~= "TrackSwitch" then
				return false
			end
			if v1 and not v1.Done then
				v1:Destroy()
			end
			local Inst = p1.Inst
			local Rail = Inst.Parent.Parent.Rail
			local Invert = Rail:FindFirstChild("Invert")
			local v12 = if p1.Flipped then 0 else 1
			Rail.Transparency = Invert and 1 - v12 or v12
			local v3 = Inst.Parent
			v3.PrimaryPart = v3.Root
			local Root = v3.Parent.Model.Root
			v1 = t.new(0.5, function(p12, p2) --[[ Line: 81 | Upvalues: p1 (copy), v3 (copy), Root (copy) ]]
				p1.Rot = if p1.Flipped then -0.9424777960769379 else 0 * p12 + (p1.Rot or 0) * (1 - p12)
				v3:SetPrimaryPartCFrame(Root.CFrame * CFrame.Angles(0, 0, p1.Rot))
			end)
			Audio.ObjectLocal(Inst, 2803301098)
		end
		NetSync.Signals.InstAddedSignal:Connect(Update)
		NetSync.Signals.UpdatedSignal:Connect(Update)
	end
}