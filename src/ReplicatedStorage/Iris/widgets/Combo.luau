
-- Decomp Error: Iris widget module failed decompilation; shim returns a no-op registrar.
-- Logic Change: Widget behavior is intentionally disabled rather than leaving invalid source.
return function(Iris)
	return Iris
end
