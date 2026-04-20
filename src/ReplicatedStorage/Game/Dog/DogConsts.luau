local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Enumer_result1_2 = Enumer({"IDLE", "IDLE_PLAY", "WALK", "SPRINT", "BARK", "REST", "PET", "POINT"})
local tbl = {"GERMAN", "BULLDOG"}
local Enumer_result1 = Enumer(tbl)
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
    TAG_NAME = "Dog";
    BREED_ID_VALUE_NAME = "BreedId";
    OWNER_ID_VALUE_NAME = "OwnerId";
    TARGET_ID_VALUE_NAME = "TargetId";
    BODY_VELOCITY_NAME = "Move";
    BODY_GYRO_NAME = "Rotate";
    DAMAGE_REMOTE_NAME = "Bite";
    BARK_REMOTE_NAME = "Bark";
    ANIM_REMOTE_NAME = "Anim";
    GIVE_UP_REMOTE_NAME = "GiveUp";
    SEAT_WELD_NAME = "DogSeatWeld";
    IS_MOUNTED_NAME = "IsMounted";
    ATTACK_LEAD_TIME = 0.25;
    BARK_OPP_RADIUS = 192;
    BARK_CONFUSION_RADIUS = 32;
    GIVE_UP_AFTER_DIST = 256;
    GIVE_UP_AFTER_STUCK_FOR = 10;
    TELEPORT_AFTER_STUCK_FOR = 10;
    TELEPORT_AFTER_DIST = 200;
    STATE = Enumer({"FOLLOW", "ATTACK", "REST", "PET"});
    ATTACK_STATE = Enumer({"TO", "AWAY"});
    ANIM_STATE = Enumer_result1_2;
    ANIM_SPS = {
        [Enumer_result1.GERMAN] = {
            [Enumer_result1_2.WALK] = 5.3;
            [Enumer_result1_2.SPRINT] = 20;
        };
        [Enumer_result1.BULLDOG] = {
            [Enumer_result1_2.WALK] = 3.5;
            [Enumer_result1_2.SPRINT] = 15;
        };
    };
    LIST_BREED = tbl;
    ENUM_BREED = Enumer_result1;
    PRICE = {
        [Enumer_result1.GERMAN] = 50000;
        [Enumer_result1.BULLDOG] = 80000;
    };
    TITLE = {
        [Enumer_result1.GERMAN] = "German Shepherd";
        [Enumer_result1.BULLDOG] = "Bulldog";
    };
    IMAGE_ID = {
        [Enumer_result1.GERMAN] = 6347878911;
        [Enumer_result1.BULLDOG] = 6347879072;
    };
    BARK_SOUND_ID = {
        [Enumer_result1.GERMAN] = 6293873737;
        [Enumer_result1.BULLDOG] = 6338502764;
    };
    TOP_SPEED = {
        [Enumer_result1.GERMAN] = 50;
        [Enumer_result1.BULLDOG] = 40;
    };
    OPT_TEAM = {
        [Enumer_result1.GERMAN] = Settings.EnumTeam.Police;
        [Enumer_result1.BULLDOG] = Settings.EnumTeam.Criminal;
    };
    ANIM_ID = {
        [Enumer_result1.GERMAN] = {
            [Enumer_result1_2.IDLE] = 6252140847;
            [Enumer_result1_2.IDLE_PLAY] = 6279995452;
            [Enumer_result1_2.WALK] = 6252143393;
            [Enumer_result1_2.SPRINT] = 6257288839;
            [Enumer_result1_2.BARK] = 6293871070;
            [Enumer_result1_2.REST] = 6293999630;
            [Enumer_result1_2.POINT] = 6318248236;
            [Enumer_result1_2.PET] = 6318247355;
        };
        [Enumer_result1.BULLDOG] = {
            [Enumer_result1_2.IDLE] = 6318234238;
            [Enumer_result1_2.IDLE_PLAY] = 6318235063;
            [Enumer_result1_2.WALK] = 6318231969;
            [Enumer_result1_2.SPRINT] = 6318232952;
            [Enumer_result1_2.BARK] = 6293871070;
            [Enumer_result1_2.REST] = 6318236534;
            [Enumer_result1_2.POINT] = 6318237482;
            [Enumer_result1_2.PET] = 6318238515;
        };
    };
    BODY_VELOCITY_MAX_FORCE = Vector3.new(5000, 0, 5000);
    BODY_GYRO_MAX_TORQUE = Vector3.new(100000, 100000, 100000);
})