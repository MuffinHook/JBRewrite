-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBWVycm9yK05vIGNhdGVnb3J5IGZ1bmN0aW9uIGV4aXN0cyBvbiBzZXJ2ZXIgZm9yOiAFQXBwbHkEbmV4dAhBcHBseUFsbAZzY3JpcHQLR2V0Q2hpbGRyZW4ETmFtZQdyZXF1aXJlBlBhcmVudAhDYXRlZ29yeQ5GaW5kRmlyc3RDaGlsZAADCwUBAAAIAAEBDw8FABER+wYAAIcFBgFHBQcAAAAAgKQGAQAAAABAbwgCAFIJAQBzBwgJnwYCAVIGBQBSBwAAUggCAFIJAwBSCgQAnwYFAIIGAAADAwEEAAAAQAMCAAsDARgAAAEAAQAAAAAAAgAAAAAAAAwAAAAADwMDAAASAAMDDw8PDwgFEA8JBg8PBgQRGaQDAQAAAABA+wQAAMYFAAAXAxAAhwgABvsKAQCHCQoGDgkEAFIKCQBSCwEAnwoCAg4KCAD7CwIATQoLLwIAAABSCwgAUgwGAFINAQBSDgIAnwoFAW4D7/8BAAAAqQMBAIIDAgADAwQEAAAAQAMDABIFARgAAAAAAAEBAAIAAAAAAQAAAAAAAAD7AAgAEwAAAAALAAABAB8AAAcPBQwIDwYMCA8GIwgPByMIDwABNw8BAzUPAhYiOKMAAAD/AAIAAAAAAP8BAAAAAAAApAIBAAAAAECkAwMAAAAgQLwDA2gEAAAAnwMCAxcCBwBNBwa6BQAAAKQIBwAAAGBAUgkGAJ8IAgJqCAEHbgL4/wIAAAD/AgAAAAAAAKQEAwAAACBATQMEJAgAAABvBQkAvAMDAwoAAACfAwMCvAMDaAQAAACfAwIEZAMHAE0IB7oFAAAApAkHAAAAYEBSCgcAnwkCAmoJAghuA/j/AgAAAMADCwASAAEAMAMALwwAAADAAw0AEgABABIAAgASAAAAMAMAag4AAACCAAIADwMEBAAAAEADBgQAACBAAwcDCAMJBAAAYEADCgMLAwwGAAMDBgEDBQIAAQEAARgAAQABAAEAAAAAAAAAAQAAAAAAAP8AAwABAAAAAAAAAAAAAAABAAAAAAAA/wADAAAABwAAAAAACwEAAAAAAjbMxdbQNOy0BAivQg9YNEFyCY0L+2UWzKRRk4QwuCM6Vl06WxhKZtY=

local v0 = {};
local v1 = {};
for _, v3 in next, script:GetChildren() do
    v1[v3.Name] = require(v3);
end;
local v4 = {};
for _, v6 in script.Parent:FindFirstChild("Category"):GetChildren() do
    v4[v6.Name] = require(v6);
end;
v0.Apply = function(v7, v8, v9, v10, v11) --[[ Line: 11 ]] --[[ Name: Apply ]]
    -- upvalues: v1 (copy)
    local v12 = v1[v8];
    if v12 == nil then
        error("No category function exists on server for: " .. v8);
    end;
    return v12(v7, v9, v10, v11);
end;
v0.ApplyAll = function(v13, v14, v15) --[[ Line: 18 ]] --[[ Name: ApplyAll ]]
    -- upvalues: v1 (copy), v4 (copy), v0 (copy)
    for v16 in next, v1 do
        local v17 = v13[v16];
        local v18 = v4[v16];
        if not v18 or v18(v14) then
            v0.Apply(v17, v16, v14, v15);
        end;
    end;
    return true;
end;
return v0;