-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Validation = require(script.Parent.Validation)
local Version = require(script.Parent.Version)
local HashLib = require(script.HashLib)
local t = {
	protocol = "https",
	hostName = "api.gameanalytics.com",
	version = "v2",
	remoteConfigsVersion = "v1",
	initializeUrlPath = "init",
	eventsUrlPath = "events",
	EGAHTTPApiResponse = {
		NoResponse = 0,
		BadResponse = 1,
		RequestTimeout = 2,
		JsonEncodeFailed = 3,
		JsonDecodeFailed = 4,
		InternalServerError = 5,
		BadRequest = 6,
		Unauthorized = 7,
		UnknownResponseCode = 8,
		Ok = 9,
		Created = 10
	}
}
local HttpService = game:GetService("HttpService")
local Logger = require(script.Parent.Logger)
local v1 = if RunService:IsStudio() then "https" else t.protocol
local v4 = v1 .. "://" .. if RunService:IsStudio() then "sandbox-" else "" .. t.hostName .. "/" .. t.version
local v5 = if RunService:IsStudio() then "https" else t.protocol
local v8 = v5 .. "://" .. if RunService:IsStudio() then "sandbox-" else "" .. t.hostName .. "/remote_configs/" .. t.remoteConfigsVersion
local function getInitAnnotations(p1, p2, p3)
	return {
		user_id = tostring(p3) .. p2.CustomUserId,
		sdk_version = "roblox " .. Version.SdkVersion,
		os_version = p2.OS,
		platform = p2.Platform,
		build = p1,
		session_num = p2.Sessions,
		random_salt = p2.Sessions
	}
end
local function encode(p1, p2)
	if p2 then
		return HashLib.base64_encode((HashLib.hmac(HashLib.sha256, if RunService:IsStudio() then "16813a12f718bc5c620f56944e1abc3ea13ccbac" else p2, p1, true)))
	end
	Logger:w("Error encoding, invalid SecretKey")
end
local function processRequestResponse(p1, p2)
	local StatusCode = p1.StatusCode
	local Body = p1.Body
	if Body and #Body ~= 0 then
		if StatusCode == 200 then
			return t.EGAHTTPApiResponse.Ok
		elseif StatusCode == 201 then
			return t.EGAHTTPApiResponse.Created
		elseif StatusCode == 0 or StatusCode == 401 then
			Logger:d(p2 .. " request. 401 - Unauthorized.")
			return t.EGAHTTPApiResponse.Unauthorized
		elseif StatusCode == 400 then
			Logger:d(p2 .. " request. 400 - Bad Request.")
			return t.EGAHTTPApiResponse.BadRequest
		elseif StatusCode == 500 then
			Logger:d(p2 .. " request. 500 - Internal Server Error.")
			return t.EGAHTTPApiResponse.InternalServerError
		else
			return t.EGAHTTPApiResponse.UnknownResponseCode
		end
	else
		Logger:d(p2 .. " request. failed. Might be no connection. Status code: " .. tostring(StatusCode))
		return t.EGAHTTPApiResponse.NoResponse
	end
