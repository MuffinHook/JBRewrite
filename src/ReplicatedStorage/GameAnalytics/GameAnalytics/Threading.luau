-- Reviewed by Claude
-- variables reassigned
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
			local scheduledBlock
			t._canSafelyClose = false
			if #t._blocks ~= 0 then
				for k, v in pairs(t._blocks) do
					local pcallSuccess, pcallError = pcall(v.block)
					if not pcallSuccess then
						Logger:e(pcallError)
					end
				end
				t._blocks = {}
			end
			if t._hasScheduledBlockRun or (t._scheduledBlock == nil or not (t._scheduledBlock.deadline <= tick())) then
				scheduledBlock = nil
			else
				t._hasScheduledBlockRun = true
				scheduledBlock = t._scheduledBlock
			end
			if scheduledBlock ~= nil then
				local pcallSuccess, pcallError = pcall(scheduledBlock.block)
				if not pcallSuccess then
					Logger:e(pcallError)
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
function t.scheduleTimer(self, delay, callbackBlock)
	if not self._endThread then
		if not self._isRunning then
			self._isRunning = true
			run()
		end
		local t = {
			block = callbackBlock,
			deadline = tick() + delay
		}
		if self._hasScheduledBlockRun then
			self._scheduledBlock = t
			self._hasScheduledBlockRun = false
		end
	end
end
function t.performTaskOnGAThread(self, taskBlock)
	if not self._endThread then
		if not self._isRunning then
			self._isRunning = true
			run()
		end
		self._blocks[#self._blocks + 1] = {
			block = taskBlock
		}
	end
end
function t.stopThread(self)
	self._endThread = true
end
return t
