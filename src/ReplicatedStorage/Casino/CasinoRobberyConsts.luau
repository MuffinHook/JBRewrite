return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    WORKSPACE_MODEL_NAME = "Casino";
    COOLDOWN_PERIOD = 360;
    TIMEOUT_PERIOD = 210;
    OPEN_ATTR_NAME = "CasinoRobberyOpen";
    ACTIVE_ATTR_NAME = "CasinoRobberyActive";
    ACTIVE_CHANGED_AT_ATTR_NAME = "CasinoRobberyActiveChangedAt";
    COMPUTER_TAG_NAME = "CasinoComputer";
    COMPUTER_HACK_REMOTE_NAME = "CasinoComputerHack";
    LOOT_TAG_NAME = "CasinoLoot";
    LOOT_COLLECT_REMOTE_NAME = "CasinoLootCollect";
    KEYPAD_TAG_NAME = "CasinoKeypadPrompt";
    KEYPAD_SUBMIT_REMOTE_NAME = "CasinoKeypadSubmit";
    ROBBERY_MUSIC_PLAYING_ATTR_NAME = "CasinoRobberyMusicPlaying";
    TRIGGER_ALARM_REMOTE_NAME = "CasinoTriggerAlarm";
    ALARM_ENABLED_ATTR_NAME = "CasinoAlarmEnabled";
})