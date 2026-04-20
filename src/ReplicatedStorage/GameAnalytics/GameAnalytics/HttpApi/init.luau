-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
local RunService = game:GetService("RunService")
local var4
if RunService:IsStudio() then
    var4 = "https"
else
    var4 = ({
        protocol = "https";
        hostName = "api.gameanalytics.com";
        version = "v2";
        remoteConfigsVersion = "v1";
        initializeUrlPath = "init";
        eventsUrlPath = "events";
        EGAHTTPApiResponse = {
            NoResponse = 0;
            BadResponse = 1;
            RequestTimeout = 2;
            JsonEncodeFailed = 3;
            JsonDecodeFailed = 4;
            InternalServerError = 5;
            BadRequest = 6;
            Unauthorized = 7;
            UnknownResponseCode = 8;
            Ok = 9;
            Created = 10;
        };
    }).protocol
end
if RunService:IsStudio() then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
if RunService:IsStudio() then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.