local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local CurrentCamera = workspace.CurrentCamera
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local t = {
	list = {},
	onForceUpdate = Signal.new()
}
function t.add(p1) --[[ Line: 15 | Upvalues: t (copy), Roact (copy), AccelTween (copy), CurrentCamera (copy), GeomUtils (copy), RunService (copy), MinimapService (copy) ]]
	local key = p1.key
	if not key then
		key = tostring(math.random() * 10000)
	end
	p1.key = key
	p1.key = "damageIndicator_" .. p1.key
	p1.bornAt = os.clock()
	p1.strength = p1.strength or 1
	assert(if p1.strength > 0 then p1.strength <= 1 else false, "strength must be (0, 1]")
	p1.lifetime = p1.lifetime or 1
	p1.color = p1.color or Color3.new(255/255, 0/255, 0/255)
	local v4 = nil
	for i = 1, #t.list do
		local v5 = t.list[i]
		if v5.key == p1.key then
			v4 = v5
			break
		end
	end
	if not v4 then
		local v6, v7 = Roact.createBinding(0)
		p1.angle = v6
		p1.updateAngle = v7
		local v8, v9 = Roact.createBinding(0)
		p1.transparency = v8
		p1.updateTransparency = v9
		table.insert(t.list, p1)
		local v10 = AccelTween.new()
		v10.a = 10
		v10.p = 0
		v10.t = 1
		local rtime = v10.rtime
		v10.a = 500
		v10.p = 1
		v10.t = 0
		local v11 = nil
		local function getAngle() --[[ Line: 59 | Upvalues: CurrentCamera (ref), p1 (copy) ]]
			local v1 = CurrentCamera.CFrame:PointToObjectSpace(p1.worldPosition)
			return math.atan2(-v1.x, -v1.z)
		end
		local v12 = CurrentCamera.CFrame:PointToObjectSpace(p1.worldPosition)
		local v15 = math.atan2(-v12.x, -v12.z)
		local function update() --[[ Line: 64 | Upvalues: p1 (copy), CurrentCamera (ref), v15 (ref), GeomUtils (ref), v10 (copy), rtime (copy), v11 (ref) ]]
			local bornAt = p1.bornAt
			local v1 = CurrentCamera.CFrame:PointToObjectSpace(p1.worldPosition)
			v15 = v15 + GeomUtils.shortAngleDist(v15, (math.atan2(-v1.x, -v1.z))) / 5
			p1.updateAngle(-1.5707963267948966 - v15)
			local p = v10.p
			p1.updateTransparency((1 - p1.strength) * (1 - p) + 1 * p)
			local v6 = os.clock()
			if v6 - bornAt > p1.lifetime - rtime then
				if v10.t ~= 1 then
					v10.a = 10
					v10.v = 0
					v10.t = 1
				end
			elseif v10.t ~= 0 then
				v10.a = 500
				v10.v = 0
				v10.t = 0
			end
			if v6 - bornAt > p1.lifetime then
				v11()
			end
		end
		update()
		local v16 = RunService.Heartbeat:Connect(update)
		t.onForceUpdate:Fire()
		local t2 = {
			name = p1.key,
			worldPosition = p1.worldPosition,
			flash = false
		}
		local v17, v18 = Roact.createBinding(Color3.new(255/255, 0/255, 0/255))
		t2.color = v17
		t2.updateColor = v18
		local v19 = MinimapService.add(t2)
		local v20 = false
		v11 = function() --[[ Name: remove | Line: 108 | Upvalues: v20 (ref), v16 (ref), v19 (copy), t (ref), p1 (copy) ]]
			if v20 then
				return false
			else
				v20 = true
				v16:Disconnect()
				v16 = nil
				v19()
				table.remove(t.list, (table.find(t.list, p1)))
				t.onForceUpdate:Fire()
				return true
			end
		end
		return v11
	end
	v4.bornAt = p1.bornAt
	v4.lifetime = p1.lifetime
	v4.strength = p1.strength
	v4.worldPosition = p1.worldPosition
end
function t.init() --[[ Line: 125 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), t (copy) ]]
	waitForChild(ReplicatedStorage, "DamageIndicatorRemote"):andThen(function(p1) --[[ Line: 126 | Upvalues: t (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 127 | Upvalues: t (ref) ]]
			t.add(p1)
		end)
	end)
end
return t