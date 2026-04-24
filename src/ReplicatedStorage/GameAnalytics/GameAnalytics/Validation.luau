-- Reviewed by Claude
local t = {}
local Logger = require(script.Parent.Logger)
local Utilities = require(script.Parent.Utilities)
function t.validateCustomDimensions(p1, p2)
	return t:validateArrayOfStrings(20, 32, false, "custom dimensions", p2)
end
function t.validateDimension(p1, p2, p3)
	if Utilities:isStringNullOrEmpty(p3) then
		return true
	else
		return Utilities:stringArrayContainsString(p2, p3) and true or false
	end
end
function t.validateResourceCurrencies(p1, p2)
	if t:validateArrayOfStrings(20, 64, false, "resource currencies", p2) then
		for k, v in pairs(p2) do
			if not string.find(v, "^[A-Za-z]+$") then
				Logger:w("resource currencies validation failed: a resource currency can only be A-Z, a-z. String was: " .. v)
				return false
			end
		end
		return true
	else
		return false
	end
end
function t.validateResourceItemTypes(p1, p2)
	if t:validateArrayOfStrings(20, 32, false, "resource item types", p2) then
		for k, v in pairs(p2) do
			if not t:validateEventPartCharacters(v) then
				Logger:w("resource item types validation failed: a resource item type cannot contain other characters than A-z, 0-9, -_., ()!?. String was: " .. v)
				return false
			end
		end
		return true
	else
		return false
	end
