return {
    varSafe = function(arg1) -- Line 2, Named "varSafe"
        local module = {}
        for i = 1, arg1 do
            local var5 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            if i ~= 1 then
                var5 = var5.."012345689"
            end
            local randint = math.random(1, #var5)
            table.insert(module, var5:sub(randint, randint))
        end
        return table.concat(module)
    end;
}