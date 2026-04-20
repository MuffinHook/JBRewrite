local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local AirDropConsts = require(ReplicatedStorage.AirDrop.AirDropConsts)
local SafesConsts = require(ReplicatedStorage.Safes.SafesConsts)
return {
    [AirDropConsts.TYPE_ENUM.Easy] = {
        Title = "Easy";
        ImageId = 10313418867;
        PrimaryColor = Color3.fromRGB(211, 221, 240);
        TimeBetweenWaves = 25;
        MaxActiveDuration = 200;
        DurationToGetMaxScaling = 150;
        MaxNumGuards = 5;
        MaxWaveCount = 5;
        TimeBetweenRandomGuards = 10;
        BriefCaseOpenDuration = 25;
        MinPressDurationForReward = 5;
        NumGuardsWithItemLimits = {
            Sniper = 1;
            Shotgun = 1;
        };
        BeginningData = {
            RarityProbs = {
                [EnumRarity.Common] = 75;
                [EnumRarity.Rare] = 22;
                [EnumRarity.UltraRare] = 3;
                [EnumRarity.Epic] = 0;
                [EnumRarity.Legendary] = 0;
            };
            GuardData = {
                NumGuards = 2;
                MaxHealth = 150;
                WalkSpeed = 16;
                BulletSpread = 0.2;
                TriggerPressFreq = 1.4;
            };
            MoneyDropData = {
                NumMoneyDrops = 2;
                TotalMoneyDropped = 1000;
            };
        };
        EndingData = {
            RarityProbs = {
                [EnumRarity.Common] = 50;
                [EnumRarity.Rare] = 40;
                [EnumRarity.UltraRare] = 10;
                [EnumRarity.Epic] = 0;
                [EnumRarity.Legendary] = 0;
            };
            GuardData = {
                NumGuards = 4;
                MaxHealth = 200;
                WalkSpeed = 16;
                BulletSpread = 0.15;
                TriggerPressFreq = 2.5;
            };
            MoneyDropData = {
                NumMoneyDrops = 2;
                TotalMoneyDropped = 2000;
            };
        };
        RewardData = {{
            RarityId = EnumRarity.Rare;
            Type = "UniqueItem";
            ItemType = PlayerDataConsts.SAFE_ITEM_TYPE;
            TypeEnum = SafesConsts.TYPE_ENUM.Tier1v1;
        }, {
            RarityId = EnumRarity.Rare;
            Type = "UniqueItem";
            ItemType = PlayerDataConsts.SAFE_ITEM_TYPE;
            TypeEnum = SafesConsts.TYPE_ENUM.Tier2v1;
        }, {
            Name = "Cash Box";
            Amount = 2500;
            RarityId = EnumRarity.Common;
            Type = "Cash";
            ImageId = 4915088923;
        }, {
            Name = "Cash Box";
            Amount = 4000;
            RarityId = EnumRarity.Common;
            Type = "Cash";
            ImageId = 4915088923;
        }, {
            Name = "Nitro";
            Amount = 100;
            RarityId = EnumRarity.UltraRare;
            Type = "Nitro";
            ImageId = 10078659354;
        }};
    };
    [AirDropConsts.TYPE_ENUM.Medium] = {
        Title = "Medium";
        ImageId = 10313418867;
        PrimaryColor = Color3.fromRGB(211, 221, 240);
        TimeBetweenWaves = 35;
        MaxInactiveDuration = 600;
        MaxActiveDuration = 250;
        DurationToGetMaxScaling = 200;
        MaxNumGuards = 6;
        MaxWaveCount = 5;
        TimeBetweenRandomGuards = 10;
        BriefCaseOpenDuration = 25;
        MinPressDurationForReward = 5;
        NumGuardsWithItemLimits = {
            Sniper = 2;
            Shotgun = 2;
        };
        BeginningData = {
            RarityProbs = {
                [EnumRarity.Common] = 0;
                [EnumRarity.Rare] = 75;
                [EnumRarity.UltraRare] = 22;
                [EnumRarity.Epic] = 3;
                [EnumRarity.Legendary] = 0;
            };
            GuardData = {
                NumGuards = 3;
                MaxHealth = 150;
                WalkSpeed = 16;
                BulletSpread = 0.2;
                TriggerPressFreq = 1.4;
            };
            MoneyDropData = {
                NumMoneyDrops = 3;
                TotalMoneyDropped = 2000;
            };
        };
        EndingData = {
            RarityProbs = {
                [EnumRarity.Common] = 0;
                [EnumRarity.Rare] = 50;
                [EnumRarity.UltraRare] = 40;
                [EnumRarity.Epic] = 10;
                [EnumRarity.Legendary] = 0;
            };
            GuardData = {
                NumGuards = 4;
                MaxHealth = 200;
                WalkSpeed = 16;
                BulletSpread = 0.15;
                TriggerPressFreq = 2.5;
            };
            MoneyDropData = {
                NumMoneyDrops = 3;
                TotalMoneyDropped = 3000;
            };
        };
        RewardData = {{
            RarityId = EnumRarity.UltraRare;
            Type = "UniqueItem";
            ItemType = PlayerDataConsts.SAFE_ITEM_TYPE;
            TypeEnum = SafesConsts.TYPE_ENUM.Tier2v1;
        }, {
            RarityId = EnumRarity.UltraRare;
            Type = "UniqueItem";
            ItemType = PlayerDataConsts.SAFE_ITEM_TYPE;
            TypeEnum = SafesConsts.TYPE_ENUM.Tier3v1;
        }, {
            Name = "Cash Box";
            Amount = 4000;
            RarityId = EnumRarity.Rare;
            Type = "Cash";
            ImageId = 4915088923;
        }, {
            Name = "Cash Box";
            Amount = 7000;
            RarityId = EnumRarity.Rare;
            Type = "Cash";
            ImageId = 4915088923;
        }, {
            Name = "Nitro";
            Amount = 100;
            RarityId = EnumRarity.Epic;
            Type = "Nitro";
            ImageId = 10078659354;
        }};
    };
    [AirDropConsts.TYPE_ENUM.Hard] = {
        Title = "Hard";
        ImageId = 10313418867;
        PrimaryColor = Color3.fromRGB(211, 221, 240);
        TimeBetweenWaves = 35;
        MaxInactiveDuration = 600;
        MaxActiveDuration = 300;
        DurationToGetMaxScaling = 250;
        MaxNumGuards = 7;
        MaxWaveCount = 5;
        TimeBetweenRandomGuards = 10;
        BriefCaseOpenDuration = 25;
        MinPressDurationForReward = 5;
        NumGuardsWithItemLimits = {
            Sniper = 3;
            Shotgun = 3;
        };
        BeginningData = {
            RarityProbs = {
                [EnumRarity.Common] = 0;
                [EnumRarity.Rare] = 75;
                [EnumRarity.UltraRare] = 22;
                [EnumRarity.Epic] = 3;
                [EnumRarity.Legendary] = 0;
            };
            GuardData = {
                NumGuards = 4;
                MaxHealth = 150;
                WalkSpeed = 16;
                BulletSpread = 0.2;
                TriggerPressFreq = 1.4;
            };
            MoneyDropData = {
                NumMoneyDrops = 5;
                TotalMoneyDropped = 3000;
            };
        };
        EndingData = {
            RarityProbs = {
                [EnumRarity.Common] = 0;
                [EnumRarity.Rare] = 50;
                [EnumRarity.UltraRare] = 40;
                [EnumRarity.Epic] = 10;
                [EnumRarity.Legendary] = 0;
            };
            GuardData = {
                NumGuards = 6;
                MaxHealth = 200;
                WalkSpeed = 16;
                BulletSpread = 0.15;
                TriggerPressFreq = 2.5;
            };
            MoneyDropData = {
                NumMoneyDrops = 5;
                TotalMoneyDropped = 4000;
            };
        };
        RewardData = {{
            RarityId = EnumRarity.UltraRare;
            Type = "UniqueItem";
            ItemType = PlayerDataConsts.SAFE_ITEM_TYPE;
            TypeEnum = SafesConsts.TYPE_ENUM.Tier3v1;
        }, {
            RarityId = EnumRarity.UltraRare;
            Type = "UniqueItem";
            ItemType = PlayerDataConsts.SAFE_ITEM_TYPE;
            TypeEnum = SafesConsts.TYPE_ENUM.Tier4v1;
        }, {
            Name = "Cash Box";
            Amount = 7000;
            RarityId = EnumRarity.Rare;
            Type = "Cash";
            ImageId = 4915088923;
        }, {
            Name = "Cash Box";
            Amount = 10000;
            RarityId = EnumRarity.Rare;
            Type = "Cash";
            ImageId = 4915088923;
        }, {
            Name = "Nitro";
            Amount = 100;
            RarityId = EnumRarity.Epic;
            Type = "Nitro";
            ImageId = 10078659354;
        }};
    };
}