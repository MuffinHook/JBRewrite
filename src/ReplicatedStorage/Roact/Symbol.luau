-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBHR5cGUGc3RyaW5nLFN5bWJvbHMgbXVzdCBiZSBjcmVhdGVkIHVzaW5nIGEgc3RyaW5nIG5hbWUhBmFzc2VydAhuZXdwcm94eQpTeW1ib2woJXMpBmZvcm1hdAxnZXRtZXRhdGFibGUKX190b3N0cmluZwVuYW1lZAADAQABAAAEAAEADwL7AAAAggACAAAAGAABGAAAGQAAAAAFAQAAAA8AAAMDAhUCDwEPEw8CEw8iuygAA1IEAACkAwEAAAAAQJ8DAgLwAwIAAgAAAKkCAAGpAgEAgQECBAMAAABvAwMApAEFAAAAQECfAQMBpAEHAAAAYECpAgEAnwECAm8CCABSBAAAvAICjQkAAACfAgMCuzwBA1IEAQCkAwsAAACgQJ8DAgLZBAAAEgACADAEAwYMAAAAggECAA0DAQQAAABAAwIDAwMEBAAAQEADBQQAAGBAAwYDBwMIBAAAoEADCQEAEQoBGAAAAAAAAAAAAAAAAAAAAAIAAAACAAAAAAIAAAAAAAAAAAQSAAAAAAIAAAECBwAAAQ8AAQYHowAAAP8AAQAAAAAAwAEAADABAFEBAAAAggACAAIGAQMKAQEBAAEYAAgACAAADgEAAAAAAvcWTn3pVfCDxdIk6drOUwXXjoAIAAhRzLdOO0z6phb9Q7MzI6PauJU=

return {
    named = function(v0) --[[ Line: 17 ]] --[[ Name: named ]]
        assert(type(v0) == "string", "Symbols must be created using a string name!");
        local v1 = newproxy(true);
        local v2 = ("Symbol(%s)"):format(v0);
        getmetatable(v1).__tostring = function() --[[ Line: 24 ]]
            -- upvalues: v2 (copy)
            return v2;
        end;
        return v1;
    end
};