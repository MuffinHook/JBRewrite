return (function(arg1) -- Line 1, Named "readonlytable"
    local module = {}
    module.__index = arg1
    module.__metatable = false
    function module.__newindex(arg1_2, arg2, arg3) -- Line 5
        error("Attempt to modify read-only table: "..arg1_2..", key="..arg2..", value="..arg3)
    end
    return setmetatable({}, module)
end)({
    debug = "debug";
    info = "info";
    warning = "warning";
    error = "error";
    critical = "critical";
})