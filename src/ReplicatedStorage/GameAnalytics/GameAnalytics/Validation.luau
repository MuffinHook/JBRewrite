local ValidationModule = {}
local Logger = require(script.Parent.Logger)
local Utilities = require(script.Parent.Utilities)
function ValidationModule.validateCustomDimensions(self, customDimensions)
	return ValidationModule:validateArrayOfStrings(20, 32, false, "custom dimensions", customDimensions)
end
function ValidationModule.validateDimension(self, dimensionList, dimensionValue)
	if Utilities:isStringNullOrEmpty(dimensionValue) then
		return true
	else
		return Utilities:stringArrayContainsString(dimensionList, dimensionValue) and true or false
	end
end
function ValidationModule.validateResourceCurrencies(self, resourceCurrencies)
	if ValidationModule:validateArrayOfStrings(20, 64, false, "resource currencies", resourceCurrencies) then
		for k, currencyString in pairs(resourceCurrencies) do
			if not string.find(currencyString, "^[A-Za-z]+$") then
				Logger:w("resource currencies validation failed: a resource currency can only be A-Z, a-z. String was: " .. currencyString)
				return false
			end
		end
		return true
	else
		return false
	end
end
function ValidationModule.validateResourceItemTypes(self, resourceItemTypes)
	if ValidationModule:validateArrayOfStrings(20, 32, false, "resource item types", resourceItemTypes) then
		for k, itemTypeString in pairs(resourceItemTypes) do
			if not ValidationModule:validateEventPartCharacters(itemTypeString) then
				Logger:w("resource item types validation failed: a resource item type cannot contain other characters than A-z, 0-9, -_., ()!?. String was: " .. itemTypeString)
				return false
			end
		end
		return true
	else
		return false
	end
