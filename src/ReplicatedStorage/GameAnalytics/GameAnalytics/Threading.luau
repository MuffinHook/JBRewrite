local threadingService = {
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
	if threadingService._hasScheduledBlockRun or (threadingService._scheduledBlock == nil or not (threadingService._scheduledBlock.deadline <= tick())) then
		return nil
	else
		threadingService._hasScheduledBlockRun = true
		return threadingService._scheduledBlock
	end
end
local function run()
	task.spawn(function()
		Logger:d("Starting GA thread")
		while not threadingService._endThread do
			local scheduledBlock
			threadingService._canSafelyClose = false
			if #threadingService._blocks ~= 0 then
				for k, blockEntry in pairs(threadingService._blocks) do
					local pcallSuccess, pcallError = pcall(blockEntry.block)
					if not pcallSuccess then
						Logger:e(pcallError)
					end
				end
				threadingService._blocks = {}
			end
			if threadingService._hasScheduledBlockRun or (threadingService._scheduledBlock == nil or not (threadingService._scheduledBlock.deadline <= tick())) then
				scheduledBlock = nil
			else
				threadingService._hasScheduledBlockRun = true
				scheduledBlock = threadingService._scheduledBlock
			end
			if scheduledBlock ~= nil then
				local pcallSuccess, pcallError = pcall(scheduledBlock.block)
				if not pcallSuccess then
					Logger:e(pcallError)
				end
			end
			threadingService._canSafelyClose = true
			task.wait(1)
		end
		Logger:d("GA thread stopped")
	end)
	game:BindToClose(function()
		if not RunService:IsStudio() then
			task.wait(1)
			if not threadingService._canSafelyClose then
				repeat
					task.wait()
				until threadingService._canSafelyClose
			end
			task.wait(3)
		end
	end)
end
function threadingService.scheduleTimer(self, delay, callbackBlock)
	if not self._endThread then
		if not self._isRunning then
			self._isRunning = true
			run()
		end
		local scheduledBlockData = {
			block = callbackBlock,
			deadline = tick() + delay
		}
		if self._hasScheduledBlockRun then
			self._scheduledBlock = scheduledBlockData
			self._hasScheduledBlockRun = false
		end
	end
end
function threadingService.performTaskOnGAThread(self, taskBlock)
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
function threadingService.stopThread(self)
	self._endThread = true
end
return threadingService
