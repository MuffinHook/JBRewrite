-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJAWEBZQFpAW8BdQNzdWIFbG93ZXICYW4IZ2V0QU9yQW4AAggBAAAABwAAAQ8BAB4e4gEFAKkCAQAwAgGAAAAAAKkCAQAwAgGEAQAAAKkCAQAwAgGIAgAAAKkCAQAwAgGOAwAAAKkCAQAwAgGUBAAAAIwGAQCMBwEAvAQA8AYAAACfBAQCvAQE7wcAAACfBAIChwMBBA4DAgBvAggAggICAG8CAACCAgIACQMBAwIDAwMEAwUFBQABAgMEAwYDBwMIAAUJARgAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAGAAAAAAIAAAECBwAAAQ8AAQYHowAAAP8AAQAAAAAAwAEAADABAD8BAAAAggACAAIGAAMJAQABAAEYAAEAAwAABQEAAAAAAR7tx33+0Z0oLCmt6QZXjlNp98+hRERwgO8tgKFhspsJDFEE1Z76gSg=

return {
    getAOrAn = function(v0) --[[ Line: 5 ]] --[[ Name: getAOrAn ]]
        if ({
            a = true, 
            e = true, 
            i = true, 
            o = true, 
            u = true
        })[v0:sub(1, 1):lower()] then
            return "an";
        else
            return "a";
        end;
    end
};