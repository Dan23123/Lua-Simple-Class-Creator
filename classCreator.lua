-- Simple class creator

local ClassCreator = {}

function ClassCreator.new(pattern, parent)
	local class = {}
	local meta = {}
	
	for idx, value in pairs(pattern) do
		class[idx] = value
	end
	
	if (parent ~= nil) then
		pattern.__parent = parent
		for idx, value in pairs(parent) do
			class[idx] = value
		end
	end
	
	if (pattern.__init) then
		class.__init = pattern.__init
		meta.__call = function(self, ...)
			print("call:", ...)
			local obj = {base = class} -- "base" property points to class object was created with
			local objmeta = {}
			
			if (parent ~= nil) then
				for idx, value in pairs(parent) do
					if (idx ~= "__init") then
						if (idx:sub(1, 2) == "__") then
							objmeta[idx] = value
						end

						if (type(value) == "function") then
							obj[idx] = function(...)
								return value(obj, ...)
							end
						else
							obj[idx] = value
						end
					end
				end
			end
			
			for idx, value in pairs(pattern) do
				if (idx ~= "__init") then
					if (idx:sub(1, 2) == "__") then
						objmeta[idx] = value
					end

					if (type(value) == "function") then
						--[[
						Function wrapper.
						
						Caller: obj.func()
						Class: function(self, ...)
						]]
						
						obj[idx] = function(...)
							return value(obj, ...)
						end
					else
						obj[idx] = value
					end
				end
			end
			
			setmetatable(obj, objmeta)
			pattern.__init(obj, ...)

			return obj
		end
	else
		class.__init = function(...) end
		meta.__call = function(self, ...) end
	end
	
	setmetatable(class, meta)
	return class
end

return ClassCreator
