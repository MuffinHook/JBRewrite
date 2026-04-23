-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "Briefcase",
	COLLECT_REMOTE_NAME = "BriefcaseCollect",
	BORN_AT_ATTR_NAME = "BriefcaseBronAt",
	ORIGIN_ATTR_NAME = "BriefcaseOrigin",
	TARGET_ATTR_NAME = "BriefcaseTarget",
	TARGET_NORMAL_ATTR_NAME = "BriefcaseTargetNormal",
	SPEED_ATTR_NAME = "BriefcaseSpeed",
	LANDED_ATTR_NAME = "BriefcaseLanded",
	COLLECTED_ATTR_NAME = "BriefcaseCollected",
	OPEN_DURATION_ATTRIBUTE_NAME = "BriefcaseOpenTiming",
	PRESS_REMOTE_NAME = "BriefcasePress",
	RELEASE_REMOTE_NAME = "BriefcaseRelease",
	BRIEFCASE_PRESS_DURATION_ACCUMULATION_ATTRIBUTE_NAME = "BriefcasePressAccumulation",
	BRIEFCASE_CURR_PRESS_START_ATTRIBUTE_NAME = "BriefcaseCurrPressStart",
	BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME = "BriefcaseRarityProbabilities",
	BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME = "BriefcaseLandingTime",
	BRIEFCASE_ACTIVE_DURATION_START = "BriefcaseActiveStartTime",
	LAST_E_PRESS_ATTR_NAME = "BriefcaseLastEPress",
	IS_CURRENTLY_E_PRESSED_ATTR_NAME = "BriefcaseIsCurrentlyBeingPressed",
	HOLD_UPDATE_REMOTE_NAME = "BriefcaseHoldUpdate"
})