return {
    named = function(arg1) -- Line 15, Named "named"
        local var2_upvr
        if type(arg1) ~= "string" then
            var2_upvr = false
        else
            var2_upvr = true
        end
        assert(var2_upvr, "Symbols must be created using a string name!")
        var2_upvr = true
        local newproxy_result1_2 = newproxy(var2_upvr)
        var2_upvr = "Symbol(%s)":format(arg1)
        getmetatable(newproxy_result1_2).__tostring = function() -- Line 22
            return var2_upvr
        end
        return newproxy_result1_2
    end;
    unnamed = function() -- Line 33, Named "unnamed"
        local newproxy_result1 = newproxy(true)
        getmetatable(newproxy_result1).__tostring = function() -- Line 36
            return "Unnamed Symbol"
        end
        return newproxy_result1
    end;
}