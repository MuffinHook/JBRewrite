return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    minimapSetSpawns = function(arg1, arg2) -- Line 5, Named "minimapSetSpawns"
        local module = {}
        for _, v in arg2.spawns do
            assert(v.name, "missing name")
            if not v.title then
                v.title = v.name
            end
            table.insert(module, v)
        end
        return module
    end;
})