end
function ValidationModule.validateEventPartCharacters(self, eventPart)
	return string.find(eventPart, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$") and true or false
end
function ValidationModule.validateArrayOfStrings(self, minLength, maxLength, allowNull, arrayName, arrayToValidate)
	local displayName = arrayToValidate or "Array"
	if arrayToValidate then
		if allowNull or #arrayToValidate ~= 0 then
			if maxLength > 0 and maxLength < #arrayToValidate then
				Logger:w(displayName .. " validation failed: array cannot exceed " .. tostring(maxLength) .. " values. It has " .. #arrayToValidate .. " values.")
				return false
			else
				for i, stringValue in ipairs(arrayToValidate) do
					local stringLength
					stringLength = if stringValue then #stringValue else 0
					if stringLength == 0 then
						Logger:w(displayName .. " validation failed: contained an empty string.")
						return false
					end
					if minLength > 0 and minLength < stringLength then
						Logger:w(displayName .. " validation failed: a string exceeded max allowed length (which is: " .. tostring(minLength) .. "). String was: " .. stringValue)
						return false
					end
				end
				return true
			end
		else
			Logger:w(displayName .. " validation failed: array cannot be empty.")
			return false
		end
	else
		Logger:w(displayName .. " validation failed: array cannot be nil.")
		return false
	end
end
function ValidationModule.validateBuild(self, buildValue)
	return ValidationModule:validateShortString(buildValue, false) and true or false
end
function ValidationModule.validateShortString(self, stringValue, allowNullValue)
	if allowNullValue and Utilities:isStringNullOrEmpty(stringValue) then
		return true
	else
		return not (Utilities:isStringNullOrEmpty(stringValue) or #stringValue > 32)
	end
end
function ValidationModule.validateKeys(self, publicKey, privateKey)
	return string.find(publicKey, "^[A-Za-z0-9]+$") and (#publicKey == 32 and (string.find(privateKey, "^[A-Za-z0-9]+$") and #privateKey == 40)) and true or false
end
function ValidationModule.validateAndCleanInitRequestResponse(self, responseData, includeConfigs)
	if responseData then
		local cleanedResponse = {}
		local serverTimestamp = responseData.server_ts or -1
		if serverTimestamp > 0 then
			cleanedResponse.server_ts = serverTimestamp
		end
		if includeConfigs then
			cleanedResponse.configs = responseData.configs or {}
			cleanedResponse.ab_id = responseData.ab_id or ""
			cleanedResponse.ab_variant_id = responseData.ab_variant_id or ""
		end
		return cleanedResponse
	else
		Logger:w("validateInitRequestResponse failed - no response dictionary.")
		return nil
	end
end
function ValidationModule.validateClientTs(self, timestamp)
	return not (timestamp < 1000000000 or timestamp > 9999999999)
end
function ValidationModule.validateCurrency(self, currencyCode)
	if Utilities:isStringNullOrEmpty(currencyCode) then
		return false
	else
		return string.find(currencyCode, "^[A-Z]+$") and #currencyCode == 3 and true or false
	end
end
function ValidationModule.validateEventPartLength(self, eventPart, allowNullValue)
	if allowNullValue and Utilities:isStringNullOrEmpty(eventPart) then
		return true
	elseif Utilities:isStringNullOrEmpty(eventPart) then
		return false
	else
		return #eventPart ~= 0 and not (#eventPart > 64) and true or false
	end
end
function ValidationModule.validateBusinessEvent(self, currencyCode, amount, cartType, itemType, itemId)
	if ValidationModule:validateCurrency(currencyCode) then
		if amount < 0 then
			Logger:w("Validation fail - business event - amount: Cannot be less then 0. Failed amount: " .. amount)
			return false
		elseif ValidationModule:validateShortString(cartType, true) then
			if ValidationModule:validateEventPartLength(itemType, false) then
				if ValidationModule:validateEventPartCharacters(itemType) then
					if ValidationModule:validateEventPartLength(itemId, false) then
						if ValidationModule:validateEventPartCharacters(itemId) then
							return true
						else
							Logger:w("Validation fail - business event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. itemId)
							return false
						end
					else
						Logger:w("Validation fail - business event - itemId. Cannot be (null), empty or above 64 characters. String: " .. itemId)
						return false
					end
				else
					Logger:w("Validation fail - business event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. itemType)
					return false
				end
			else
				Logger:w("Validation fail - business event - itemType: Cannot be (null), empty or above 64 characters. String: " .. itemType)
				return false
			end
		else
			Logger:w("Validation fail - business event - cartType. Cannot be above 32 length. String: " .. cartType)
			return false
		end
	else
		Logger:w("Validation fail - business event - currency: Cannot be (null) and need to be A-Z, 3 characters and in the standard at openexchangerates.org. Failed currency: " .. currencyCode)
		return false
	end
end
function ValidationModule.validateResourceEvent(self, flowType, resourceReference, currency, amount, itemType, itemId, availableCurrencies, availableItemTypes)
	if flowType == resourceReference.Source or flowType == resourceReference.Sink then
		if Utilities:isStringNullOrEmpty(currency) then
			Logger:w("Validation fail - resource event - currency: Cannot be (null)")
			return false
		elseif Utilities:stringArrayContainsString(availableCurrencies, currency) then
			if amount > 0 then
				if Utilities:isStringNullOrEmpty(itemType) then
					Logger:w("Validation fail - resource event - itemType: Cannot be (null)")
					return false
				elseif ValidationModule:validateEventPartLength(itemType, false) then
					if ValidationModule:validateEventPartCharacters(itemType) then
						if Utilities:stringArrayContainsString(availableItemTypes, itemType) then
							if ValidationModule:validateEventPartLength(itemId, false) then
								if ValidationModule:validateEventPartCharacters(itemId) then
									return true
								else
									Logger:w("Validation fail - resource event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. itemId)
									return false
								end
							else
								Logger:w("Validation fail - resource event - itemId: Cannot be (null), empty or above 64 characters. String: " .. itemId)
								return false
							end
						else
							Logger:w("Validation fail - resource event - itemType: Not found in list of pre-defined available resource itemTypes. String: " .. itemType)
							return false
						end
					else
						Logger:w("Validation fail - resource event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. itemType)
						return false
					end
				else
					Logger:w("Validation fail - resource event - itemType: Cannot be (null), empty or above 64 characters. String: " .. itemType)
					return false
				end
			else
				Logger:w("Validation fail - resource event - amount: Float amount cannot be 0 or negative. Value: " .. tostring(amount))
				return false
			end
		else
			Logger:w("Validation fail - resource event - currency: Not found in list of pre-defined available resource currencies. String: " .. currency)
			return false
		end
	else
		Logger:w("Validation fail - resource event - flowType: Invalid flow type " .. tostring(flowType))
		return false
	end
end
function ValidationModule.validateProgressionEvent(self, progressionStatusEnum, progressionStatus, progression01, progression02, progression03)
	if progressionStatus == progressionStatusEnum.Start or (progressionStatus == progressionStatusEnum.Complete or progressionStatus == progressionStatusEnum.Fail) then
		if Utilities:isStringNullOrEmpty(progression03) or (not Utilities:isStringNullOrEmpty(progression02) or Utilities:isStringNullOrEmpty(progression01)) then
			if Utilities:isStringNullOrEmpty(progression02) or not Utilities:isStringNullOrEmpty(progression01) then
				if Utilities:isStringNullOrEmpty(progression01) then
					Logger:w("Validation fail - progression event: progression01 not valid. Progressions must be set as either 01, 01+02 or 01+02+03")
					return false
				elseif ValidationModule:validateEventPartLength(progression01, false) then
					if ValidationModule:validateEventPartCharacters(progression01) then
						if Utilities:isStringNullOrEmpty(progression02) then
							if Utilities:isStringNullOrEmpty(progression03) then
								return true
							elseif ValidationModule:validateEventPartLength(progression03, false) then
								if ValidationModule:validateEventPartCharacters(progression03) then
									return true
								else
									Logger:w("Validation fail - progression event - progression03: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. progression03)
									return false
								end
							else
								Logger:w("Validation fail - progression event - progression03: Cannot be empty or above 64 characters. String: " .. progression03)
								return false
							end
						elseif ValidationModule:validateEventPartLength(progression02, false) then
							if ValidationModule:validateEventPartCharacters(progression02) then
								if Utilities:isStringNullOrEmpty(progression03) then
									return true
								elseif ValidationModule:validateEventPartLength(progression03, false) then
									if ValidationModule:validateEventPartCharacters(progression03) then
										return true
									else
										Logger:w("Validation fail - progression event - progression03: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. progression03)
										return false
									end
								else
									Logger:w("Validation fail - progression event - progression03: Cannot be empty or above 64 characters. String: " .. progression03)
									return false
								end
							else
								Logger:w("Validation fail - progression event - progression02: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. progression02)
								return false
							end
						else
							Logger:w("Validation fail - progression event - progression02: Cannot be empty or above 64 characters. String: " .. progression02)
							return false
						end
					else
						Logger:w("Validation fail - progression event - progression01: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. progression01)
						return false
					end
				else
					Logger:w("Validation fail - progression event - progression01: Cannot be (null), empty or above 64 characters. String: " .. progression01)
					return false
				end
			else
				Logger:w("Validation fail - progression event: 02 found but not 01. Progression must be set as either 01, 01+02 or 01+02+03")
				return false
			end
		else
			Logger:w("Validation fail - progression event: 03 found but 01+02 are invalid. Progression must be set as either 01, 01+02 or 01+02+03.")
			return false
		end
	else
		Logger:w("Validation fail - progression event: Invalid progression status " .. tostring(progressionStatus))
		return false
	end
end
function ValidationModule.validateEventIdLength(self, eventId)
	if not Utilities:isStringNullOrEmpty(eventId) then
		local partCount = 0
		for eventPart in string.gmatch(eventId, "([^:]+)") do
			partCount = partCount + 1
		end
		return true
	end
	return false
end
function ValidationModule.validateEventIdCharacters(self, eventId)
	if not Utilities:isStringNullOrEmpty(eventId) then
		local partCount = 0
		for eventPart in string.gmatch(eventId, "([^:]+)") do
			partCount = partCount + 1
			local _ = partCount > 5 or not string.find(eventPart, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$")
		end
		return true
	end
	return false
end
function ValidationModule.validateDesignEvent(self, eventId)
	if ValidationModule:validateEventIdLength(eventId) then
		if ValidationModule:validateEventIdCharacters(eventId) then
			return true
		else
			Logger:w("Validation fail - design event - eventId: Non valid characters. Only allowed A-z, 0-9, -_., ()!?. String: " .. eventId)
			return false
		end
	else
		Logger:w("Validation fail - design event - eventId: Cannot be (null) or empty. Only 5 event parts allowed seperated by :. Each part need to be 32 characters or less. String: " .. eventId)
		return false
	end
end
function ValidationModule.validateLongString(self, stringValue, allowNullValue)
	if allowNullValue and Utilities:isStringNullOrEmpty(stringValue) then
		return true
	else
		return not (Utilities:isStringNullOrEmpty(stringValue) or #stringValue > 8192)
	end
end
function ValidationModule.validateErrorEvent(self, severityEnum, severity, message)
	if severity == severityEnum.debug or (severity == severityEnum.info or (severity == severityEnum.warning or (severity == severityEnum.error or severity == severityEnum.critical))) then
		if ValidationModule:validateLongString(message, true) then
			return true
		else
			Logger:w("Validation fail - error event - message: Message cannot be above 8192 characters.")
			return false
		end
	else
		Logger:w("Validation fail - error event - severity: Severity was unsupported value " .. tostring(severity))
		return false
	end
end
return ValidationModule
