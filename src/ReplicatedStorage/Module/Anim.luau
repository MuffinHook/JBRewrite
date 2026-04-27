local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local Anim = {}
Anim.__index = Anim
function Anim.new(duration)
	assert(duration)
	assert(duration > 0)
	local animInstance = {}
	setmetatable(animInstance, Anim)
	animInstance.Maid = Maid.new()
	animInstance.Duration = duration
	animInstance.BornAt = os.clock()
	animInstance.OnCompleted = Signal.new()
	animInstance.Maid:GiveTask(animInstance.OnCompleted)
	animInstance.OnCanceled = Signal.new()
	animInstance.Maid:GiveTask(animInstance.OnCanceled)
	animInstance.IsCompleted = false
	return animInstance
end
function Anim.Update(animInstance)
	local progress = (os.clock() - animInstance.BornAt) / animInstance.Duration
	if progress >= 1 and animInstance.IsCompleted == false then
		animInstance.IsCompleted = true
		animInstance.OnCompleted:Fire()
	end
	return math.clamp(progress, 0, 1)
end
function Anim.Destroy(animInstance)
	if animInstance.Maid ~= nil then
		local Maid = animInstance.Maid
		animInstance.Maid = nil
		if animInstance.IsCompleted == false then
			animInstance.OnCanceled:Fire()
		end
		Maid:Destroy()
	end
end
return Anim
