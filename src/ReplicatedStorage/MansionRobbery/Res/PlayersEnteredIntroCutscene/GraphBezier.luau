-- Reviewed by Claude
function cubicBezier(self, p2, p3, p4, p5)
	return (1 - self) ^ 3 * p2 + 3 * (1 - self) ^ 2 * self * p3 + 3 * (1 - self) * self ^ 2 * p4 + self ^ 3 * p5
end
function cubicBezierDerivative(self, p2, p3, p4, p5)
	return 3 * (1 - self) ^ 2 * (p3 - p2) + 6 * self * (1 - self) * (p4 - p3) + 3 * self ^ 2 * (p5 - p4)
end
local t = {}
t.__index = t
function t.new(self)
	local table2 = setmetatable({}, t)
	table2.keyframes = self and { unpack(self) } or {}
	return table2
end
function t.UpdateKeyframes(self, p2)
	table.clear(self.keyframes)
	table.move(p2, 1, #p2, 1, self.keyframes)
end
function t.CalculateSegmentAt(self, p2)
	local delta = p2 * (#self.keyframes - 1)
	local table2 = math.floor(delta) + 1
	local var3 = delta % 1
	if table2 < 1 then
		var3 = 0
		table2 = 1
	elseif #self.keyframes <= table2 then
		table2 = #self.keyframes - 1
		var3 = 1
	end
	return var3, self.keyframes[table2], self.keyframes[table2 + 1]
end
function t.CalculateSpeedAt(self, p2)
	local delta, table2, var3 = self:CalculateSegmentAt(p2)
	local pos = table2.pos
	local var4 = table2.pos + table2.right
	local var5 = var3.pos + var3.left
	local pos_2 = var3.pos
	local var6 = pos - var4
	local var7 = pos_2 - var5
	local var8 = pos_2.X - pos.X
	local var9 = math.abs(var6.X)
	local var10 = math.abs(var7.X)
	if var8 < var9 then
		var4 = pos - var8 / var9 * var6
	end
	if var8 < var10 then
		var5 = pos_2 - var8 / var10 * var7
	end
	local var11 = cubicBezierDerivative(delta, pos, var4, var5, pos_2)
	return var11.Y / math.sqrt(var11.X ^ 2 + var11.Y ^ 2)
end
function t.CalculatePositionAt(self, p2)
	local delta, table2, var3 = self:CalculateSegmentAt(p2)
	local pos = table2.pos
	local var4 = table2.pos + table2.right
	local var5 = var3.pos + var3.left
	local pos_2 = var3.pos
	local var6 = pos - var4
	local var7 = pos_2 - var5
	local var8 = pos_2.X - pos.X
	local var9 = math.abs(var6.X)
	local var10 = math.abs(var7.X)
	if var8 < var9 then
		var4 = pos - var8 / var9 * var6
	end
	if var8 < var10 then
		var5 = pos_2 - var8 / var10 * var7
	end
	return cubicBezier(delta, pos, var4, var5, pos_2)
end
function t.CalculateValueAt(self, p2)
	local delta = 0
	local table2 = 1
	while delta + 0.00001 < table2 do
		local var3 = (delta + table2) / 2
		if p2 < self:CalculatePositionAt(var3).X then
			table2 = var3
		else
			delta = var3
		end
	end
	local var4 = (delta + table2) / 2
	return self:CalculatePositionAt(var4).Y, var4
end
return t
