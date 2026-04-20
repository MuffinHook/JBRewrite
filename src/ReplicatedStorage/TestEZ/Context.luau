return {
    new = function(arg1) -- Line 7, Named "new"
        local module = {}
        local tbl_upvr = {}
        module.__index = tbl_upvr
        if arg1 then
            for i, v in pairs(getmetatable(arg1).__index) do
                tbl_upvr[i] = v
            end
        end
        function module.__newindex(arg1_2, arg2, arg3) -- Line 18
            local var11
            if tbl_upvr[arg2] ~= nil then
                var11 = false
            else
                var11 = true
            end
            assert(var11, string.format("Cannot reassign %s in context", tostring(arg2)))
            tbl_upvr[arg2] = arg3
        end
        return setmetatable({}, module)
    end;
}