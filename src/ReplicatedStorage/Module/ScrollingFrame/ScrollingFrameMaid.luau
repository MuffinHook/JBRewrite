local module = {}
local module_upvr = {
    GiveTask = function(arg1, arg2) -- Line 23, Named "GiveTask"
        local var3 = #arg1.Tasks + 1
        arg1.Tasks[var3] = arg2
        return var3
    end;
    DoCleaning = function(arg1) -- Line 28, Named "DoCleaning"
        local Tasks = arg1.Tasks
        for i, v in pairs(Tasks) do
            if type(v) == "function" then
                v()
            elseif typeof(v) == "RBXScriptConnection" then
                v:disconnect()
            else
                v:Destroy()
            end
            Tasks[i] = nil
        end
    end;
    Destroy = module_upvr.DoCleaning;
}
local module_upvr_2 = {
    __index = function(arg1, arg2) -- Line 45, Named "__index"
        if module_upvr[arg2] then
            return module_upvr[arg2]
        end
        return arg1.Tasks[arg2]
    end;
    __newindex = function(arg1, arg2, arg3) -- Line 52, Named "__newindex"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local Tasks_2 = arg1.Tasks
        if arg3 == nil then
            if type(Tasks_2[arg2]) ~= "function" and Tasks_2[arg2] then
                if typeof(Tasks_2[arg2]) == "RBXScriptConnection" then
                    Tasks_2[arg2]:disconnect()
                else
                    Tasks_2[arg2]:Destroy()
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        elseif Tasks_2[arg2] then
            arg1[arg2] = nil
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        Tasks_2[arg2] = arg3
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
}
local function MakeMaid() -- Line 71
    return setmetatable({
        Tasks = {};
        Instances = {};
    }, module_upvr_2)
end
module.MakeMaid = MakeMaid
module.new = MakeMaid
return module