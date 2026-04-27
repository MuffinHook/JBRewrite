local RunService = game:GetService("RunService")
local Validation = require(script.Parent.Validation)
local Version = require(script.Parent.Version)
local HashLib = require(script.HashLib)
local httpApiConfig = {
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
local protocol = if RunService:IsStudio() then "https" else httpApiConfig.protocol
local eventsBaseUrl = protocol .. "://" .. if RunService:IsStudio() then "sandbox-" else "" .. httpApiConfig.hostName .. "/" .. httpApiConfig.version
local configProtocol = if RunService:IsStudio() then "https" else httpApiConfig.protocol
local configsBaseUrl = configProtocol .. "://" .. if RunService:IsStudio() then "sandbox-" else "" .. httpApiConfig.hostName .. "/remote_configs/" .. httpApiConfig.remoteConfigsVersion
local function getInitAnnotations(buildVersion, deviceData, userId)
	return {
		user_id = tostring(userId) .. deviceData.CustomUserId,
		sdk_version = "roblox " .. Version.SdkVersion,
		os_version = deviceData.OS,
		platform = deviceData.Platform,
		build = buildVersion,
		session_num = deviceData.Sessions,
		random_salt = deviceData.Sessions
	}
end
local function encode(dataToEncode, secretKey)
	if secretKey then
		return HashLib.base64_encode((HashLib.hmac(HashLib.sha256, if RunService:IsStudio() then "16813a12f718bc5c620f56944e1abc3ea13ccbac" else secretKey, dataToEncode, true)))
	end
	Logger:w("Error encoding, invalid SecretKey")
end
local function processRequestResponse(response, requestType)
	local StatusCode = response.StatusCode
	local Body = response.Body
	if Body and #Body ~= 0 then
		if StatusCode == 200 then
			return httpApiConfig.EGAHTTPApiResponse.Ok
		elseif StatusCode == 201 then
			return httpApiConfig.EGAHTTPApiResponse.Created
		elseif StatusCode == 0 or StatusCode == 401 then
			Logger:d(requestType .. " request. 401 - Unauthorized.")
			return httpApiConfig.EGAHTTPApiResponse.Unauthorized
		elseif StatusCode == 400 then
			Logger:d(requestType .. " request. 400 - Bad Request.")
			return httpApiConfig.EGAHTTPApiResponse.BadRequest
		elseif StatusCode == 500 then
			Logger:d(requestType .. " request. 500 - Internal Server Error.")
			return httpApiConfig.EGAHTTPApiResponse.InternalServerError
		else
			return httpApiConfig.EGAHTTPApiResponse.UnknownResponseCode
		end
	else
		Logger:d(requestType .. " request. failed. Might be no connection. Status code: " .. tostring(StatusCode))
		return httpApiConfig.EGAHTTPApiResponse.NoResponse
	end
end
function httpApiConfig.initRequest(config, gameKey, secretKey, buildVersion, configData, userId)
	local initUrl = configsBaseUrl .. "/" .. httpApiConfig.initializeUrlPath .. "?game_key=" .. gameKey .. "&interval_seconds=0&configs_hash=" .. (configData.ConfigsHash or "")
	if RunService:IsStudio() then
		initUrl = eventsBaseUrl .. "/5c6bcb5402204249437fb5a7a80a4959/" .. config.initializeUrlPath
	end
	Logger:d("Sending \'init\' URL: " .. initUrl)
	local requestBody = HttpService:JSONEncode({
		user_id = tostring(userId) .. configData.CustomUserId,
		sdk_version = "roblox " .. Version.SdkVersion,
		os_version = configData.OS,
		platform = configData.Platform,
		build = buildVersion,
		session_num = configData.Sessions,
		random_salt = configData.Sessions
	}):gsub("\"country_code\":\"unknown\"", "\"country_code\":null")
	local bodyForHashing = requestBody
	local authorizationHash
	if secretKey then
		authorizationHash = HashLib.base64_encode((HashLib.hmac(HashLib.sha256, if RunService:IsStudio() then "16813a12f718bc5c620f56944e1abc3ea13ccbac" else secretKey, bodyForHashing, true)))
	else
		Logger:w("Error encoding, invalid SecretKey")
		authorizationHash = nil
	end
	Logger:d("init payload: " .. requestBody)
	local httpResponse = nil
	local requestSuccess, errorMessage = pcall(function()
		httpResponse = HttpService:RequestAsync({
			Url = initUrl,
			Method = "POST",
			Headers = {
				Authorization = authorizationHash,
				["Content-Type"] = "application/json"
			},
			Body = requestBody
		})
	end)
	if requestSuccess then
		Logger:d("init request content: " .. httpResponse.Body)
		local responseStatus = processRequestResponse(httpResponse, "Init")
		if responseStatus == httpApiConfig.EGAHTTPApiResponse.Ok or (responseStatus == httpApiConfig.EGAHTTPApiResponse.Created or responseStatus == httpApiConfig.EGAHTTPApiResponse.BadRequest) then
			local decodedBody = nil
			if pcall(function()
				decodedBody = HttpService:JSONDecode(httpResponse.Body)
			end) then
				if responseStatus == httpApiConfig.EGAHTTPApiResponse.BadRequest then
					Logger:d("Failed Init Call. Bad request. Response: " .. httpResponse.Body)
					return {
						statusCode = responseStatus,
						body = nil
					}
				else
					if Validation:validateAndCleanInitRequestResponse(decodedBody, responseStatus == httpApiConfig.EGAHTTPApiResponse.Created) then
						return {
							statusCode = responseStatus,
							body = decodedBody
						}
					else
						return {
							statusCode = httpApiConfig.EGAHTTPApiResponse.BadResponse,
							body = nil
						}
					end
				end
			else
				Logger:d("Failed Init Call. Json decoding failed: " .. errorMessage)
				return {
					statusCode = httpApiConfig.EGAHTTPApiResponse.JsonDecodeFailed,
					body = nil
				}
			end
		else
			Logger:d("Failed Init Call. URL: " .. initUrl .. ", JSONString: " .. requestBody .. ", Authorization: " .. authorizationHash)
			return {
				statusCode = responseStatus,
				body = nil
			}
		end
	else
		Logger:d("Failed Init Call. error: " .. errorMessage)
		return {
			statusCode = httpApiConfig.EGAHTTPApiResponse.UnknownResponseCode,
			body = nil
		}
	end
end
function httpApiConfig.sendEventsInArray(config, gameKey, secretKey, eventArray)
	if eventArray and #eventArray ~= 0 then
		local eventsUrl = eventsBaseUrl .. "/" .. gameKey .. "/" .. config.eventsUrlPath
		if RunService:IsStudio() then
			eventsUrl = eventsBaseUrl .. "/5c6bcb5402204249437fb5a7a80a4959/" .. config.eventsUrlPath
		end
		Logger:d("Sending \'events\' URL: " .. eventsUrl)
		local requestBody = HttpService:JSONEncode(eventArray):gsub("\"country_code\":\"unknown\"", "\"country_code\":null")
		local bodyForHashing = requestBody
		local authorizationHash
		if secretKey then
			authorizationHash = HashLib.base64_encode((HashLib.hmac(HashLib.sha256, if RunService:IsStudio() then "16813a12f718bc5c620f56944e1abc3ea13ccbac" else secretKey, bodyForHashing, true)))
		else
			Logger:w("Error encoding, invalid SecretKey")
			authorizationHash = nil
		end
		local httpResponse = nil
		local requestSuccess, errorMessage = pcall(function()
			httpResponse = HttpService:RequestAsync({
				Url = eventsUrl,
				Method = "POST",
				Headers = {
					Authorization = authorizationHash,
					["Content-Type"] = "application/json"
				},
				Body = requestBody
			})
		end)
		if requestSuccess then
			Logger:d("body: " .. httpResponse.Body)
			local responseStatus = processRequestResponse(httpResponse, "Events")
			if responseStatus == httpApiConfig.EGAHTTPApiResponse.Ok or (responseStatus == httpApiConfig.EGAHTTPApiResponse.Created or responseStatus == httpApiConfig.EGAHTTPApiResponse.BadRequest) then
				local decodedBody = nil
				pcall(function()
					decodedBody = HttpService:JSONDecode(httpResponse.Body)
				end)
				if decodedBody then
					if responseStatus == httpApiConfig.EGAHTTPApiResponse.BadRequest then
						Logger:d("Failed Events Call. Bad request. Response: " .. httpResponse.Body)
						return {
							statusCode = responseStatus,
							body = nil
						}
					else
						return {
							statusCode = httpApiConfig.EGAHTTPApiResponse.Ok,
							body = decodedBody
						}
					end
				else
					Logger:d("Failed Events Call. Json decoding failed")
					return {
						statusCode = httpApiConfig.EGAHTTPApiResponse.JsonDecodeFailed,
						body = nil
					}
				end
			else
				Logger:d("Failed Events Call. URL: " .. eventsUrl .. ", JSONString: " .. requestBody .. ", Authorization: " .. authorizationHash)
				return {
					statusCode = responseStatus,
					body = nil
				}
			end
		else
			Logger:d("Failed Events Call. error: " .. errorMessage)
			return {
				statusCode = httpApiConfig.EGAHTTPApiResponse.UnknownResponseCode,
				body = nil
			}
		end
	else
		Logger:d("sendEventsInArray called with missing eventArray")
	end
end
return httpApiConfig
