-- Reviewed by Claude
local t = {}
local cos = math.cos
local sin = math.sin
local delta = tick
local vector2 = Vector3.new
t.Spring = {}
t.NumberSpring = {}
t.VectorSpring = {}
local function New(p1)
	local var12 = delta()
	local vector2 = p1 or 0
	local var3 = p1 or 0
	local var4 = p1 and 0 * p1 or 0
	local var5 = 1
	local var6 = 1
	local var7 = nil
	local function PositionVelocity(p1)
		local delta = p1 - var12
		local var22 = var3 - vector2
		if var6 == 0 then
			return var3, 0
		elseif var5 < 1 then
			local var32 = (1 - var5 * var5) ^ 0.5
			local var42 = (var4 / var6 + var5 * var22) / var32
			local var52 = cos(var32 * var6 * delta)
			local var62 = sin(var32 * var6 * delta)
			local var7 = 2.718281828459045 ^ (var5 * var6 * delta)
			return vector2 + (var22 * var52 + var42 * var62) / var7, var6 * ((var32 * var42 - var5 * var22) * var52 - (var32 * var22 + var5 * var42) * var62) / var7
		else
			local var8 = var4 / var6 + var22
			local var9 = 2.718281828459045 ^ (var6 * delta)
			return vector2 + (var22 + var8 * var6 * delta) / var9, var6 * (var8 - var22 - var8 * var6 * delta) / var9
		end
	end
	var7 = setmetatable({
		Impulse = function(p1, p2)
			var7.Velocity = var7.Velocity + p2
		end,
		TimeSkip = function(p1, p2)
			local var13 = delta()
			local vector2, var32 = PositionVelocity(var13 + p2)
			var3 = vector2
			var4 = var32
			var12 = var13
		end
	}, {
		__index = function(p1, p2)
			if p2 == "Value" or (p2 == "Position" or p2 == "p") then
				local var12, _ = PositionVelocity(delta())
				return var12
			end
			if p2 == "Velocity" or p2 == "v" then
				local _, var22 = PositionVelocity(delta())
				return var22
			end
			if p2 == "Target" or p2 == "t" then
				return vector2
			end
			if p2 == "Damper" or p2 == "d" then
				return var5
			end
			if p2 == "Speed" or p2 == "s" then
				return var6
			end
			error(p2 .. " is not a valid member of Spring")
		end,
		__newindex = function(p1, p2, p3)
			local var13 = delta()
			if p2 == "Value" or (p2 == "Position" or p2 == "p") then
				local _, var22 = PositionVelocity(var13)
				var3 = p3
				var4 = var22
			elseif p2 == "Velocity" or p2 == "v" then
				local var32, _ = PositionVelocity(var13)
				var3 = var32
				var4 = p3
			elseif p2 == "Target" or p2 == "t" then
				local var42, var52 = PositionVelocity(var13)
				var3 = var42
				var4 = var52
				vector2 = p3
			elseif p2 == "Damper" or p2 == "d" then
				local var62, var7 = PositionVelocity(var13)
				var3 = var62
				var4 = var7
				var5 = if p3 < 0 then 0 elseif p3 < 1 then p3 else 1
			elseif p2 == "Speed" or p2 == "s" then
				local var9, v10 = PositionVelocity(var13)
				var3 = var9
				var4 = v10
				var6 = if p3 < 0 then 0 else p3
			else
				error(p2 .. " is not a valid member of Spring")
			end
			var12 = var13
		end
	})
	return var7
end
t.Spring.New = New
local function New_2(p1)
	return t.Spring.New(p1)
end
t.NumberSpring.New = New_2
local function New_3(p1)
	return t.Spring.New(p1 or vector2())
end
t.VectorSpring.New = New_3
return t
