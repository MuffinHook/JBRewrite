-- Reviewed by Claude
local t = {
	_canSafelyClose = true,
	_endThread = false,
	_isRunning = false,
	_blocks = {},
	_scheduledBlock = nil,
	_hasScheduledBlockRun = true
}
local Logger = require(script.Parent.Logger)
local RunService = game:GetService("RunService")
local function getScheduledBlock()
	if t._hasScheduledBlockRun or (t._scheduledBlock == nil or not (t._scheduledBlock.deadline <= tick())) then
		return nil
	else
		t._hasScheduledBlockRun = true
		return t._scheduledBlock
	end
end
local function run()
	task.spawn(function()
		Logger:d("Starting GA thread")
		while not t._endThread do
			local v1
			t._canSafelyClose = false
			if #t._blocks ~= 0 then
				for k, v in pairs(t._blocks) do
					local v2, v3 = pcall(v.block)
					if not v2 then
						Logger:e(v3)
					end
				end
				t._blocks = {}
			end
			if t._hasScheduledBlockRun or (t._scheduledBlock == nil or not (t._scheduledBlock.deadline <= tick())) then
				v1 = nil
			else
				t._hasScheduledBlockRun = true
				v1 = t._scheduledBlock
			end
			if v1 ~= nil then
				local v5, v6 = pcall(v1.block)
				if not v5 then
					Logger:e(v6)
				end
			end
			t._canSafelyClose = true
			task.wait(1)
		end
		Logger:d("GA thread stopped")
	end)
	game:BindToClose(function()
		if not RunService:IsStudio() then
			task.wait(1)
			if not t._canSafelyClose then
				repeat
					task.wait()
				until t._canSafelyClose
			end
			task.wait(3)
		end
	end)
end
function t.scheduleTimer(p1, p2, p3)
	if not p1._endThread then
		if not p1._isRunning then
			p1._isRunning = true
			run()
		end
		local t = {
			block = p3,
			deadline = tick() + p2
		}
		if p1._hasScheduledBlockRun then
			p1._scheduledBlock = t
			p1._hasScheduledBlockRun = false
		end
	end
end
function t.performTaskOnGAThread(p1, p2)
	if not p1._endThread then
		if not p1._isRunning then
			p1._isRunning = true
			run()
		end
		p1._blocks[#p1._blocks + 1] = {
			block = p2
		}
	end
end
function t.stopThread(p1)
	p1._endThread = true
end
return t
