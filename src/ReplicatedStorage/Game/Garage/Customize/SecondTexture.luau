-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBE1ha2UFTW9kZWwOR2V0RGVzY2VuZGFudHMIQmFzZVBhcnQDSXNBBE5hbWUKU2Vjb25kQm9keQV0YWJsZQZpbnNlcnQETm9uZQZpcGFpcnMITWVzaFBhcnQACVRleHR1cmVJRA9yYnhhc3NldGlkOi8vJWQGZm9ybWF0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBEdhbWUGR2FyYWdlElNwZWNpYWxUZXh0dXJlRGF0YQtUZXh0dXJlRGF0YQACDwICAAA9AAIODw8PCAkRDwkJEQ8KNgkPCzYJAwxOAg8KRg0PC0YNDwUgNQ8GIjMPCFoJDwlaCQ8CAGYPAwJkDwQEYmZNAgGtAAAAAE0DATsBAAAA/wQAAAAAAAC8BQNHAgAAAJ8FAgRkBRAAbwwDALwKCf4EAAAAnwoDAg4KCwBNCgm6BQAAAPAKCAAGAACAnjQEBQkAAABSCwQAUgwJAKQKCQAAIHCAnwoDAW4F7/8CAAAADgA5AE0FAD8KAAAAKwU2AE0FALoFAAAAxgYAAPsIAACHBwgFRwcFAAAAAAD7CAAAhwcIBYcGBwJlAAUA+wgBAIcHCAUOBwIA+wcBAIcGBwVHBhEAAAAAgKQHDAAAALBAUggEAJ8HAgRRBwgAbw4NALwMC/4EAAAAnwwDAg4MAwBvDA4AMAwLhA8AAABuB/f/AgAAgIIAAQCkBwwAAACwQFIIBACfBwIEUQcMAG8ODQC8DAv+BAAAAJ8MAwIODAcAbwwQAFIOBgC8DAyNEQAAAJ8MAwIwDAuEDwAAAG4H8/8CAACAggABAKQFDAAAALBAUgYEAJ8FAgRRBQgAbwwNALwKCf4EAAAAnwoDAg4KAwBvCg4AMAoJhA8AAABuBff/AgAAgIIAAQASAwEDAgMDAwQDBQMGAwcDCAMJBAAgcIADCgMLBAAAsEADDAMNAw4DDwMQAAYAARgAAAEAAwABAAAAAQAAAAAAAAAAAQAAAAAAAP4ABQAAAAEAAQEAAAABAAAAAQAAAQACAAEAAAAAAQAAAAABAAD+AAAGAAAAAAEAAAAAAQAAAAAAAP4AAAcAAAAAAQAAAAABAAD+AAYHAAAAAAYAAAECDwAAAw8AARwPAQcWDwIQDR2jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNBAC9BgAAAE0DBCgHAAAATQID5wgAAACfAQICpAIFAAAAQEBNBQC9BgAAAE0EBSgHAAAATQMEBQkAAACfAgICwAMKABIAAgASAAEAggMCAAsDEQQAAABAAxIDEwMUBAAAQEADFQMWAxcDGAYAAQABAAEYAAEAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAIAAAABAAAAAAHD/q6vhWEyvvE6xDtiK+rUzetw1rbCCs+yvAh3jleLKbu+T+M5lX30

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.SpecialTextureData);
local v2 = require(l_ReplicatedStorage_0.Game.Garage.TextureData);
return function(v3, v4) --[[ Line: 6 ]]
    -- upvalues: v2 (copy), v1 (copy)
    local l_Make_0 = v4.Make;
    local l_Model_0 = v4.Model;
    local v7 = {};
    for _, v9 in l_Model_0:GetDescendants() do
        if v9:IsA("BasePart") and v9.Name == "SecondBody" then
            table.insert(v7, v9);
        end;
    end;
    if v3 and not v3.None then
        local l_Name_0 = v3.Name;
        local v11 = nil;
        if v2[l_Name_0] ~= nil then
            v11 = v2[l_Name_0][l_Make_0];
        elseif v1[l_Name_0] then
            v11 = v1[l_Name_0];
        end;
        if v11 == nil then
            for _, v13 in ipairs(v7) do
                if v13:IsA("MeshPart") then
                    v13.TextureID = "";
                end;
            end;
            return;
        else
            for _, v15 in ipairs(v7) do
                if v15:IsA("MeshPart") then
                    v15.TextureID = string.format(("rbxassetid://%d"), v11);
                end;
            end;
            return;
        end;
    else
        for _, v17 in ipairs(v7) do
            if v17:IsA("MeshPart") then
                v17.TextureID = "";
            end;
        end;
        return;
    end;
end;