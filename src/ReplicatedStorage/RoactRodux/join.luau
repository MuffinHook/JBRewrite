return function(...) -- Line 1, Named "join"
    local module = {}
    for i = 1, select('#', ...) do
        local selected_arg = select(i, ...)
        if selected_arg ~= nil then
            for i_2, v in pairs(selected_arg) do
                module[i_2] = v
            end
        end
    end
    return module
end