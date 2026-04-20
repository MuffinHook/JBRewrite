local module_upvr = {
    _canSafelyClose = true;
    _endThread = false;
    _isRunning = false;
    _blocks = {};
    _scheduledBlock = nil;
    _hasScheduledBlockRun = true;
}
local function _() -- Line 13, Named "getScheduledBlock"
    if not module_upvr._hasScheduledBlockRun and module_upvr._scheduledBlock ~= nil and module_upvr._scheduledBlock.deadline <= tick() then
        module_upvr._hasScheduledBlockRun = true
        return module_upvr._scheduledBlock
    end
    return nil
end
local Logger_upvr = require(script.Parent.Logger)
local RunService_upvr = game:GetService("RunService")
local function run_upvr() -- Line 24, Named "run"
    task.spawn(function() -- Line 26
        Logger_upvr:d("Starting GA thread")
        while not module_upvr._endThread do
            module_upvr._canSafelyClose = false
            if #module_upvr._blocks ~= 0 then
                for i, v in pairs(module_upvr._blocks) do
                    local pcall_result1_4, pcall_result2_4 = pcall(v.block)
                    if not pcall_result1_4 then
                        Logger_upvr:e(pcall_result2_4)
                    end
                end
                module_upvr._blocks = {}
            end
            local var26
            if not module_upvr._hasScheduledBlockRun and module_upvr._scheduledBlock ~= nil and module_upvr._scheduledBlock.deadline <= tick() then
                i = true
                module_upvr._hasScheduledBlockRun = i
                var26 = module_upvr
                var26 = var26._scheduledBlock
            else
                var26 = nil
            end
            if var26 ~= nil then
                local pcall_result1, pcall_result2_3 = pcall(var26.block)
                if not pcall_result1 then
                    i = Logger_upvr:e
                    i(pcall_result2_3)
                end
            end
            module_upvr._canSafelyClose = true
            task.wait(1)
        end
        Logger_upvr:d("GA thread stopped")
    end)
    game:BindToClose(function() -- Line 59
        if RunService_upvr:IsStudio() then
        else
            task.wait(1)
            if not module_upvr._canSafelyClose then
                repeat
                    task.wait()
                until module_upvr._canSafelyClose
            end
            task.wait(3)
        end
    end)
end
function module_upvr.scheduleTimer(arg1, arg2, arg3) -- Line 80
    if arg1._endThread then
    else
        if not arg1._isRunning then
            arg1._isRunning = true
            run_upvr()
        end
        local tbl_2 = {}
        tbl_2.block = arg3
        tbl_2.deadline = tick() + arg2
        if arg1._hasScheduledBlockRun then
            arg1._scheduledBlock = tbl_2
            arg1._hasScheduledBlockRun = false
        end
    end
end
function module_upvr.performTaskOnGAThread(arg1, arg2) -- Line 101
    if arg1._endThread then
    else
        if not arg1._isRunning then
            arg1._isRunning = true
            run_upvr()
        end
        local tbl = {}
        tbl.block = arg2
        arg1._blocks[#arg1._blocks + 1] = tbl
    end
end
function module_upvr.stopThread(arg1) -- Line 118
    arg1._endThread = true
end
return module_upvr