end
function t.initRequest(p1, p2, p3, p4, p5, p6)
	local v1 = v8 .. "/" .. t.initializeUrlPath .. "?game_key=" .. p2 .. "&interval_seconds=0&configs_hash=" .. (p5.ConfigsHash or "")
	if RunService:IsStudio() then
		v1 = v4 .. "/5c6bcb5402204249437fb5a7a80a4959/" .. p1.initializeUrlPath
	end
	Logger:d("Sending \'init\' URL: " .. v1)
	local v2 = HttpService:JSONEncode({
		user_id = tostring(p6) .. p5.CustomUserId,
		sdk_version = "roblox " .. Version.SdkVersion,
		os_version = p5.OS,
		platform = p5.Platform,
		build = p4,
		session_num = p5.Sessions,
		random_salt = p5.Sessions
	}):gsub("\"country_code\":\"unknown\"", "\"country_code\":null")
	local v3 = v2
	local v42
	if p3 then
		v42 = HashLib.base64_encode((HashLib.hmac(HashLib.sha256, if RunService:IsStudio() then "16813a12f718bc5c620f56944e1abc3ea13ccbac" else p3, v3, true)))
	else
		Logger:w("Error encoding, invalid SecretKey")
		v42 = nil
	end
	Logger:d("init payload: " .. v2)
	local v7 = nil
	local v82, v9 = pcall(function()
		v7 = HttpService:RequestAsync({
			Url = v1,
			Method = "POST",
			Headers = {
				Authorization = v42,
				["Content-Type"] = "application/json"
			},
			Body = v2
		})
	end)
	if v82 then
		Logger:d("init request content: " .. v7.Body)
		local v10 = processRequestResponse(v7, "Init")
		if v10 == t.EGAHTTPApiResponse.Ok or (v10 == t.EGAHTTPApiResponse.Created or v10 == t.EGAHTTPApiResponse.BadRequest) then
			local v11 = nil
			if pcall(function()
				v11 = HttpService:JSONDecode(v7.Body)
			end) then
				if v10 == t.EGAHTTPApiResponse.BadRequest then
					Logger:d("Failed Init Call. Bad request. Response: " .. v7.Body)
					return {
						statusCode = v10,
						body = nil
					}
				else
					if Validation:validateAndCleanInitRequestResponse(v11, v10 == t.EGAHTTPApiResponse.Created) then
						return {
							statusCode = v10,
							body = v11
						}
					else
						return {
							statusCode = t.EGAHTTPApiResponse.BadResponse,
							body = nil
						}
					end
				end
			else
				Logger:d("Failed Init Call. Json decoding failed: " .. v9)
				return {
					statusCode = t.EGAHTTPApiResponse.JsonDecodeFailed,
					body = nil
				}
			end
		else
			Logger:d("Failed Init Call. URL: " .. v1 .. ", JSONString: " .. v2 .. ", Authorization: " .. v42)
			return {
				statusCode = v10,
				body = nil
			}
		end
	else
		Logger:d("Failed Init Call. error: " .. v9)
		return {
			statusCode = t.EGAHTTPApiResponse.UnknownResponseCode,
			body = nil
		}
	end
end
function t.sendEventsInArray(p1, p2, p3, p4)
	if p4 and #p4 ~= 0 then
		local v1 = v4 .. "/" .. p2 .. "/" .. p1.eventsUrlPath
		if RunService:IsStudio() then
			v1 = v4 .. "/5c6bcb5402204249437fb5a7a80a4959/" .. p1.eventsUrlPath
		end
		Logger:d("Sending \'events\' URL: " .. v1)
		local v2 = HttpService:JSONEncode(p4):gsub("\"country_code\":\"unknown\"", "\"country_code\":null")
		local v3 = v2
		local v42
		if p3 then
			v42 = HashLib.base64_encode((HashLib.hmac(HashLib.sha256, if RunService:IsStudio() then "16813a12f718bc5c620f56944e1abc3ea13ccbac" else p3, v3, true)))
		else
			Logger:w("Error encoding, invalid SecretKey")
			v42 = nil
		end
		local v7 = nil
		local v8, v9 = pcall(function()
			v7 = HttpService:RequestAsync({
				Url = v1,
				Method = "POST",
				Headers = {
					Authorization = v42,
					["Content-Type"] = "application/json"
				},
				Body = v2
			})
		end)
		if v8 then
			Logger:d("body: " .. v7.Body)
			local v10 = processRequestResponse(v7, "Events")
			if v10 == t.EGAHTTPApiResponse.Ok or (v10 == t.EGAHTTPApiResponse.Created or v10 == t.EGAHTTPApiResponse.BadRequest) then
				local v11 = nil
				pcall(function()
					v11 = HttpService:JSONDecode(v7.Body)
				end)
				if v11 then
					if v10 == t.EGAHTTPApiResponse.BadRequest then
						Logger:d("Failed Events Call. Bad request. Response: " .. v7.Body)
						return {
							statusCode = v10,
							body = nil
						}
					else
						return {
							statusCode = t.EGAHTTPApiResponse.Ok,
							body = v11
						}
					end
				else
					Logger:d("Failed Events Call. Json decoding failed")
					return {
						statusCode = t.EGAHTTPApiResponse.JsonDecodeFailed,
						body = nil
					}
				end
			else
				Logger:d("Failed Events Call. URL: " .. v1 .. ", JSONString: " .. v2 .. ", Authorization: " .. v42)
				return {
					statusCode = v10,
					body = nil
				}
			end
		else
			Logger:d("Failed Events Call. error: " .. v9)
			return {
				statusCode = t.EGAHTTPApiResponse.UnknownResponseCode,
				body = nil
			}
		end
	else
		Logger:d("sendEventsInArray called with missing eventArray")
	end
end
return t
