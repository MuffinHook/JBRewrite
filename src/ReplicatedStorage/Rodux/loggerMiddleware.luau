-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKDm91dHB1dEZ1bmN0aW9uKkFjdGlvbiBkaXNwYXRjaGVkOiAlcwpTdGF0ZSBjaGFuZ2VkIHRvOiAlcwhnZXRTdGF0ZQZmb3JtYXQKbWlkZGxld2FyZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQLcHJldHR5UHJpbnQFcHJpbnQAAwkBBAAADwAEAg8PDw8DAxACDwEAFRX7AQAAUgIAAJ8BAgL7AwEATQIDgwAAAABvAwEA+wUCAFIGAACfBQIC+wYCAPsHAwC8BwcWAgAAAJ8HAgCfBgAAvAMDjQMAAACfAwAAnwIAAYIBAgAEAwEDAgMDAwQACwABGAAAAAIAAAEAAAAAAAAAAAAAAAD/BAwAAAAAAwICAAAFAAIADw8G2QIAABIAAAASAgAAEgIBABIAAQCCAgIAAAEACgUBGAAAAAAAAAsAAAAABAAAAQILAAACDwABFA8BCgsVowAAAKQAAQAAAABApAMDAAAAIEBNAgMkBAAAAE0BAooFAAAAnwACAuIBBwCkAgkAAACAQDACAYMGAAAAwAIKABIAAQASAAAAMAIBbgsAAACCAQIADAMGBAAAAEADBwQAACBAAwgDCQMBBQEGAwoEAACAQAYBAwUBAQEAARgABAAAAAAAAAAAAQEAAAADAAAAAAwBAAAAAAKpMMPkKuOOiJv0qXD8E2q5q6f28v9qrZkN/j+rPmmlSFeunIjjC/xV

local v0 = require(script.Parent.prettyPrint);
local v1 = {
    outputFunction = print
};
v1.middleware = function(v2, v3) --[[ Line: 10 ]] --[[ Name: middleware ]]
    -- upvalues: v1 (copy), v0 (copy)
    return function(v4) --[[ Line: 11 ]]
        -- upvalues: v2 (copy), v1 (ref), v0 (ref), v3 (copy)
        local v5 = v2(v4);
        v1.outputFunction(string.format(("Action dispatched: %s\nState changed to: %s"), v0(v4), v0(v3:getState())));
        return v5;
    end;
end;
return v1;