local newproxy_result1_upvr = newproxy(true)
getmetatable(newproxy_result1_upvr).__tostring = function() -- Line 7
    return "None"
end
return {
    None = newproxy_result1_upvr;
    merge = function(...) -- Line 11, Named "merge"
        for i = 1, select('#', ...) do
            local selected_arg = select(i, ...)
            if selected_arg ~= nil then
                for i_2, v in pairs(selected_arg) do
                    if v == newproxy_result1_upvr then
                        ({})[i_2] = nil
                    else
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        ({})[i_2] = v
                    end
                end
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
}
