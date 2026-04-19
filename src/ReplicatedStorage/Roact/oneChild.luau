-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMEBG5leHQFZXJyb3IwRXhwZWN0ZWQgYXQgbW9zdCBjaGlsZCwgaGFkIG1vcmUgdGhhbiBvbmUgY2hpbGQuCG9uZUNoaWxkAAIHAQAAAA8AAAMPAQMTDwIDEw8DCgwWKwACAMYBAACCAQIApAEBAAAAAEBSAgAAnwECAysCAgDGAwAAggMCAKQDAQAAAABAUgQAAFIFAQCfAwMCDgMFAKQEAwAAACBAbwUEAIwGAgCfBAMBggICAAUDAQQAAABAAwIEAAAgQAMDAAgEARgAAQADAAAAAgEAAwAAAAACAQAAAAADCQAAAAABAAABAgcAAAEPAAECA6MAAADAAAAAggACAAEGAAEAAQABGAAHFAEAAAAAAZfYxZabVVg7pRyvApSnHom46+7hXPYdp+YrACsInd9xL7WJbYiqNaU=

return function(v0) --[[ Line: 8 ]] --[[ Name: oneChild ]]
    if not v0 then
        return nil;
    else
        local v1, v2 = next(v0);
        if not v2 then
            return nil;
        else
            if next(v0, v1) then
                error("Expected at most child, had more than one child.", 2);
            end;
            return v2;
        end;
    end;
end;