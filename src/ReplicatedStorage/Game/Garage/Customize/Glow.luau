-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRBEdsb3cORmluZEZpcnN0Q2hpbGQIR2V0TGlnaHQFTW9kZWwEVHlwZQRNYWtlCEdldENvbG9yBE5hbWUFQ29sb3IHRW5hYmxlZARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVQYWludARHYW1lBkdhcmFnZQADBQEAAAAABm8DAACpBAEAvAEAAwEAAACfAQQAggEAAAIDAQMCAAUDARgAAAAAAAAGAAAAAAkCAQAAHAABBg8PAgYFDwYNCw8CAB0PAwIbDwQEGQ8FBhcdTQIBOwAAAABNAwERAQAAAE0EAa0CAAAAbwcDAKkIAQC8BQIDBAAAAJ8FBAIOBRAADgAMAPsHAABNBgcLBQAAAE0HALoGAAAAnwYCAjAGBaQHAAAAqQcBADAHBfAIAAAAggABAKkGAAAwBgXwCAAAAIIAAQAJAwQDBQMGAwEDAgMHAwgDCQMKAAgAARgDAAEAAQD7AAAAAAgBAQAAAAAABAABAAAAAgAAAwYAAAAABQAAAQIPAAADDwABEw8BBw0PAhAEFKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0EAL0HAAAATQMEKAgAAABNAgNRBgAAAJ8BAgLAAgkAwAMKABIAAQCCAwIACwMLBAAAAEADDAMNAw4EAABAQAMPAxADEQYABgECAAEBAAEYAAEAAAAAAAEAAAAAAAAAAAIDAAABAAAAAAKh2v9+jGvw4ZMeleo/80fk5Mn4MzBQGi8Kt1Fy05DoshxYXYJTaMHG

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Garage.Paint);
local function _(v2) --[[ Line: 5 ]] --[[ Name: GetLight ]]
    return v2:FindFirstChild("Glow", true);
end;
return function(v4, v5) --[[ Line: 8 ]]
    -- upvalues: v1 (copy)
    local l_Model_0 = v5.Model;
    local _ = v5.Type;
    local _ = v5.Make;
    local l_l_Model_0_FirstChild_0 = l_Model_0:FindFirstChild("Glow", true);
    if l_l_Model_0_FirstChild_0 then
        if v4 then
            l_l_Model_0_FirstChild_0.Color = v1.GetColor(v4.Name);
            l_l_Model_0_FirstChild_0.Enabled = true;
            return;
        else
            l_l_Model_0_FirstChild_0.Enabled = false;
        end;
    end;
end;