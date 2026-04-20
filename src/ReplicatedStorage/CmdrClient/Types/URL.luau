local tbl_upvr = {
    Validate = function(arg1) -- Line 4, Named "Validate"
        if arg1:match("^https?://.+$") then
            return true
        end
        return false, "URLs must begin with http:// or https://"
    end;
    Parse = function(arg1) -- Line 12, Named "Parse"
        return arg1
    end;
}
local Util_upvr = require(script.Parent.Parent.Shared.Util)
return function(arg1) -- Line 17
    arg1:RegisterType("url", tbl_upvr)
    arg1:RegisterType("urls", Util_upvr.MakeListableType(tbl_upvr))
end