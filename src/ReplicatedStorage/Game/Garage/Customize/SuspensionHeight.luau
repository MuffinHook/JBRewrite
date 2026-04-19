-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMEBU1vZGVsFkdhcmFnZVN1c3BlbnNpb25IZWlnaHQGSGVpZ2h0DFNldEF0dHJpYnV0ZQACBgIAAAAAEg4ACQBNAgE7AAAAAG8EAQBNBQC8AgAAALwCAi4DAAAAnwIEAYIAAQBNAgE7AAAAAG8EAQCMBQAAvAICLgMAAACfAgQBggABAAQDAQMCAwMDBAACAAEYAAEAAAAAAAAAAAIAAAAAAAACAwAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAEAAQAAAAAB0JgWlUzeVWfiXHwBP8qPul9RJMAk9ptvlg1APu1zPtudu8uF0en+Vg==

return function(v0, v1) --[[ Line: 2 ]]
    if v0 then
        v1.Model:SetAttribute("GarageSuspensionHeight", v0.Height);
        return;
    else
        v1.Model:SetAttribute("GarageSuspensionHeight", 0);
        return;
    end;
end;