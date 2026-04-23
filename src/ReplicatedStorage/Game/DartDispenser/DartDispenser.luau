local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local DartDispenserConsts = require(script.Parent.DartDispenserConsts)
local v1 = Random.new()
local Darts = Instance.new("Folder")
Darts.Name = "Darts"
Darts.Parent = workspace
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 20 | Upvalues: t (copy), Maid (copy), DartDispenserConsts (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._maid:GiveTask(p1:WaitForChild(DartDispenserConsts.FIRE_REMOTE_NAME).OnClientEvent:Connect(function() --[[ Line: 27 | Upvalues: t2 (copy), p1 (copy) ]]
		t2:_fire(p1)
	end))
	t2._damageRemote = p1:WaitForChild(DartDispenserConsts.DAMAGE_REMOTE_NAME)
	return t2
end
function t._fire(p1, p2) --[[ Line: 34 | Upvalues: v1 (copy), ReplicatedStorage (copy), Darts (copy), Audio (copy), SimulatedPhysicsProjectile (copy), LocalPlayer (copy), Spring (copy), RunService (copy) ]]
	local v12 = v1:NextInteger(1, 1000000000)
	local v2 = ("update_%d"):format(v12)
	local v3 = ("part_%d"):format(v12)
	local v6 = p2.CFrame * Vector3.new(0, 0, -p2.Size.Z * 0.5)
	local v7 = ReplicatedStorage.Resource.Robbery.Tomb:FindFirstChild("Arrow"):Clone()
	v7.Parent = Darts
	local PrimaryPart = v7.PrimaryPart
	p1._maid[v3] = v7
	Audio.ObjectLocal(p2, 6856219972, {
		Volume = 0.6,
		RollOffMaxDistance = 128
	})
	local v8 = SimulatedPhysicsProjectile.new(v6)
	function v8.CollidableFunc(p1) --[[ Line: 58 | Upvalues: LocalPlayer (ref) ]]
		return if p1.Parent == LocalPlayer.Character then true else p1:IsA("Terrain")
	end
	v8.IgnoreList = { Darts }
	v8._GravityVector = v8._GravityVector / 20
	v8.Velocity = p2.CFrame.LookVector * 300
	local v9 = v6
	local LookVector = p2.CFrame.LookVector
	local v10 = nil
	local v11 = nil
	local v122 = nil
	local v13 = Spring.new(0, 0, 0.3, 30)
	local v14 = os.clock()
	p1._maid[v2] = RunService.Heartbeat:Connect(function() --[[ Line: 71 | Upvalues: v10 (ref), v8 (copy), v9 (ref), PrimaryPart (copy), v122 (ref), LookVector (ref), v13 (copy), v11 (ref), Audio (ref), LocalPlayer (ref), p1 (copy), v7 (ref), v2 (copy), v3 (copy), v14 (copy) ]]
		if v10 then
			local v1, v22 = v13:Update()
			if math.abs(v1) < 0.001 and math.abs(v22) < 0.001 then
				p1._maid[v2] = nil
				p1._maid[v3] = nil
				return
			end
			v7:SetPrimaryPartCFrame(v10.CFrame * v11 * CFrame.fromAxisAngle(v122, v1) * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5))
		else
			local v32, v4, v5 = v8:Step(v8:_GetNow(), v9)
			local v6 = CFrame.new(v9, v32) * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5)
			local LookVector_2 = v6.LookVector
			if v4 then
				v122 = LookVector:Cross(LookVector_2)
				v13:Accelerate(20)
				local v72 = CFrame.new(v32, v32 + LookVector_2)
				v6 = v72 * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5)
				v10 = v5
				v11 = v5.CFrame:ToObjectSpace(v72)
				Audio.ObjectLocal(PrimaryPart, 6856219902, {
					Volume = 0.6,
					RollOffMaxDistance = 128
				})
				if v5:IsDescendantOf(LocalPlayer.Character) then
					p1._damageRemote:FireServer()
				end
			end
			v7:SetPrimaryPartCFrame(v6)
			LookVector = LookVector_2
			v9 = v32
		end
		if os.clock() - v14 > 3 then
			p1._maid[v2] = nil
			p1._maid[v3] = nil
		end
	end)
end
function t.Destroy(p1) --[[ Line: 113 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
end
return t