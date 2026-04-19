-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBW5hbWVkBVJvYWN0B2FkZFR5cGUGdHlwZW9mBXRhYmxlAm9mCVJvYWN0VHlwZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQGU3ltYm9sBnN0cmljdAhuZXdwcm94eQdCaW5kaW5nB0VsZW1lbnQPSG9zdENoYW5nZUV2ZW50CUhvc3RFdmVudBZTdGF0ZWZ1bENvbXBvbmVudENsYXNzGVN0YXRlZnVsQ29tcG9uZW50SW5zdGFuY2ULVmlydHVhbE5vZGULVmlydHVhbFRyZWUMZ2V0bWV0YXRhYmxlB19faW5kZXgKX190b3N0cmluZwRUeXBlAAQGAQIAAAUAAgAPDwr7AQAA+wMBAE0CA1EAAAAAbwQBAFIFAABzAwQFnwICAmoCAQCCAAEAAgMBAwIAEwMBGAAAAAAAAAAAAAEUAAAAAAMBAQAABAABAA8MuywAA1ICAACkAQEAAAAAQJ8BAgLwAQMAAgAAAMYBAACCAQIA+wIAAIcBAAKCAQIAAwMEBAAAAEADBQAgBgEYAAAAAAAAAAEAAwAAIQAAAAABAAAAAAACbwAAAIIAAgABAwcAKgABGAAAKwAAAAAJAAABAhcAAAUPAAFzDwEKag8CE2EPAxddDwQZW3SjAAAApAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQECkwUAAACfAAICpAEBAAAAAECkBAMAAAAgQE0DBCQEAAAATQIDjQYAAACfAQICpAIIAAAAcECpAwEAnwICAv8DAQAAAAAAwAQJABIAAwASAAAATQUAUQoAAABvBwsAbwgMAHMGBwifBQICMAUDqAwAAABNBQBRCgAAAG8HCwBvCA0AcwYHCJ8FAgIwBQOXDQAAAE0FAFEKAAAAbwcLAG8IDgBzBgcInwUCAjAFA2YOAAAATQUAUQoAAABvBwsAbwgPAHMGBwifBQICMAUDKg8AAABNBQBRCgAAAG8HCwBvCBAAcwYHCJ8FAgIwBQOaEAAAAE0FAFEKAAAAbwcLAG8IEQBzBgcInwUCAjAFA6YRAAAATQUAUQoAAABvBwsAbwgSAHMGBwifBQICMAUDZxIAAABNBQBRCgAAAG8HCwBvCBMAcwYHCJ8FAgIwBQPfEwAAAMAFFAASAAIAMAUDvBUAAAC7PAIDUgYCAKQFFwAAAGBBnwUCAjADBW4YAAAAuzwCA1IGAgCkBRcAAABgQZ8FAgLABhkAMAYFBhoAAABSBQEAUgYDAG8HGwCfBQMBggICABwDCAQAAABAAwkEAAAgQAMKAwsDDAMNBAAAcEAGAAMBAwIDDgMPAxADEQMSAxMDFAMVBgEDBgMWBAAAYEEDFwYCAxgDGQMAAQIBAAEYAAsAAAAAAAAAAAEAAAAAAAAAAAIAAAACAAIAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAACAAAAAAAAAIAAAAAAAAABAAAAAIBAAAAAAPdwO1mdaYP7+8Eh/J+gOpnAU4jx2yBsOEHPcz4G81r1qypmMmXpEvI

local v0 = require(script.Parent.Symbol);
local v1 = require(script.Parent.strict);
local v2 = newproxy(true);
local v3 = {};
local function _(v4) --[[ Line: 19 ]] --[[ Name: addType ]]
    -- upvalues: v3 (copy), v0 (copy)
    v3[v4] = v0.named("Roact" .. v4);
end;
v3.Binding = v0.named("Roact" .. "Binding");
v3.Element = v0.named("Roact" .. "Element");
v3.HostChangeEvent = v0.named("Roact" .. "HostChangeEvent");
v3.HostEvent = v0.named("Roact" .. "HostEvent");
v3.StatefulComponentClass = v0.named("Roact" .. "StatefulComponentClass");
v3.StatefulComponentInstance = v0.named("Roact" .. "StatefulComponentInstance");
v3.VirtualNode = v0.named("Roact" .. "VirtualNode");
v3.VirtualTree = v0.named("Roact" .. "VirtualTree");
v3.of = function(v6) --[[ Line: 32 ]] --[[ Name: of ]]
    -- upvalues: v2 (copy)
    if typeof(v6) ~= "table" then
        return nil;
    else
        return v6[v2];
    end;
end;
getmetatable(v2).__index = v3;
getmetatable(v2).__tostring = function() --[[ Line: 42 ]]
    return "RoactType";
end;
v1(v3, "Type");
return v2;