-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaBXRpdGxlIm1pbmltYXAgbGFiZWwgbWlzc2luZyB1bmlxdWUgdGl0bGUGYXNzZXJ0B2ltYWdlSWQIcG9zaXRpb24OdXBkYXRlUG9zaXRpb24HYWRvcm5lZQttYXJrZXJDb2xvchF1cGRhdGVNYXJrZXJDb2xvcgVzY2FsZQV0YWJsZQZpbnNlcnQIYWRkTGFiZWwGaXBhaXJzD2FkZE1pbmltYXBMYWJlbAZsYWJlbHMObWlzc2luZyBsYWJlbHMFY2xvbmUQYWRkTWluaW1hcExhYmVscxJyZW1vdmVNaW5pbWFwTGFiZWwEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgAFBgIAAAAAME0DAZoAAAAAgQEDBAEAAABvBAEApAIDAAAAIECfAgMB4gQLAE0FAZoAAAAAMAUEmgAAAABNBQG2BAAAADAFBLYEAAAATQUB2wUAAAAwBQTbBQAAAE0FAfkGAAAAMAUE+QYAAABNBQE0BwAAADAFBDQHAAAATQUBSwgAAAAwBQRLCAAAAE0FAfgJAAAAMAUE+AkAAABNBQGkCgAAADAFBKQKAAAAnjQABAQAAABSAwAApAIOAAA0wICfAgMBggABAA8DAQMCAwMEAAAgQAMEAwUDBgMHAwgDCQMKBQgABAUGBwgJCgMLAwwEADTAgAAFDQEYAAAAAAAAAAABAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAAAAD4AAAKBgAAAAALAgEAAAAjTQMBmgAAAACBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwH/AgAAAAAAAKQDBQAAAEBAUgQAAJ8DAgRRAw0ATQgHmgAAAABNCQGaAAAAAPEICAAJAAAAnjQCBQcAAABSCQIAUgoHAKQICAAAHGCAnwgDAW4D8v8CAACA+wMAAFIEAgBSBQEAnwMDAYICAgAJAwEDAgMDBAAAIEADDgQAAEBAAwsDDAQAHGCAABMPARgAAAAAAAAAAAEAAQAAAAABAAAAAAABAAAAAAAA/gAFAAAAARQAAAAACwIBAAAAGU0DAT8AAAAAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBpAIGAAAUQIBSAwAAnwICAqQDCAAAAHBATQQBPwAAAACfAwIEUQMEAPsIAABSCQIAUgoHAJ8IAwFuA/v/AgAAgIICAgAJAxADEQMDBAAAIEADCwMSBAAUQIADDgQAAHBAAB4TARgAAAAAAAAAAAEAAAABAAAAAAABAAAA/wADHwAAAAALAgAAAAAfTQMBmgAAAACBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwH/AgAAAAAAAKQDBQAAAEBAUgQAAJ8DAgRRAw0ATQgHmgAAAABNCQGaAAAAAPEICAAJAAAAnjQCBQcAAABSCQIAUgoHAKQICAAAHGCAnwgDAW4D8v8CAACAggICAAkDAQMCAwMEAAAgQAMOBAAAQEADCwMMBAAcYIAAJhQBGAAAAAAAAAAAAQABAAAAAAEAAAAAAAEAAAAAAAD+AAUnAAAAAAcAAAECAB+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgLAAgcATQMB1ggAAAD/BAAAAAAAAOIFDADABg0AEgACADAGBZgJAAAAwAYOABIAAgAwBgUSCgAAAMAGDwAwBgVOCwAAAJ8DAwCCAwAAEAMVBAAAAEADFgMXAxgEAABAQAMZBgADGgMPAxMDFAUDCQoLBgEGAgYDBAABAgMBAAEYAAAAAAAAAAEAAAAAAw0AAAAAAQAAAAsAAAAIAADsAAEAAAAABE1T1O64kyYWLXO1lxI4YcI9S8Oaf5e+7w==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:35
-- Luau version 6, Types version 3
-- Time taken: 0.003243 seconds

local function addLabel_upvr(arg1, arg2) -- Line 5, Named "addLabel"
    assert(arg2.title, "minimap label missing unique title")
    table.insert(arg1, {
        title = arg2.title;
        imageId = arg2.imageId;
        position = arg2.position;
        updatePosition = arg2.updatePosition;
        adornee = arg2.adornee;
        markerColor = arg2.markerColor;
        updateMarkerColor = arg2.updateMarkerColor;
        scale = arg2.scale;
    })
end
return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addMinimapLabel = function(arg1, arg2) -- Line 19, Named "addMinimapLabel"
        --[[ Upvalues[1]:
            [1]: addLabel_upvr (readonly)
        ]]
        assert(arg2.title, "minimap label missing unique title")
        local module = {}
        for _, v in ipairs(arg1) do
            if v.title ~= arg2.title then
                table.insert(module, v)
            end
        end
        addLabel_upvr(module, arg2)
        return module
    end;
    addMinimapLabels = function(arg1, arg2) -- Line 30, Named "addMinimapLabels"
        --[[ Upvalues[1]:
            [1]: addLabel_upvr (readonly)
        ]]
        assert(arg2.labels, "missing labels")
        local clone = table.clone(arg1)
        for _, v_2 in ipairs(arg2.labels) do
            addLabel_upvr(clone, v_2)
        end
        return clone
    end;
    removeMinimapLabel = function(arg1, arg2) -- Line 38, Named "removeMinimapLabel"
        assert(arg2.title, "minimap label missing unique title")
        for _, v_3 in ipairs(arg1) do
            if v_3.title ~= arg2.title then
                table.insert({}, v_3)
            end
        end
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
})