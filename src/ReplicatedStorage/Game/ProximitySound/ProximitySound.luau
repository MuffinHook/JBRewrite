local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local ProximitySoundConsts = require(script.Parent.ProximitySoundConsts)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 14 | Upvalues: t (copy), Maid (copy), ProximitySoundConsts (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	if not p1:GetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME) then
		p1:SetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME, false)
	end
	if not p1:GetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME) then
		p1:SetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME, 32)
	end
	if not p1:GetAttribute(ProximitySoundConsts.MAX_VOLUME_ATTR_NAME) then
		p1:SetAttribute(ProximitySoundConsts.MAX_VOLUME_ATTR_NAME, 1)
	end
	t2._target = 0
	t2._current = 0
	local function updateEnabled() --[[ Line: 34 | Upvalues: p1 (copy), ProximitySoundConsts (ref), t2 (copy) ]]
		if p1:GetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME) then
			t2:Listen(p1)
		else
			t2._maid._stop = nil
		end
	end
	t2._maid:GiveTask(p1:GetAttributeChangedSignal(ProximitySoundConsts.ENABLED_ATTR_NAME):Connect(updateEnabled))
	if p1:GetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME) then
		t2:Listen(p1)
	else
		t2._maid._stop = nil
	end
	return t2
end
function t.Listen(p1, p2) --[[ Line: 47 | Upvalues: Interval (copy), PlayerUtils (copy), LocalPlayer (copy), ProximitySoundConsts (copy), Audio (copy) ]]
	local v1 = nil
	local v2 = false
	local v3 = nil
	local _maid = p1._maid
	_maid._listenLoop = Interval.every(0.5):Connect(function() --[[ Line: 52 | Upvalues: PlayerUtils (ref), LocalPlayer (ref), p2 (copy), ProximitySoundConsts (ref), v2 (ref), v3 (ref), v1 (ref), Audio (ref) ]]
		local v12 = PlayerUtils.getRootPart(LocalPlayer)
		if v12 and v12:IsDescendantOf(workspace) then
			local v22 = p2:GetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME)
			if (v12.Position - p2.Position).Magnitude / v22 <= 1 then
				if not v2 then
					if v3 then
						v3:cancel()
						v3 = nil
					end
					if not v1 then
						v1 = Audio.ObjectLocal(p2, p2:GetAttribute(ProximitySoundConsts.ID_ATTR_NAME), {
							Looped = true,
							Volume = 0,
							RollOffMaxDistance = v22 + 64,
							RollOffMinDistance = v22 * 0.1
						})
					end
					v2 = true
					v3 = Audio.promiseFadeTo(v1, 1, 1):andThen(function() --[[ Line: 75 | Upvalues: v3 (ref) ]]
						v3 = nil
					end)
				end
			elseif v2 then
				if v3 then
					v3:cancel()
					v3 = nil
				end
				v2 = false
				v3 = Audio.promiseFadeTo(v1, 0, 1):andThen(function() --[[ Line: 87 | Upvalues: v1 (ref) ]]
					v1:Destroy()
					v1 = nil
				end):andThen(function() --[[ Line: 91 | Upvalues: v3 (ref) ]]
					v3 = nil
				end)
			end
		end
	end)
	function _maid._stop() --[[ Line: 97 | Upvalues: _maid (copy), v3 (ref), v1 (ref), Audio (ref) ]]
		_maid._listenLoop = nil
		if v3 then
			v3:cancel()
			v3 = nil
		end
		if v1 then
			Audio.promiseFadeTo(v1, 0, 1):andThen(function() --[[ Line: 104 | Upvalues: v1 (ref) ]]
				v1:Destroy()
				v1 = nil
			end)
		end
	end
end
function t.Destroy(p1) --[[ Line: 111 ]]
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
end
return t