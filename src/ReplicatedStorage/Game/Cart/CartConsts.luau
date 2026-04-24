-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "Cart",
	FIRST_SEGMENT_VALUE_NAME = "FirstSegment",
	SECOND_SEGMENT_VALUE_NAME = "SecondSegment",
	UPDATED_AT_VALUE_NAME = "UpdatedAt",
	OFFSET_VALUE_NAME = "Offset",
	GRAPH_VALUE_NAME = "Graph",
	SEAT_OWNED_PART_VALUE_NAME = "OwnedPart",
	SEAT_UPDATED_AT_VALUE_NAME = "SeatUpdatedAt",
	ATTEMPT_SIT_REMOTE_NAME = "Sit"
})