end
function t.validateEventPartCharacters(p1, p2)
	return string.find(p2, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$") and true or false
end
function t.validateArrayOfStrings(p1, p2, p3, p4, p5, p6)
	local v1 = p5 or "Array"
	if p6 then
		if p4 or #p6 ~= 0 then
			if p2 > 0 and p2 < #p6 then
				Logger:w(v1 .. " validation failed: array cannot exceed " .. tostring(p2) .. " values. It has " .. #p6 .. " values.")
				return false
			else
				for i, v in ipairs(p6) do
					local v2
					v2 = if v then #v else 0
					if v2 == 0 then
						Logger:w(v1 .. " validation failed: contained an empty string.")
						return false
					end
					if p3 > 0 and p3 < v2 then
						Logger:w(v1 .. " validation failed: a string exceeded max allowed length (which is: " .. tostring(p3) .. "). String was: " .. v)
						return false
					end
				end
				return true
			end
		else
			Logger:w(v1 .. " validation failed: array cannot be empty.")
			return false
		end
	else
		Logger:w(v1 .. " validation failed: array cannot be nil.")
		return false
	end
end
function t.validateBuild(p1, p2)
	return t:validateShortString(p2, false) and true or false
end
function t.validateShortString(p1, p2, p3)
	if p3 and Utilities:isStringNullOrEmpty(p2) then
		return true
	else
		return not (Utilities:isStringNullOrEmpty(p2) or #p2 > 32)
	end
end
function t.validateKeys(p1, p2, p3)
	return string.find(p2, "^[A-Za-z0-9]+$") and (#p2 == 32 and (string.find(p3, "^[A-Za-z0-9]+$") and #p3 == 40)) and true or false
end
function t.validateAndCleanInitRequestResponse(p1, p2, p3)
	if p2 then
		local t = {}
		local v1 = p2.server_ts or -1
		if v1 > 0 then
			t.server_ts = v1
		end
		if p3 then
			t.configs = p2.configs or {}
			t.ab_id = p2.ab_id or ""
			t.ab_variant_id = p2.ab_variant_id or ""
		end
		return t
	else
		Logger:w("validateInitRequestResponse failed - no response dictionary.")
		return nil
	end
end
function t.validateClientTs(p1, p2)
	return not (p2 < 1000000000 or p2 > 9999999999)
end
function t.validateCurrency(p1, p2)
	if Utilities:isStringNullOrEmpty(p2) then
		return false
	else
		return string.find(p2, "^[A-Z]+$") and #p2 == 3 and true or false
	end
end
function t.validateEventPartLength(p1, p2, p3)
	if p3 and Utilities:isStringNullOrEmpty(p2) then
		return true
	elseif Utilities:isStringNullOrEmpty(p2) then
		return false
	else
		return #p2 ~= 0 and not (#p2 > 64) and true or false
	end
end
function t.validateBusinessEvent(p1, p2, p3, p4, p5, p6)
	if t:validateCurrency(p2) then
		if p3 < 0 then
			Logger:w("Validation fail - business event - amount: Cannot be less then 0. Failed amount: " .. p3)
			return false
		elseif t:validateShortString(p4, true) then
			if t:validateEventPartLength(p5, false) then
				if t:validateEventPartCharacters(p5) then
					if t:validateEventPartLength(p6, false) then
						if t:validateEventPartCharacters(p6) then
							return true
						else
							Logger:w("Validation fail - business event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p6)
							return false
						end
					else
						Logger:w("Validation fail - business event - itemId. Cannot be (null), empty or above 64 characters. String: " .. p6)
						return false
					end
				else
					Logger:w("Validation fail - business event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p5)
					return false
				end
			else
				Logger:w("Validation fail - business event - itemType: Cannot be (null), empty or above 64 characters. String: " .. p5)
				return false
			end
		else
			Logger:w("Validation fail - business event - cartType. Cannot be above 32 length. String: " .. p4)
			return false
		end
	else
		Logger:w("Validation fail - business event - currency: Cannot be (null) and need to be A-Z, 3 characters and in the standard at openexchangerates.org. Failed currency: " .. p2)
		return false
	end
end
function t.validateResourceEvent(p1, p2, p3, p4, p5, p6, p7, p8, p9)
	if p3 == p2.Source or p3 == p2.Sink then
		if Utilities:isStringNullOrEmpty(p4) then
			Logger:w("Validation fail - resource event - currency: Cannot be (null)")
			return false
		elseif Utilities:stringArrayContainsString(p8, p4) then
			if p5 > 0 then
				if Utilities:isStringNullOrEmpty(p6) then
					Logger:w("Validation fail - resource event - itemType: Cannot be (null)")
					return false
				elseif t:validateEventPartLength(p6, false) then
					if t:validateEventPartCharacters(p6) then
						if Utilities:stringArrayContainsString(p9, p6) then
							if t:validateEventPartLength(p7, false) then
								if t:validateEventPartCharacters(p7) then
									return true
								else
									Logger:w("Validation fail - resource event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p7)
									return false
								end
							else
								Logger:w("Validation fail - resource event - itemId: Cannot be (null), empty or above 64 characters. String: " .. p7)
								return false
							end
						else
							Logger:w("Validation fail - resource event - itemType: Not found in list of pre-defined available resource itemTypes. String: " .. p6)
							return false
						end
					else
						Logger:w("Validation fail - resource event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p6)
						return false
					end
				else
					Logger:w("Validation fail - resource event - itemType: Cannot be (null), empty or above 64 characters. String: " .. p6)
					return false
				end
			else
				Logger:w("Validation fail - resource event - amount: Float amount cannot be 0 or negative. Value: " .. tostring(p5))
				return false
			end
		else
			Logger:w("Validation fail - resource event - currency: Not found in list of pre-defined available resource currencies. String: " .. p4)
			return false
		end
	else
		Logger:w("Validation fail - resource event - flowType: Invalid flow type " .. tostring(p3))
		return false
	end
end
function t.validateProgressionEvent(p1, p2, p3, p4, p5, p6)
	if p3 == p2.Start or (p3 == p2.Complete or p3 == p2.Fail) then
		if Utilities:isStringNullOrEmpty(p6) or (not Utilities:isStringNullOrEmpty(p5) or Utilities:isStringNullOrEmpty(p4)) then
			if Utilities:isStringNullOrEmpty(p5) or not Utilities:isStringNullOrEmpty(p4) then
				if Utilities:isStringNullOrEmpty(p4) then
					Logger:w("Validation fail - progression event: progression01 not valid. Progressions must be set as either 01, 01+02 or 01+02+03")
					return false
				elseif t:validateEventPartLength(p4, false) then
					if t:validateEventPartCharacters(p4) then
						if Utilities:isStringNullOrEmpty(p5) then
							if Utilities:isStringNullOrEmpty(p6) then
								return true
							elseif t:validateEventPartLength(p6, false) then
								if t:validateEventPartCharacters(p6) then
									return true
								else
									Logger:w("Validation fail - progression event - progression03: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p6)
									return false
								end
							else
								Logger:w("Validation fail - progression event - progression03: Cannot be empty or above 64 characters. String: " .. p6)
								return false
							end
						elseif t:validateEventPartLength(p5, false) then
							if t:validateEventPartCharacters(p5) then
								if Utilities:isStringNullOrEmpty(p6) then
									return true
								elseif t:validateEventPartLength(p6, false) then
									if t:validateEventPartCharacters(p6) then
										return true
									else
										Logger:w("Validation fail - progression event - progression03: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p6)
										return false
									end
								else
									Logger:w("Validation fail - progression event - progression03: Cannot be empty or above 64 characters. String: " .. p6)
									return false
								end
							else
								Logger:w("Validation fail - progression event - progression02: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p5)
								return false
							end
						else
							Logger:w("Validation fail - progression event - progression02: Cannot be empty or above 64 characters. String: " .. p5)
							return false
						end
					else
						Logger:w("Validation fail - progression event - progression01: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. p4)
						return false
					end
				else
					Logger:w("Validation fail - progression event - progression01: Cannot be (null), empty or above 64 characters. String: " .. p4)
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
		Logger:w("Validation fail - progression event: Invalid progression status " .. tostring(p3))
		return false
	end
end
function t.validateEventIdLength(p1, p2)
	if not Utilities:isStringNullOrEmpty(p2) then
		local count = 0
		for v1 in string.gmatch(p2, "([^:]+)") do
			count = count + 1
		end
		return true
	end
	return false
end
function t.validateEventIdCharacters(p1, p2)
	if not Utilities:isStringNullOrEmpty(p2) then
		local count = 0
		for v1 in string.gmatch(p2, "([^:]+)") do
			count = count + 1
			local _ = count > 5 or not string.find(v1, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$")
		end
		return true
	end
	return false
end
function t.validateDesignEvent(p1, p2)
	if t:validateEventIdLength(p2) then
		if t:validateEventIdCharacters(p2) then
			return true
		else
			Logger:w("Validation fail - design event - eventId: Non valid characters. Only allowed A-z, 0-9, -_., ()!?. String: " .. p2)
			return false
		end
	else
		Logger:w("Validation fail - design event - eventId: Cannot be (null) or empty. Only 5 event parts allowed seperated by :. Each part need to be 32 characters or less. String: " .. p2)
		return false
	end
end
function t.validateLongString(p1, p2, p3)
	if p3 and Utilities:isStringNullOrEmpty(p2) then
		return true
	else
		return not (Utilities:isStringNullOrEmpty(p2) or #p2 > 8192)
	end
end
function t.validateErrorEvent(p1, p2, p3, p4)
	if p3 == p2.debug or (p3 == p2.info or (p3 == p2.warning or (p3 == p2.error or p3 == p2.critical))) then
		if t:validateLongString(p4, true) then
			return true
		else
			Logger:w("Validation fail - error event - message: Message cannot be above 8192 characters.")
			return false
		end
	else
		Logger:w("Validation fail - error event - severity: Severity was unsupported value " .. tostring(p3))
		return false
	end
end
return t
