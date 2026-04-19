-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeCFJlc291cmNlClN1c3BlbnNpb24ETmFtZQ5GaW5kRmlyc3RDaGlsZAVlcnJvchVObyBTdXNwZW5zaW9uIG5hbWVkOiAFQ2xvbmUGQ0ZyYW1lA25ldwtHZXRJbnN0YW5jZQJvcwVjbG9jawZBbmdsZXMEbWF0aANzaW4EU2l6ZQlNYWduaXR1ZGUGVXBkYXRlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVQcmljZQZIZWlnaHQHU2xhbW1lZANMb3cGTm9ybWFsBlJhaXNlZARIaWdoB01vbnN0ZXIFSXRlbXMAAwYBAQAAAB/7AQAATQEBYgAAAABNAQGPAQAAAE0DALoCAAAAvAEBAwMAAACfAQMCKwEHAKQCBQAAAEBAbwQGAE0FALoCAAAAcwMEBZ8CAgG8AgE6BwAAAJ8CAgJSAQIApAIKAAAkgICMAwAAjAQAAIwFAACfAgQCMAIBhQgAAACCAQIACwMBAwIDAwMEAwUEAABAQAMGAwcDCAMJBAAkgIAAIgoBGAAAAAAAAAAAAAABAQAAAAAAAAIAAAAEAAAAAAAAAAEjAAAAAA0CAAAAACWkAgIAAAQAgJ8CAQI+AwIDIQQDBKQHBwAAGFCAjAgAAFIJBACMCgAAnwcEAqQIBwAAGFCAuxgDA1IMAwCkCwwAACyggJ8LAgJbCgsJeAkKCIwKAACMCwAAnwgEAgkGBwikBw4AADRQgIwIAACMCQAATQoBLw8AAABNCgqqEAAAAJ8HBAIJBQYHMAUAhQUAAACCAAEAEQMLAwwEAAQAgAIAAAAAAAAAQAIYLURU+yEZQAMIAw0EABhQgAKamZmZmZnJPwIAAAAAAADgPwMOAw8EACyggAMJBAA0UIADEAMRAC8SARgAAAABAQEAAAAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAA/gADMAAAAAAJAAABAgBSowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BAAAGAAAA4gIHAG8DCAAwAwK6BAAAAIwDuAswAwIkBQAAAG8DCQAwAwK8BgAAAOIDBwBvBAoAMAQDugQAAACMBMQJMAQDJAUAAABvBAsAMAQDvAYAAADiBAwAbwUNADAFBLoEAAAAjAUAADAFBLwGAAAAjAUAADAFBCQFAAAA4gUHAG8GDgAwBgW6BAAAAIwGxAkwBgUkBQAAAG8GDwAwBgW8BgAAAOIGBwBvBxAAMAcGugQAAACMB7gLMAcGJAUAAABvBxEAMAcGvAYAAADiBwcAbwgSADAIB7oEAAAAjAiIEzAIByQFAAAAbwgTADAIB7wGAAAAxQECBwEAAADAAhQAEgAAAMADFQDiBBkAMAEEOBYAAAAwAgRRFwAAADADBCYYAAAAggQCABoDEwQAAABAAxQDFQMDAxYDFwUDBAUGAxgCAAAAAAAA4L8DGQIAAAAAAADQvwUDBAYFAxoDGwKamZmZmZnJPwMcAgAAAAAAAOA/Ax0CAAAAAAAA+D8GAAYBAx4DCgMSBQMWFxgCAAEBAAEYAAAAAAAAAAEAAQEAAAEAAAEAAAIBAAABAAABAAACAQAAAQAAAQAAAgEAAAEAAAEAAAIBAAABAAABAAACAQAAAQAAAQAAAAADAA0IAQABAAEAAAEAAAAAAiu+cIcWl5Llul+DVZYuNWhbpmfzGXoahg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:30
-- Luau version 6, Types version 3
-- Time taken: 0.002619 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return {
    Items = {{
        Name = "Slammed";
        Price = 3000;
        Height = -0.5;
    }, {
        Name = "Low";
        Price = 2500;
        Height = -0.25;
    }, {
        Name = "Normal";
        Height = 0;
        Price = 0;
    }, {
        Name = "Raised";
        Price = 2500;
        Height = 0.2;
    }, {
        Name = "High";
        Price = 3000;
        Height = 0.5;
    }, {
        Name = "Monster";
        Price = 5000;
        Height = 1.5;
    }};
    GetInstance = function(arg1) -- Line 34, Named "GetInstance"
        --[[ Upvalues[1]:
            [1]: ReplicatedStorage_upvr (readonly)
        ]]
        local SOME = ReplicatedStorage_upvr.Resource.Suspension:FindFirstChild(arg1.Name)
        if not SOME then
            error("No Suspension named: "..arg1.Name)
        end
        local clone = SOME:Clone()
        clone.CFrame = CFrame.new(0, 0, 0)
        return clone
    end;
    Update = function(arg1, arg2) -- Line 47, Named "Update"
        local var11 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var11 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var11) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, arg2.Size.Magnitude)
    end;
}